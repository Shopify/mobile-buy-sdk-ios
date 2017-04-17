// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutAttributesUpdateInput {
		open var clientMutationId: String?

		open var checkoutId: GraphQL.ID

		open var note: String?

		open var customAttributes: [AttributeInput]?

		open var allowPartialAddresses: Bool?

		public init(
			checkoutId: GraphQL.ID,

			clientMutationId: String? = nil,

			note: String? = nil,

			customAttributes: [AttributeInput]? = nil,

			allowPartialAddresses: Bool? = nil
		) {
			self.clientMutationId = clientMutationId

			self.checkoutId = checkoutId

			self.note = note

			self.customAttributes = customAttributes

			self.allowPartialAddresses = allowPartialAddresses
		}

		func serialize() -> String {
			var fields: [String] = []

			if let clientMutationId = clientMutationId {
				fields.append("clientMutationId:\(GraphQL.quoteString(input: clientMutationId))")
			}

			fields.append("checkoutId:\(GraphQL.quoteString(input: "\(checkoutId.rawValue)"))")

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
