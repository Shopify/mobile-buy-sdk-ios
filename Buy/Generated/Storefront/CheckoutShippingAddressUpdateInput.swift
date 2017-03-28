// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutShippingAddressUpdateInput {
		open var clientMutationId: String?

		open var shippingAddress: MailingAddressInput

		open var checkoutId: GraphQL.ID

		public init(
			shippingAddress: MailingAddressInput,

			checkoutId: GraphQL.ID,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.shippingAddress = shippingAddress

			self.checkoutId = checkoutId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("shippingAddress:\(shippingAddress.serialize())")

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
