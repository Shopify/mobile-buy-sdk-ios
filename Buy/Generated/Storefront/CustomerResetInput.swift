// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerResetInput {
		open var resetToken: String

		open var password: String

		public init(
			resetToken: String,

			password: String
		) {
			self.resetToken = resetToken

			self.password = password
		}

		func serialize() -> String {
			var fields: [String] = []

			fields.append("resetToken:\(GraphQL.quoteString(input: resetToken))")

			fields.append("password:\(GraphQL.quoteString(input: password))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
