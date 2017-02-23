// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class PurchaseSessionShippingRateUpdateInput {
		open var clientMutationId: String?

		open var purchaseSessionId: GraphQL.ID

		open var shippingRateHandle: String

		public init(
			purchaseSessionId: GraphQL.ID,

			shippingRateHandle: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.purchaseSessionId = purchaseSessionId

			self.shippingRateHandle = shippingRateHandle
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("purchaseSessionId:\(GraphQL.quoteString(input: "\(purchaseSessionId.rawValue)"))")

			fields.append("shippingRateHandle:\(GraphQL.quoteString(input: shippingRateHandle))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
