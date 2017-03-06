// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class ShippingRatesRequestCreateInput {
		open var clientMutationId: String?

		open var purchaseSessionId: GraphQL.ID

		public init(
			purchaseSessionId: GraphQL.ID,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.purchaseSessionId = purchaseSessionId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("purchaseSessionId:\(GraphQL.quoteString(input: "\(purchaseSessionId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
