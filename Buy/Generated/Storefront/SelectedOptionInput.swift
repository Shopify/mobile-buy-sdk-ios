// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class SelectedOptionInput {
		open var name: String

		open var value: String

		public init(
			name: String,

			value: String
		) {
			self.name = name

			self.value = value
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("name:\(GraphQL.quoteString(input: name))")

			fields.append("value:\(GraphQL.quoteString(input: value))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
