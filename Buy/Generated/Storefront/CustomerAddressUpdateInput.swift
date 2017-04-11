// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAddressUpdateInput {
		open var clientMutationId: String?

		open var customerAccessToken: String

		open var id: GraphQL.ID

		open var address: MailingAddressInput

		public init(
			customerAccessToken: String,

			id: GraphQL.ID,

			address: MailingAddressInput,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.customerAccessToken = customerAccessToken

			self.id = id

			self.address = address
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("customerAccessToken:\(GraphQL.quoteString(input: customerAccessToken))")

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			fields.append("address:\(address.serialize())")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
