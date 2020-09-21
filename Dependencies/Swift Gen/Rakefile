require "bundler/gem_tasks"

task test: :generate do |t|
  Dir.chdir('codegen') do
    system('rake', 'test') || abort
  end
  Dir.chdir('support') do
    system('swift', 'test') || abort
  end
end

task :generate do
  require 'graphql_schema'
  require 'graphql_swift_gen'
  require_relative 'codegen/test/support/schema'

  FileUtils.rm_rf(Dir.glob("support/Tests/GraphQLSupportTests/Generated*"))
  schema = GraphQLSchema.new(Support::Schema.introspection_result)
  GraphQLSwiftGen.new(schema,
    nest_under: 'Generated',
    import_graphql_support: true,
    custom_scalars: [
      GraphQLSwiftGen::Scalar.new(
        type_name: 'Time',
        swift_type: 'Date',
        deserialize_expr: ->(expr) { "iso8601DateParser.date(from: #{expr})!" },
        serialize_expr: ->(expr) { "iso8601DateParser.string(from: #{expr})" },
      ),
    ]
   ).save("support/Tests/GraphQLSupportTests")
end

task :default => :test
