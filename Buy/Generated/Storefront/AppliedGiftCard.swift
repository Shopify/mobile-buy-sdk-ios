// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class AppliedGiftCardQuery: GraphQL.AbstractQuery {
		@discardableResult
		open func amountUsed(aliasSuffix: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "amountUsed", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func balance(aliasSuffix: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "balance", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func id(aliasSuffix: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "id", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func lastCharacters(aliasSuffix: String? = nil) -> AppliedGiftCardQuery {
			addField(field: "lastCharacters", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class AppliedGiftCard: GraphQL.AbstractResponse, Node
	{
		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amountUsed":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "balance":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "lastCharacters":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "AppliedGiftCard" }

		open var amountUsed: Decimal {
			return internalGetAmountUsed()
		}

		func internalGetAmountUsed(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "amountUsed", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var balance: Decimal {
			return internalGetBalance()
		}

		func internalGetBalance(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "balance", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(aliasSuffix: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: aliasSuffix) as! GraphQL.ID
		}

		open var lastCharacters: String {
			return internalGetLastCharacters()
		}

		func internalGetLastCharacters(aliasSuffix: String? = nil) -> String {
			return field(field: "lastCharacters", aliasSuffix: aliasSuffix) as! String
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "amountUsed":

				return .Scalar

				case "balance":

				return .Scalar

				case "id":

				return .Scalar

				case "lastCharacters":

				return .Scalar

				default:
				return .Scalar
			}
		}

		override open func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			switch(key) {
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
			return []
		}

		open func responseObject() -> GraphQL.AbstractResponse {
			return self as GraphQL.AbstractResponse
		}
	}
}
