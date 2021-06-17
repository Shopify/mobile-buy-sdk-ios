class GraphQLSwiftGen
  class Scalar
    attr_reader :type_name, :swift_type, :json_type

    def initialize(type_name:, swift_type:, json_type: 'String', serialize_expr: nil, deserialize_expr: nil)
      @type_name = type_name
      @swift_type = swift_type
      @json_type = json_type
      @serialize_expr = serialize_expr || ->(expr) { expr }
      @deserialize_expr = deserialize_expr || ->(expr) { expr }
    end

    def serialize_expr(expr)
      expr = @serialize_expr.call(expr)
      if json_type == 'String'
        expr = "\"\\(#{expr})\"" unless swift_type == 'String'
        expr = "GraphQL.quoteString(input: #{expr})"
      end
      "\\(#{expr})"
    end

    def deserialize_expr(expr)
      @deserialize_expr.call(expr)
    end
  end
end
