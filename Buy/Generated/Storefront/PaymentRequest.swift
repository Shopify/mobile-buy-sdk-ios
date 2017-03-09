// Generated from graphql_swift_gen gem
import Foundation

public protocol PaymentRequest {
	var typeName: String { get }

	var amount: NSDecimalNumber { get }

	var id: GraphQL.ID { get }

	var paymentProcessingErrorMessage: String? { get }

	var purchaseSession: Storefront.PurchaseSession { get }

	var test: Bool { get }

	var transaction: Storefront.Transaction? { get }

	var uniqueToken: String? { get }

	func childResponseObjectMap() -> [GraphQL.AbstractResponse]

	func responseObject() -> GraphQL.AbstractResponse
}

extension Storefront {
	open class PaymentRequestQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func amount(aliasSuffix: String? = nil) -> PaymentRequestQuery {
			addField(field: "amount", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> PaymentRequestQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func paymentProcessingErrorMessage(aliasSuffix: String? = nil) -> PaymentRequestQuery {
			addField(field: "paymentProcessingErrorMessage", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func purchaseSession(aliasSuffix: String? = nil, _ subfields: (PurchaseSessionQuery) -> Void) -> PaymentRequestQuery {
			let subquery = PurchaseSessionQuery()
			subfields(subquery)

			addField(field: "purchaseSession", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func test(aliasSuffix: String? = nil) -> PaymentRequestQuery {
			addField(field: "test", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func transaction(aliasSuffix: String? = nil, _ subfields: (TransactionQuery) -> Void) -> PaymentRequestQuery {
			let subquery = TransactionQuery()
			subfields(subquery)

			addField(field: "transaction", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func uniqueToken(aliasSuffix: String? = nil) -> PaymentRequestQuery {
			addField(field: "uniqueToken", aliasSuffix: aliasSuffix)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		@discardableResult
		open func onCreditCardPaymentRequest(subfields: (CreditCardPaymentRequestQuery) -> Void) -> PaymentRequestQuery {
			let subquery = CreditCardPaymentRequestQuery()
			subfields(subquery)
			addInlineFragment(on: "CreditCardPaymentRequest", subfields: subquery)
			return self
		}
	}

	open class UnknownPaymentRequest: GraphQL.AbstractResponse, PaymentRequest
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "paymentProcessingErrorMessage":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "purchaseSession":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try PurchaseSession(fields: value)

				case "test":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "transaction":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try Transaction(fields: value)

				case "uniqueToken":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return field(field: "__typename") as! String }

		open static func create(fields: [String: Any]) throws -> PaymentRequest {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownPaymentRequest.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "CreditCardPaymentRequest":
				return try CreditCardPaymentRequest.init(fields: fields)

				default:
				return try UnknownPaymentRequest.init(fields: fields)
			}
		}

		open var amount: NSDecimalNumber {
			return internalGetAmount()
		}

		func internalGetAmount(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "amount", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var paymentProcessingErrorMessage: String? {
			return internalGetPaymentProcessingErrorMessage()
		}

		func internalGetPaymentProcessingErrorMessage(aliasSuffix: String? = nil) -> String? {
			return field(field: "paymentProcessingErrorMessage", aliasSuffix: aliasSuffix) as! String?
		}

		open var purchaseSession: Storefront.PurchaseSession {
			return internalGetPurchaseSession()
		}

		func internalGetPurchaseSession(aliasSuffix: String? = nil) -> Storefront.PurchaseSession {
			return field(field: "purchaseSession", aliasSuffix: aliasSuffix) as! Storefront.PurchaseSession
		}

		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(aliasSuffix: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: aliasSuffix) as! Bool
		}

		open var transaction: Storefront.Transaction? {
			return internalGetTransaction()
		}

		func internalGetTransaction(aliasSuffix: String? = nil) -> Storefront.Transaction? {
			return field(field: "transaction", aliasSuffix: aliasSuffix) as! Storefront.Transaction?
		}

		open var uniqueToken: String? {
			return internalGetUniqueToken()
		}

		func internalGetUniqueToken(aliasSuffix: String? = nil) -> String? {
			return field(field: "uniqueToken", aliasSuffix: aliasSuffix) as! String?
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "amount":

				return .Scalar

				case "id":

				return .Scalar

				case "paymentProcessingErrorMessage":

				return .Scalar

				case "purchaseSession":

				return .Object

				case "test":

				return .Scalar

				case "transaction":

				return .Object

				case "uniqueToken":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "purchaseSession":
				return internalGetPurchaseSession()

				case "transaction":
				return internalGetTransaction()

				default:
				break
			}
			return nil
		}

		override open func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			switch(key) {
				default:
				return []
			}
		}

		open func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach({
				key in
				switch(key) {
					case "purchaseSession":
					response.append(internalGetPurchaseSession())
					response.append(contentsOf: internalGetPurchaseSession().childResponseObjectMap())

					case "transaction":
					if let value = internalGetTransaction() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
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
