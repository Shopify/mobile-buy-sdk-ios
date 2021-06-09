require 'graphql_swift_gen/reformatter'
require 'graphql_swift_gen/scalar'

require 'erb'

class GraphQLSwiftGen
  attr_reader :schema, :scalars, :script_name, :schema_name, :import_graphql_support

  def initialize(schema, custom_scalars: [], nest_under:, script_name: 'graphql_swift_gen gem', import_graphql_support: false)
    @schema = schema
    @schema_name = nest_under
    @script_name = script_name
    @scalars = (BUILTIN_SCALARS + custom_scalars).reduce({}) { |hash, scalar| hash[scalar.type_name] = scalar; hash }
    @scalars.default_proc = ->(hash, key) { DEFAULT_SCALAR }
    @import_graphql_support = import_graphql_support
  end

  def save(path)
    output = generate
    begin
      Dir.mkdir("#{path}/#{schema_name}")
    rescue Errno::EEXIST
    end
    output.each do |relative_path, file_contents|
      File.write("#{path}/#{relative_path}", file_contents)
    end
  end

  def generate
    output = {}
    output["#{schema_name}.swift"] = generate_schema_file
    %w{QUERY MUTATION}.each do |kind|
      directives_for_kind(kind).each do |directive|
        output["#{schema_name}/#{directive.classify_name}.swift"] = generate_directive(directive)
      end
    end
    schema.types.reject{ |type| type.name.start_with?('__') || type.scalar? }.each do |type|
      output["#{schema_name}/#{type.name}.swift"] = generate_type(type)
    end
    output
  end

  private

  class << self
    private

    def erb_for(template_filename)
      path = File.expand_path("../graphql_swift_gen/templates/#{template_filename}", __FILE__)
      erb = ERB.new(File.read(path))
      erb.filename = path
      erb
    end
  end

  SCHEMA_ERB = erb_for("ApiSchema.swift.erb")
  TYPE_ERB = erb_for("type.swift.erb")
  DIRECTIVE_ERB = erb_for("directive.swift.erb")
  private_constant :SCHEMA_ERB, :TYPE_ERB, :DIRECTIVE_ERB

  DEFAULT_SCALAR = Scalar.new(type_name: nil, swift_type: 'String', json_type: 'String')
  private_constant :DEFAULT_SCALAR

  BUILTIN_SCALARS = [
    Scalar.new(
      type_name: 'Int',
      swift_type: 'Int32',
      json_type: 'Int',
      deserialize_expr: ->(expr) { "Int32(#{expr})" },
    ),
    Scalar.new(
      type_name: 'Float',
      swift_type: 'Double',
      json_type: 'Double',
    ),
    Scalar.new(
      type_name: 'String',
      swift_type: 'String',
      json_type: 'String',
    ),
    Scalar.new(
      type_name: 'Boolean',
      swift_type: 'Bool',
      json_type: 'Bool',
    ),
    Scalar.new(
      type_name: 'ID',
      swift_type: 'GraphQL.ID',
      json_type: 'String',
      serialize_expr: ->(expr) { "#{expr}.rawValue" },
      deserialize_expr: ->(expr) { "GraphQL.ID(rawValue: #{expr})" },
    ),
  ]
  private_constant :BUILTIN_SCALARS

  # From: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html
  RESERVED_WORDS = [
    "associatedtype", "class", "deinit", "enum", "extension", "fileprivate", "func", "import", "init", "inout", "internal", "let", "open", "operator", "private", "protocol", "public", "static", "struct", "subscript", "typealias", "var",
    "break", "case", "continue", "default", "defer", "do", "else", "fallthrough", "for", "guard", "if", "in", "repeat", "return", "switch", "where", "while",
    "as", "Any", "catch", "false", "is", "nil", "rethrows", "super", "self", "Self", "throw", "throws", "true", "try",
    "associativity", "convenience", "dynamic", "didSet", "final", "get", "infix", "indirect", "lazy", "left", "mutating", "none", "nonmutating", "optional", "override", "postfix", "precedence", "prefix", "Protocol", "required", "right", "set", "Type", "unowned", "weak", "willSet"
  ]
  private_constant :RESERVED_WORDS

  def escape_reserved_word(word)
    return word unless RESERVED_WORDS.include?(word)
    return "`#{word}`"
  end

  def generate_schema_file
    reformat(SCHEMA_ERB.result(binding))
  end

  def generate_type(type)
    reformat(TYPE_ERB.result(binding))
  end

  def generate_directive(directive)
    reformat(DIRECTIVE_ERB.result(binding))
  end

  def reformat(code)
    Reformatter.new(indent: "\t").reformat(code)
  end

  def swift_input_type(type, non_null: false, wrapped: false)
    code = case type.kind
    when 'NON_NULL'
      return swift_input_type(type.of_type, non_null: true, wrapped: wrapped)
    when 'SCALAR'
      scalars[type.name].swift_type
    when 'LIST'
      "[#{swift_input_type(type.of_type, non_null: true, wrapped: wrapped)}]"
    when 'INPUT_OBJECT', 'ENUM'
      type.name
    else
      raise NotImplementedError, "Unhandled #{type.kind} input type"
    end

    if wrapped
      if !non_null
        code = "Input<#{code}>"
      end
    else
      code += "?" unless non_null
    end
    code
  end

  def swift_json_type(type, non_null: false)
    if !non_null && !type.non_null?
      return 'Any'
    end
    case type.kind
    when "NON_NULL"
      swift_json_type(type.of_type, non_null: true)
    when 'SCALAR'
      scalars[type.name].json_type
    when 'OBJECT', 'INTERFACE', 'UNION'
      "[String: Any]"
    when 'LIST'
      "[#{swift_json_type(type.of_type)}]"
    when 'ENUM'
      'String'
    else
      raise NotImplementedError, "Unexpected #{type.kind} response type"
    end
  end

  def swift_output_type(type, non_null: false)
    code = case type.kind
    when 'NON_NULL'
      return swift_output_type(type.of_type, non_null: true)
    when 'SCALAR'
      scalars[type.name].swift_type
    when 'LIST'
      "[#{swift_output_type(type.of_type)}]"
    when 'OBJECT', 'ENUM'
      "#{schema_name}.#{type.name}"
    when 'INTERFACE', 'UNION'
      type.name
    else
      raise NotImplementedError, "Unhandled #{type.kind} response type"
    end
    code += "?" unless non_null
    code
  end

  def directives_for_kind(kind)
    schema.directives.select do |directive|
      directive.locations.include?(kind)
    end
  end

  def swift_root_directive_args(operation_type)
    directives_for_kind(operation_type)
      .map { |directive| "#{directive.name}: #{directive.classify_name}Directive? = nil" }
  end

  def generate_build_input_code(expr, type, wrap: true)
    case type.kind
    when 'SCALAR'
      scalars[type.name].serialize_expr(expr)
    when 'ENUM'
      "\\(#{expr}.rawValue)"
    when 'LIST'
      map_block = generate_build_input_code('$0', type.of_type.unwrap_non_null)
      map_code = map_block == '$0' ? expr : "#{expr}.map{ \"#{map_block}\" }"
      elements = "#{map_code}.joined(separator: \",\")"
      "[\\(#{elements})]"
    when 'INPUT_OBJECT'
      "\\(#{expr}.serialize())"
    else
      raise NotImplementedError, "Unexpected #{type.kind} argument type"
    end
  end

  def deserialize_value_code(class_name, field_name, expr, type, untyped: true)
    statements = ""

    if untyped
      json_type = swift_json_type(type.unwrap_non_null, non_null: true)
      statements << "if #{expr} is NSNull { return nil }\n" unless type.non_null?
      statements << <<-SWIFT
        guard let value = #{expr} as? #{json_type} else {
          throw SchemaViolationError(type: #{class_name}.self, field: fieldName, value: fieldValue)
        }
      SWIFT
      expr = 'value'
    end
    type = type.unwrap_non_null

    statements << "return " + case type.kind
    when 'SCALAR'
      scalars[type.name].deserialize_expr(expr)
    when 'LIST'
      untyped = !type.of_type.non_null?
      rethrow = "try " if %w(OBJECT INTERFACE UNION).include?(type.unwrap.kind) || untyped
      sub_statements = "#{rethrow}#{expr}.map { #{deserialize_value_code(class_name, field_name, '$0', type.of_type, untyped: untyped)} }"
      sub_statements += " as [Any?]" if untyped
      sub_statements
    when 'OBJECT'
      "try #{type.name}(fields: #{expr})"
    when 'INTERFACE', 'UNION'
      "try Unknown#{type.name}.create(fields: #{expr})"
    when 'ENUM'
      "#{escape_reserved_word(type.name)}(rawValue: #{expr}) ?? .unknownValue"
    else
      raise NotImplementedError, "Unexpected #{type.kind} argument type"
    end
  end

  def generate_input_init(type)
    text = "public static func create("
	input_fields = type.required_input_fields + type.optional_input_fields
    input_fields.each do |field|
      text << escape_reserved_word(field.camelize_name)
      text << ": "
      text << swift_input_type(field.type, wrapped: true)
      text << (field.type.non_null? ? "" : " = .undefined")
      text << (field == input_fields.last ? "" : ", ")
    end

    text << ") -> #{type.name} {"
    text << "\n"
	text << "return #{type.name}("
	text << input_fields.map { |field|
	  "#{field.name}: #{field.name}"
	}.join(", ")
	text << ")\n"
    text << "}"
  end

  def deprecated_input_init_required(type)
  	type.input_fields.each do |field|
      unless field.type.non_null?
        return true
      end
    end
    false
  end

  def generate_private_input_init(type)
    text = "private init("
    input_fields = type.required_input_fields + type.optional_input_fields
    input_fields.each do |field|
      text << escape_reserved_word(field.camelize_name)
      text << ": "
      text << swift_input_type(field.type, wrapped: true)
      text << (field.type.non_null? ? "" : " = .undefined")
      text << (field == input_fields.last ? "" : ", ")
    end
    text << ")"
    text << " {\n"
      type.input_fields.each do |field|
        name = escape_reserved_word(field.camelize_name)
        text << "self." + name + " = " + name
        text << "\n"
      end
    text << "}"
  end

  def generate_deprecated_input_init(type)
  	convenience = deprecated_input_init_required(type) ? "convenience " : ""
  	deprecation = deprecated_input_init_required(type) ? "@available(*, deprecated, message: \"Use the static create() method instead.\")\n" : ""
    text = "#{deprecation}public #{convenience}init("
      input_fields = type.required_input_fields + type.optional_input_fields
      input_fields.each do |field|
        text << escape_reserved_word(field.camelize_name)
        text << ": "
        text << swift_input_type(field.type, wrapped: false)
        text << (field.type.non_null? ? "" : " = nil")
        text << (field == input_fields.last ? "" : ", ")
      end
    text << ")"
    text << " {\n"

      if deprecated_input_init_required(type)
      	text << "self.init("
		text << input_fields.map { |field|
		  param = "#{field.name}: #{field.name}"
		  if !field.type.non_null?
			param << ".orUndefined"
		  end
		  param
		}.join(", ")
		text << ")\n"
      else
		type.input_fields.each do |field|
		  name = escape_reserved_word(field.camelize_name)
		  text << "self." + name + " = " + name
		  if !field.type.non_null?
			text << ".orUndefined"
		  end
		  text << "\n"
		end
	  end
    text << "}"
  end

  def remove_linebreaks(text)
    text.gsub("\n", " ")
  end

  def input_field_description(type)
    unless type.input_fields.count == 0
      text = "/// - parameters:" + ""
      type.input_fields.each do |field|
        description = (field.description.nil? ? "No description" : remove_linebreaks(field.description))
        text << "\n///     - " + field.name + ": " + description
      end
      text << "\n///"
      text
    end
  end

  def swift_arg_defs(field)
    defs = ["alias: String? = nil"]
    field.args.each do |arg|
      arg_def = "#{escape_reserved_word(arg.name)}: #{swift_input_type(arg.type)}"
      arg_def << " = nil" unless arg.type.non_null?
      defs << arg_def
    end
    if field.subfields?
      defs << "_ subfields: (#{field.type.unwrap.name}Query) -> Void"
    end
    defs.join(', ')
  end

  def swift_directive_arg_defs(directive)
    defs = []
    directive.args.each do |arg|
      arg_def = "#{escape_reserved_word(arg.name)}: #{swift_input_type(arg.type)}"
      arg_def << " = nil" unless arg.type.non_null?
      defs << arg_def
    end
    defs.join(', ')
  end

  def generate_append_objects_code(expr, type, non_null: false)
    if type.non_null?
      non_null = true
      type = type.of_type
    end
    unless non_null
      return "if let value = #{expr} {\n#{generate_append_objects_code('value', type, non_null: true)}\n}"
    end
    return "#{expr}.forEach {\n#{generate_append_objects_code('$0', type.of_type)}\n}" if type.list?

    abstract_response = type.object? ? expr : "(#{expr} as! GraphQL.AbstractResponse)"
    "response.append(#{abstract_response})\n" \
      "response.append(contentsOf: #{abstract_response}.childResponseObjectMap())"
  end

  def swift_attributes(deprecatable)
    return unless deprecatable.deprecated?
    if deprecatable.deprecation_reason
      message_argument = ", message:#{deprecatable.deprecation_reason.inspect}"
    end
    "@available(*, deprecated#{message_argument})\n"
  end

  def swift_doc(element, include_args=true)
    doc = ''

    unless element.description.nil?
      description = element.description
      description = wrap_text(description, '/// ')
      doc << "\n\n" + description
    end

  	if include_args && element.respond_to?(:args)
  	  if element.args.count > 0
		doc << "\n///\n"
		doc << "/// - parameters:"
		element.args.each do |arg|
		  doc << "\n"
		  doc << '///     - ' + arg.name + ': ' + (arg.description.nil? ? "No description" : format_arg_list(arg.description, 7))
		end
		doc << "\n///"
  	  end
  	end
    doc
  end

  def wrap_text(text, prefix, width=80)
    container = ''
    line = "" + prefix

    parts = text.split(" ")
    parts.each do |part|
      if line.length + part.length < width
        line << part
        line << ' '
      else
    	container << line
    	container << "\n"
    	line = "" + prefix
    	line << part
        line << ' '
      end
    end

    if line.length > 0
      container << line
    end
    container
  end

  def format_arg_list(text, spacing)
	parts = text.split("\n")
	commented = parts.drop(1).map do |part|
	  "/// " + (" " * spacing) + part
	end
	commented.unshift(parts.first)
	commented.join("\n")
  end

  def swift_protocols(type)
    return ", #{type.name}" unless type.object?
    interfaces = abstract_types.fetch(type.name)
    return "" if interfaces.empty?
    ", #{interfaces.to_a.join(', ')}"
  end

  def abstract_types
    @abstract_types ||= schema.types.each_with_object({}) do |type, result|
      case type.kind
      when 'OBJECT'
        result[type.name] ||= Set.new
      when 'INTERFACE', 'UNION'
        type.possible_types.each do |possible_type|
          (result[possible_type.name] ||= Set.new).add(type.name)
        end
      end
    end
  end
end
