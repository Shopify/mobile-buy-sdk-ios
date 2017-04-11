// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAddressDeleteInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var customerAccessToken: String

		public init(
			id: GraphQL.ID,

			customerAccessToken: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.customerAccessToken = customerAccessToken
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
