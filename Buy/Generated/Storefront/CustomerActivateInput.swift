// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerActivateInput {
		open var activationToken: String

		open var password: String

		public init(
			activationToken: String,

			password: String
		) {
			self.activationToken = activationToken

			self.password = password
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("activationToken:\(GraphQL.quoteString(input: activationToken))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
