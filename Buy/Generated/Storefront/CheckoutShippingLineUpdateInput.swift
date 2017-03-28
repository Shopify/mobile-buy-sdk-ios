// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutShippingLineUpdateInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var shippingRateHandle: String

		public init(
			checkoutId: GraphQL.ID,

			shippingRateHandle: String,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.shippingRateHandle = shippingRateHandle
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			fields.append("shippingRateHandle:\(GraphQL.quoteString(input: shippingRateHandle))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
