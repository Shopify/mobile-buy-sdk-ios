// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CustomerMailingAddressDeleteInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		public init(
			id: GraphQL.ID,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
