// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerAddressDeleteInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var accessToken: String

		public init(
			id: GraphQL.ID,

			accessToken: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.accessToken = accessToken
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			fields.append("accessToken:\(GraphQL.quoteString(input: accessToken))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
