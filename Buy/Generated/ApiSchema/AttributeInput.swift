// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class AttributeInput {
		open var key: String

		open var value: String

		public init(
			key: String,

			value: String
		) {
			self.key = key

			self.value = value
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("key:\(GraphQL.quoteString(input: key))")

			fields.append("value:\(GraphQL.quoteString(input: value))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
