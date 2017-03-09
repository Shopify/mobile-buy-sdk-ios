// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class PurchaseSessionUpdateInput {
		open var clientMutationId: String?

		open var id: GraphQL.ID

		open var email: String?

		open var items: [LineItemInput]?

		open var shippingAddress: MailingAddressInput?

		public init(
			id: GraphQL.ID,

			clientMutationId: String? = nil,

			email: String? = nil,

			items: [LineItemInput]? = nil,

			shippingAddress: MailingAddressInput? = nil
		) {
			self.clientMutationId = clientMutationId

			self.id = id

			self.email = email

			self.items = items

			self.shippingAddress = shippingAddress
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("id:\(GraphQL.quoteString(input: "\(id.rawValue)"))")

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
