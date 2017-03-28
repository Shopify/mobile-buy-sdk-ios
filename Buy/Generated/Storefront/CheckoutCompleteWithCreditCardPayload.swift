// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class CheckoutCompleteWithCreditCardPayloadQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func checkout(aliasSuffix: String? = nil, _ subfields: (CheckoutQuery) -> Void) -> CheckoutCompleteWithCreditCardPayloadQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)

			addField(field: "checkout", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func clientMutationId(aliasSuffix: String? = nil) -> CheckoutCompleteWithCreditCardPayloadQuery {
			addField(field: "clientMutationId", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func payment(aliasSuffix: String? = nil, _ subfields: (PaymentQuery) -> Void) -> CheckoutCompleteWithCreditCardPayloadQuery {
			let subquery = PaymentQuery()
			subfields(subquery)

			addField(field: "payment", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func userErrors(aliasSuffix: String? = nil, _ subfields: (UserErrorQuery) -> Void) -> CheckoutCompleteWithCreditCardPayloadQuery {
			let subquery = UserErrorQuery()
			subfields(subquery)

			addField(field: "userErrors", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}
	}

	open class CheckoutCompleteWithCreditCardPayload: GraphQL.AbstractResponse
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "checkout":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Checkout(fields: value)

				case "clientMutationId":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "payment":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Payment(fields: value)

				case "userErrors":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try value.map { return try UserError(fields: $0) }

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "CheckoutCompleteWithCreditCardPayload" }

		open var checkout: Storefront.Checkout {
			return internalGetCheckout()
		}

		func internalGetCheckout(aliasSuffix: String? = nil) -> Storefront.Checkout {
			return field(field: "checkout", aliasSuffix: aliasSuffix) as! Storefront.Checkout
		}

		open var clientMutationId: String? {
			return internalGetClientMutationId()
		}

		func internalGetClientMutationId(aliasSuffix: String? = nil) -> String? {
			return field(field: "clientMutationId", aliasSuffix: aliasSuffix) as! String?
		}

		open var payment: Storefront.Payment? {
			return internalGetPayment()
		}

		func internalGetPayment(aliasSuffix: String? = nil) -> Storefront.Payment? {
			return field(field: "payment", aliasSuffix: aliasSuffix) as! Storefront.Payment?
		}

		open var userErrors: [Storefront.UserError] {
			return internalGetUserErrors()
		}

		func internalGetUserErrors(aliasSuffix: String? = nil) -> [Storefront.UserError] {
			return field(field: "userErrors", aliasSuffix: aliasSuffix) as! [Storefront.UserError]
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "checkout":

				return .Object

				case "clientMutationId":

				return .Scalar

				case "payment":

				return .Object

				case "userErrors":

				return .ObjectList

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "checkout":
				return internalGetCheckout()

				case "payment":
				return internalGetPayment()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				case "userErrors":
				return internalGetUserErrors()

				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "checkout":
					response.append(internalGetCheckout())
					response.append(contentsOf: internalGetCheckout().childResponseObjectMap())

					case "payment":
					if let value = internalGetPayment() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "userErrors":
					internalGetUserErrors().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					default:
					break
				}
			})
			return response
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}
