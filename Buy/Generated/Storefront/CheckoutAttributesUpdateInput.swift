// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutAttributesUpdateInput {
		open var note: String?

		open var customAttributes: [AttributeInput]?

		open var allowPartialAddresses: Bool?

		public init(
			note: String? = nil,

			customAttributes: [AttributeInput]? = nil,

			allowPartialAddresses: Bool? = nil
		) {
			self.note = note

			self.customAttributes = customAttributes

			self.allowPartialAddresses = allowPartialAddresses
		}

		func serialize() -> String {
			var fields: [String] = []

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
