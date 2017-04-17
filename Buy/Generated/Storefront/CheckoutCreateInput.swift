// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCreateInput {
		open var clientMutationId: String?

		open var email: String?

		open var lineItems: [CheckoutLineItemInput]?

		open var shippingAddress: MailingAddressInput?

		open var note: String?

		open var customAttributes: [AttributeInput]?

		open var allowPartialAddresses: Bool?

		public init(
			clientMutationId: String? = nil,

			email: String? = nil,

			lineItems: [CheckoutLineItemInput]? = nil,

			shippingAddress: MailingAddressInput? = nil,

			note: String? = nil,

			customAttributes: [AttributeInput]? = nil,

			allowPartialAddresses: Bool? = nil
		) {
			self.clientMutationId = clientMutationId

			self.email = email

			self.lineItems = lineItems

			self.shippingAddress = shippingAddress

			self.note = note

			self.customAttributes = customAttributes

			self.allowPartialAddresses = allowPartialAddresses
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			if let email = email {
				fields.append("email:\(GraphQL.quoteString(input: email))")
			}

			if let lineItems = lineItems {
				fields.append("lineItems:[\(lineItems.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let shippingAddress = shippingAddress {
				fields.append("shippingAddress:\(shippingAddress.serialize())")
			}

			if let note = note {
				fields.append("note:\(GraphQL.quoteString(input: note))")
			}

			if let customAttributes = customAttributes {
				fields.append("customAttributes:[\(customAttributes.map{ "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let allowPartialAddresses = allowPartialAddresses {
				fields.append("allowPartialAddresses:\(allowPartialAddresses)")
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
