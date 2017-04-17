// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutGiftCardApplyInput {
		open var clientMutationId: String?

		open var giftCardCode: String

		open var checkoutId: GraphQL.ID

		public init(
			giftCardCode: String,

			checkoutId: GraphQL.ID,

			clientMutationId: String? = nil
		) {
			self.clientMutationId = clientMutationId

			self.giftCardCode = giftCardCode

			self.checkoutId = checkoutId
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("giftCardCode:\(GraphQL.quoteString(input: giftCardCode))")

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
