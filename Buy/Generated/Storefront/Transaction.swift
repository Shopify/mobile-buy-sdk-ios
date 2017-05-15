// Generated from graphql_swift_gen gem
import Foundation

extension Storefront {
	open class TransactionQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Transaction

		@discardableResult
		open func amount(aliasSuffix: String? = nil) -> TransactionQuery {
			addField(field: "amount", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func kind(aliasSuffix: String? = nil) -> TransactionQuery {
			addField(field: "kind", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func status(aliasSuffix: String? = nil) -> TransactionQuery {
			addField(field: "status", aliasSuffix: aliasSuffix)
			return self
		}

		@discardableResult
		open func test(aliasSuffix: String? = nil) -> TransactionQuery {
			addField(field: "test", aliasSuffix: aliasSuffix)
			return self
		}
	}

	open class Transaction: GraphQL.AbstractResponse, GraphQLObject {
		public typealias Query = TransactionQuery

		open override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "amount":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return Decimal(string: value, locale: GraphQL.posixLocale)

				case "kind":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return TransactionKind(rawValue: value) ?? .unknownValue

				case "status":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return TransactionStatus(rawValue: value) ?? .unknownValue

				case "test":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		open var typeName: String { return "Transaction" }

		open var amount: Decimal {
			return internalGetAmount()
		}

		func internalGetAmount(aliasSuffix: String? = nil) -> Decimal {
			return field(field: "amount", aliasSuffix: aliasSuffix) as! Decimal
		}

		open var kind: Storefront.TransactionKind {
			return internalGetKind()
		}

		func internalGetKind(aliasSuffix: String? = nil) -> Storefront.TransactionKind {
			return field(field: "kind", aliasSuffix: aliasSuffix) as! Storefront.TransactionKind
		}

		open var status: Storefront.TransactionStatus {
			return internalGetStatus()
		}

		func internalGetStatus(aliasSuffix: String? = nil) -> Storefront.TransactionStatus {
			return field(field: "status", aliasSuffix: aliasSuffix) as! Storefront.TransactionStatus
		}

		open var test: Bool {
			return internalGetTest()
		}

		func internalGetTest(aliasSuffix: String? = nil) -> Bool {
			return field(field: "test", aliasSuffix: aliasSuffix) as! Bool
		}

		override open func childObjectType(key: String) -> GraphQL.ChildObjectType {
			switch(key) {
				case "amount":

				return .Scalar

				case "kind":

				return .Scalar

				case "status":

				return .Scalar

				case "test":

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
