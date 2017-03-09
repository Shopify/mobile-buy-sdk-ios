// Generated from graphql_swift_gen gem
import Foundation

extension ApiSchema {
	open class OrderQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func cancelReason(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "cancelReason", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func cancelledAt(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "cancelledAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func createdAt(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "createdAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func currencyCode(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "currencyCode", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func customerUrl(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "customerUrl", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func displayFinancialStatus(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "displayFinancialStatus", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func displayFulfillmentStatus(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "displayFulfillmentStatus", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lineItems(aliasSuffix: String? = nil, first: Int32, after: String? = nil, reverse: Bool? = nil, _ subfields: (LineItemConnectionQuery) -> Void) -> OrderQuery {
			var args: [String] = []

			args.append("first:\(first)")

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = LineItemConnectionQuery()
			subfields(subquery)

			addField(field: "lineItems", aliasSuffix: aliasSuffix, args: argsString, subfields: subquery)
			return self
		}

		@discardableResult
		open func orderNumber(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "orderNumber", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func processedAt(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "processedAt", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func shippingAddress(aliasSuffix: String? = nil, _ subfields: (MailingAddressQuery) -> Void) -> OrderQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)

			addField(field: "shippingAddress", aliasSuffix: aliasSuffix, subfields: subquery)
			return self
		}

		@discardableResult
		open func subtotalPrice(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "subtotalPrice", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalPrice(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "totalPrice", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalRefunded(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "totalRefunded", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalShippingPrice(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "totalShippingPrice", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func totalTax(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "totalTax", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func updatedAt(aliasSuffix: String? = nil) -> OrderQuery {
			addField(field: "updatedAt", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Order: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "cancelReason":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return OrderCancelReason(rawValue: value) ?? .unknownValue

				case "cancelledAt":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "currencyCode":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return CurrencyCode(rawValue: value) ?? .unknownValue

				case "customerUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				case "displayFinancialStatus":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return OrderDisplayFinancialStatus(rawValue: value) ?? .unknownValue

				case "displayFulfillmentStatus":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return OrderDisplayFulfillmentStatus(rawValue: value) ?? .unknownValue

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lineItems":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try LineItemConnection(fields: value)

				case "orderNumber":
				guard let value = value as? Int else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "processedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "shippingAddress":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return try MailingAddress(fields: value)

				case "subtotalPrice":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "totalPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "totalRefunded":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "totalShippingPrice":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "totalTax":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return NSDecimalNumber(string: value, locale: GraphQL.posixLocale)

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Order" }

		open var cancelReason: ApiSchema.OrderCancelReason? {
			return internalGetCancelReason()
		}

		func internalGetCancelReason(aliasSuffix: String? = nil) -> ApiSchema.OrderCancelReason? {
			return field(field: "cancelReason", aliasSuffix: aliasSuffix) as! ApiSchema.OrderCancelReason?
		}

		open var cancelledAt: Date? {
			return internalGetCancelledAt()
		}

		func internalGetCancelledAt(aliasSuffix: String? = nil) -> Date? {
			return field(field: "cancelledAt", aliasSuffix: aliasSuffix) as! Date?
		}

		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var currencyCode: ApiSchema.CurrencyCode {
			return internalGetCurrencyCode()
		}

		func internalGetCurrencyCode(aliasSuffix: String? = nil) -> ApiSchema.CurrencyCode {
			return field(field: "currencyCode", aliasSuffix: aliasSuffix) as! ApiSchema.CurrencyCode
		}

		open var customerUrl: String? {
			return internalGetCustomerUrl()
		}

		func internalGetCustomerUrl(aliasSuffix: String? = nil) -> String? {
			return field(field: "customerUrl", aliasSuffix: aliasSuffix) as! String?
		}

		open var displayFinancialStatus: ApiSchema.OrderDisplayFinancialStatus? {
			return internalGetDisplayFinancialStatus()
		}

		func internalGetDisplayFinancialStatus(aliasSuffix: String? = nil) -> ApiSchema.OrderDisplayFinancialStatus? {
			return field(field: "displayFinancialStatus", aliasSuffix: aliasSuffix) as! ApiSchema.OrderDisplayFinancialStatus?
		}

		open var displayFulfillmentStatus: ApiSchema.OrderDisplayFulfillmentStatus {
			return internalGetDisplayFulfillmentStatus()
		}

		func internalGetDisplayFulfillmentStatus(aliasSuffix: String? = nil) -> ApiSchema.OrderDisplayFulfillmentStatus {
			return field(field: "displayFulfillmentStatus", aliasSuffix: aliasSuffix) as! ApiSchema.OrderDisplayFulfillmentStatus
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var lineItems: ApiSchema.LineItemConnection {
			return internalGetLineItems()
		}

		open func aliasedLineItems(aliasSuffix: String) -> ApiSchema.LineItemConnection {
			return internalGetLineItems(aliasSuffix: aliasSuffix)
		}

		func internalGetLineItems(aliasSuffix: String? = nil) -> ApiSchema.LineItemConnection {
			return field(field: "lineItems", aliasSuffix: aliasSuffix) as! ApiSchema.LineItemConnection
		}

		open var orderNumber: Int32 {
			return internalGetOrderNumber()
		}

		func internalGetOrderNumber(aliasSuffix: String? = nil) -> Int32 {
			return field(field: "orderNumber", aliasSuffix: aliasSuffix) as! Int32
		}

		open var processedAt: Date {
			return internalGetProcessedAt()
		}

		func internalGetProcessedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "processedAt", aliasSuffix: aliasSuffix) as! Date
		}

		open var shippingAddress: ApiSchema.MailingAddress? {
			return internalGetShippingAddress()
		}

		func internalGetShippingAddress(aliasSuffix: String? = nil) -> ApiSchema.MailingAddress? {
			return field(field: "shippingAddress", aliasSuffix: aliasSuffix) as! ApiSchema.MailingAddress?
		}

		open var subtotalPrice: NSDecimalNumber? {
			return internalGetSubtotalPrice()
		}

		func internalGetSubtotalPrice(aliasSuffix: String? = nil) -> NSDecimalNumber? {
			return field(field: "subtotalPrice", aliasSuffix: aliasSuffix) as! NSDecimalNumber?
		}

		open var totalPrice: NSDecimalNumber {
			return internalGetTotalPrice()
		}

		func internalGetTotalPrice(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "totalPrice", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var totalRefunded: NSDecimalNumber {
			return internalGetTotalRefunded()
		}

		func internalGetTotalRefunded(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "totalRefunded", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var totalShippingPrice: NSDecimalNumber {
			return internalGetTotalShippingPrice()
		}

		func internalGetTotalShippingPrice(aliasSuffix: String? = nil) -> NSDecimalNumber {
			return field(field: "totalShippingPrice", aliasSuffix: aliasSuffix) as! NSDecimalNumber
		}

		open var totalTax: NSDecimalNumber? {
			return internalGetTotalTax()
		}

		func internalGetTotalTax(aliasSuffix: String? = nil) -> NSDecimalNumber? {
			return field(field: "totalTax", aliasSuffix: aliasSuffix) as! NSDecimalNumber?
		}

		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(aliasSuffix: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: aliasSuffix) as! Date
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "cancelReason":

				return .Scalar

				case "cancelledAt":

				return .Scalar

				case "createdAt":

				return .Scalar

				case "currencyCode":

				return .Scalar

				case "customerUrl":

				return .Scalar

				case "displayFinancialStatus":

				return .Scalar

				case "displayFulfillmentStatus":

				return .Scalar

				case "id":

				return .Scalar

				case "lineItems":

				return .Object

				case "orderNumber":

				return .Scalar

				case "processedAt":

				return .Scalar

				case "shippingAddress":

				return .Object

				case "subtotalPrice":

				return .Scalar

				case "totalPrice":

				return .Scalar

				case "totalRefunded":

				return .Scalar

				case "totalShippingPrice":

				return .Scalar

				case "totalTax":

				return .Scalar

				case "updatedAt":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
				case "lineItems":
				return internalGetLineItems()

				case "shippingAddress":
				return internalGetShippingAddress()

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
					case "lineItems":
					response.append(internalGetLineItems())
					response.append(contentsOf: internalGetLineItems().childResponseObjectMap())

					case "shippingAddress":
					if let value = internalGetShippingAddress() {
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
