// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class CreditCardPaymentRequestQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func amount(aliasSuffix: String? = nil) -> CreditCardPaymentRequestQuery {
			addField(field: "amount", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func creditCard(aliasSuffix: String? = nil, _ subfields: (CreditCardQuery) -> Void) -> CreditCardPaymentRequestQuery {
			let subquery = CreditCardQuery()
			subfields(subquery)

			addField(field: "creditCard", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> CreditCardPaymentRequestQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func paymentProcessingErrorMessage(aliasSuffix: String? = nil) -> CreditCardPaymentRequestQuery {
			addField(field: "paymentProcessingErrorMessage", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func purchaseSession(aliasSuffix: String? = nil, _ subfields: (PurchaseSessionQuery) -> Void) -> CreditCardPaymentRequestQuery {
			let subquery = PurchaseSessionQuery()
			subfields(subquery)

			addField(field: "purchaseSession", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func test(aliasSuffix: String? = nil) -> CreditCardPaymentRequestQuery {
			addField(field: "test", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func transaction(aliasSuffix: String? = nil, _ subfields: (TransactionQuery) -> Void) -> CreditCardPaymentRequestQuery {
			let subquery = TransactionQuery()
			subfields(subquery)

			addField(field: "transaction", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func uniqueToken(aliasSuffix: String? = nil) -> CreditCardPaymentRequestQuery {
			addField(field: "uniqueToken", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class CreditCardPaymentRequest: GraphQL.AbstractResponse, Node, PaymentRequest
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "creditCard":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try CreditCard(fields: value)

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

		open var typeName: String { return "CreditCardPaymentRequest" }

		open var amount: NSDecimalNumber {
			return internalGetAmount()
		}

		func internalGetAmount(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "amount", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var creditCard: ApiSchema.CreditCard {
			return internalGetCreditCard()
		}

		func internalGetCreditCard(aliasSuffix: String? = nil) -> ApiSchema.CreditCard {
			return field(field: "creditCard", aliasSuffix: aliasSuffix) as! ApiSchema.CreditCard
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

		open var purchaseSession: ApiSchema.PurchaseSession {
			return internalGetPurchaseSession()
		}

		func internalGetPurchaseSession(aliasSuffix: String? = nil) -> ApiSchema.PurchaseSession {
			return field(field: "purchaseSession", aliasSuffix: aliasSuffix) as! ApiSchema.PurchaseSession
		}

		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(aliasSuffix: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: aliasSuffix) as! Bool
		}

		open var transaction: ApiSchema.Transaction? {
			return internalGetTransaction()
		}

		func internalGetTransaction(aliasSuffix: String? = nil) -> ApiSchema.Transaction? {
			return field(field: "transaction", aliasSuffix: aliasSuffix) as! ApiSchema.Transaction?
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

				case "creditCard":

				return .Object

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
				case "creditCard":
				return internalGetCreditCard()

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
					case "creditCard":
					response.append(internalGetCreditCard())
					response.append(contentsOf: internalGetCreditCard().childResponseObjectMap())

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
