# GraphQLSwiftGen
[![Build Status](https://travis-ci.org/Shopify/graphql_swift_gen.svg?branch=master)](https://travis-ci.org/Shopify/graphql_swift_gen)

Generate swift code for any specific GraphQL schema that provides
query builders and response classes.

## Installation

The code generator requires ruby version 2.1 or later.

Until this project is released, it is recommended to include it into
a project as a git submodule.

    $ git submodule https://github.com/Shopify/graphql_swift_gen.git

It is recommended to use [bundler](http://bundler.io/) to install
the code generators ruby package.

Add this line to your application's Gemfile:

```ruby
gem 'graphql_swift_gen', path: 'graphql_swift_gen'
```

And then execute:

    $ bundle

The generated code depends on support/Sources/GraphQL.swift from
this repo which should be added to the project along with the
generated code.

## Usage

Create a script that generates the code for a GraphQL API

```ruby
require 'graphql_swift_gen'
require 'graphql_schema'
require 'json'

introspection_result = File.read("graphql_schema.json")
schema = GraphQLSchema.new(JSON.parse(introspection_result))

GraphQLSwiftGen.new(schema,
  nest_under: 'ExampleSchema',
  custom_scalars: [
    GraphQLSwiftGen::Scalar.new(
      type_name: 'Money',
      swift_type: 'NSDecimalNumber',
      deserialize_expr: ->(expr) { "NSDecimalNumber(string: #{expr}, locale: GraphQL.posixLocale)" },
      serialize_expr: ->(expr) { "#{expr}.description(withLocale: GraphQL.posixLocale)" },
    ),
  ]
).save("#{Dir.pwd}/../MyApp/Source")
```

That generated code depends on the GraphQLSupport package.

The generated code includes a query builder that can be used to
create a GraphQL query in a type-safe mannar.

```swift
let queryString = ExampleSchema.buildQuery { $0
    .user { $0
        .firstName()
        .lastName()
    }
}
```

The generated code also includes response classes that will deserialize the response
and provide methods for accessing the field data with it already coerced to the
correct type.

```swift
guard let response = try? GraphQLResponse<ExampleSchema.QueryRoot>(jsonData: response) else {
    print("Invalid GraphQL response")
    return
}
if let errors = response.errors {
    for error in errors {
        print("GraphQL error: \(error.message)")
    }
}
if let data = response.data {
    let user = data.user
    print("\(user.firstName) \(user.lastName)")
}
```

## Development

After checking out the repo, run `bundle` to install ruby dependencies.
Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake
install` or reference it from a Gemfile using the path option
(e.g. `gem 'graphql_swift_gen', path: '~/src/graphql_swift_gen'`).

## Contributing

See our [contributing guidelines](CONTRIBUTING.md) for more information.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
