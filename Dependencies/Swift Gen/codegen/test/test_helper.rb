$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'graphql_swift_gen'
require 'graphql_schema'
require 'json'

require 'minitest/autorun'

require 'support/schema'

SIMPLE_SCHEMA = GraphQLSchema.new(Support::Schema.introspection_result(Support::Schema::NoMutationSchema))
LARGER_SCHEMA = GraphQLSchema.new(Support::Schema.introspection_result)
