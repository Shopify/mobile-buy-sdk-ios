// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class ApiCustomerAccessTokenDeleteInput {
		open var clientMutationId: String?

		public init(
			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
