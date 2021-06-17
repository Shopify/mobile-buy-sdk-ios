require 'test_helper'

class GraphQLSwiftGenTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GraphQLSwiftGen::VERSION
  end

  def test_default_script_name
    GraphQLSwiftGen.new(SIMPLE_SCHEMA, **required_args).generate.each_value do |output|
      assert_match %r{\A// Generated from graphql_swift_gen gem$}, output
    end
  end

  def test_script_name_option
    GraphQLSwiftGen.new(SIMPLE_SCHEMA, script_name: 'script/update_schema', **required_args).generate.each_value do |output|
      assert_match %r{\A// Generated from script/update_schema$}, output
    end
  end

  def test_generate
    refute_empty GraphQLSwiftGen.new(LARGER_SCHEMA, **required_args).generate
  end

  private

  def required_args
    {
      nest_under: 'ExampleSchema',
    }
  end
end
