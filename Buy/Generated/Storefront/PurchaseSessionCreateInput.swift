// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class PurchaseSessionCreateInput {
		open var clientMutationId: String?

		open var email: String?

		open var items: [LineItemInput]?

		open var shippingAddress: MailingAddressInput?

		public init(
			clientMutationId: String? = nil,

			email: String? = nil,

			items: [LineItemInput]? = nil,

			shippingAddress: MailingAddressInput? = nil
		) {
			self.clientMutationId = clientMutationId

			self.email = email

			self.items = items

			self.shippingAddress = shippingAddress
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			if let email = email {
				fields.append("email:\(GraphQL.quoteString(input: email))")
			}

			if let items = items {
				fields.append("items:[\(items.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let shippingAddress = shippingAddress {
				fields.append("shippingAddress:\(shippingAddress.serialize())")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
