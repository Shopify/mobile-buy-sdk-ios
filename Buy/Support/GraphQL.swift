//
//  GraphQL.swift
//  Shopify
//
//  Created by Dylan Thacker-Smith on 2015-11-12.
//  Copyright © 2017 Shopify
//
//  MIT Licensed. See LICENCE.txt file in the root of this project for details.
//

import Foundation

extension GraphQL.ID: Hashable {
	public var hashValue: Int {
		return rawValue.hashValue
	}
}

public class GraphQL {
	public class Selection {
		let field: String
		let alias: String?
		let args: String?
		var subfields: AbstractQuery? = nil

		init(field: String, alias: String? = nil, args: String? = nil, subfields: AbstractQuery? = nil) {
			self.field = field
			self.alias = alias
			self.args = args
			self.subfields = subfields
		}

		var key: String {
			return alias ?? field
		}
	}

	public struct ID: RawRepresentable, CustomStringConvertible {
		public let rawValue: String

		public init(rawValue: String) {
			self.rawValue = rawValue
		}

		public init?(rawValue: String?) {
			guard let rawValue = rawValue else { return nil }
			self.rawValue = rawValue
		}

		public var description: String {
			return rawValue
		}
	}

	open class AbstractQuery: CustomStringConvertible {
		static let aliasSuffixSeparator = "__"
		var selections: [String: Selection] = [:]
		var orderedSelections: [Selection] = [] // predictable order for testing

		public init () {
		}

		open var description: String {
			assert(!selections.isEmpty, "selection set must have at least 1 selection")
			var query = "{"
			var first = true
			for s in orderedSelections {
				if first {
					first = false
				} else {
					query += ","
				}
				if let alias = s.alias {
					query += "\(alias):"
				}
				query += s.field
				query += s.args ?? ""
				if let subfields = s.subfields {
					query += String(describing: subfields)
				}
			}
			query += "}"
			return query
		}

		private func addSelection(selection: Selection) {
			if let previous = selections[selection.key] {
				assert(previous.field == selection.field, "Selections with the same response name must have the same field name")
				assert(previous.args == selection.args, "Selections with the same response name must have the same arguments")
				if let subfields = selection.subfields {
					for (_, subSelection) in subfields.selections {
						previous.subfields!.addSelection(selection: subSelection)
					}
				}
			} else {
				selections[selection.key] = selection
				orderedSelections.append(selection)
			}
		}

		internal func addField(field: String, aliasSuffix: String? = nil, args: String? = nil, subfields: AbstractQuery? = nil) {
			var alias: String? = nil
			if let aliasSuffix = aliasSuffix {
				alias = "\(field)\(AbstractQuery.aliasSuffixSeparator)\(aliasSuffix)"
			}
			addSelection(selection: Selection(field: field, alias: alias, args: args, subfields: subfields))
		}

		internal func addInlineFragment(on object: String, subfields: AbstractQuery) {
			addSelection(selection: Selection(field: "... on \(object)", alias: nil, args: nil, subfields: subfields))
		}
	}

	internal static func quoteString(input: String) -> String {
		var escaped = "\""
		for c in input.unicodeScalars {
			switch c {
			case "\\":
				escaped += "\\\\"
			case "\"":
				escaped += "\\\""
			case "\n":
				escaped += "\\n"
			case "\r":
				escaped += "\\r"
			default:
				if c.value < 0x20 {
					escaped += String(format: "\\u%04x", c.value)
				} else {
					escaped.append(String(c))
				}
			}
		}
		escaped += "\""
		return escaped
	}

	open class AbstractResponse: CustomDebugStringConvertible {
		public var fields: [String: Any]
		internal var objectMap: [String : Any?] = [:]

		required public init(fields: [String: Any]) throws {
			self.fields = fields
			for (key, value) in fields {
				if key == "__typename" {
					guard let stringValue = value as? String else {
						throw SchemaViolationError(type: type(of: self), field: key, value: value)
					}
					objectMap[key] = stringValue
				} else {
					objectMap[key] = try deserializeValue(fieldName: fieldName(from: key), value: value)
				}
			}
		}

		internal func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			throw SchemaViolationError(type: type(of: self), field: fieldName, value: value)
		}

		internal func field(field: String, aliasSuffix: String? = nil) -> Any? {
			var responseKey = field
			if let aliasSuffix = aliasSuffix {
				responseKey += "\(AbstractQuery.aliasSuffixSeparator)\(aliasSuffix)"
			}
			guard let keyIndex = objectMap.index(forKey: responseKey) else {
				fatalError("field \(responseKey) wasn't queried")
			}
			return objectMap[keyIndex].1
		}

		public var debugDescription: String {
			return "<\(type(of: self)): \(fields)>"
		}

		internal func childObjectType(key: String) -> ChildObjectType {
			return .unknown
		}

		internal func fetchChildObject(key: String) -> GraphQL.AbstractResponse? {
			return nil
		}

		internal func fetchChildObjectList(key: String) -> [GraphQL.AbstractResponse] {
			return []
		}

		internal func fieldName(from key: String) -> String {
			if let range = key.range(of: AbstractQuery.aliasSuffixSeparator) {
				if key.distance(from: key.startIndex, to: range.lowerBound) > 0 {
					return String(key[..<range.lowerBound])
				}
			}
			return key
		}
        
        internal func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
            fatalError()
        }
	}

	public struct ResponseError {
		public let message: String
		public let fields: [String: AnyObject]
	}

	public enum ChildObjectType {
		case object
		@available(*, deprecated, message:"Use .object")
		public static let Object = object

		case objectList
		@available(*, deprecated, message:"Use .objectList")
		public static let ObjectList = objectList

		case scalar
		@available(*, deprecated, message:"Use .scalar")
		public static let Scalar = scalar

		case scalarList
		@available(*, deprecated, message:"Use .scalarList")
		public static let ScalarList = scalarList

		case unknown
		@available(*, deprecated, message:"Use .unknown")
		public static let Unknown = unknown
	}

	public struct ViolationError: Error {
		public let response: Any
	}

	public struct JsonParsingError: Error {
		public let input: Data
	}
}

public struct GraphQLResponse<DataType: GraphQL.AbstractResponse> {
	internal let data: DataType?
	internal let errors: [GraphQL.ResponseError]?

	public init(object: Any) throws {
		guard let rootDict = object as? [String: AnyObject] else {
			throw GraphQL.ViolationError(response: object)
		}

		if let data = rootDict["data"] {
			guard let data = data as? [String: AnyObject] else {
				throw GraphQL.ViolationError(response: object)
			}
			self.data = try DataType(fields: data)
		} else {
			self.data = nil
		}
		if let errors = rootDict["errors"] {
			guard let errors = errors as? [[String: AnyObject]] else {
				throw GraphQL.ViolationError(response: object)
			}
			self.errors = try errors.map { fields in
				guard let message = fields["message"] as? String else {
					throw GraphQL.ViolationError(response: object)
				}
				return GraphQL.ResponseError(message: message, fields: fields)
			}
		} else {
			self.errors = nil
		}
		if self.data == nil && self.errors == nil {
			throw GraphQL.ViolationError(response: object)
		}
	}

	public init(jsonData: Data) throws {
		let options = JSONSerialization.ReadingOptions(rawValue: 0)
		guard let responseObj = try? JSONSerialization.jsonObject(with: jsonData, options: options) else {
			throw GraphQL.JsonParsingError(input: jsonData)
		}
		try self.init(object: responseObj)
	}
}

public protocol GraphQLQuery {
	associatedtype Response
}

public protocol GraphQLObject {
	associatedtype Query
}

public struct SchemaViolationError: Error {
	let type: GraphQL.AbstractResponse.Type
	let field: String
	let value: Any

	public init(type: GraphQL.AbstractResponse.Type, field: String, value: Any) {
		self.type = type
		self.field = field
		self.value = value
	}
}

/// A wrapper for values used in input objects.
///
/// An input, for example Input<String>, represents a nullable value
/// in an object passed into a mutation request. It represents two
/// main states of a value:
///
///   1. `.value(T?)` - A value, `T`, or `nil` will **always** be serialized in the request
///   2. `.undefined` - No value will be serialized in the request
///
/// Being able to control when a value is serialized or not makes it
/// possible to ommit `nil` values or include `nil` values in the
/// serialization of the request.
///
public enum Input<T> {
    
    /// An input value or `nil`. It will **always** be serialized in the request, even if `nil`.
    case value(T?)
    
    /// An undefined value; no value is provided. It will **never** be serialized in the request.
    case undefined
    
    /// Creates a `.value(T)` or `.value(nil)` if `optional` is nil.
    public init(orNull optional: Optional<T>)  {
        self = .value(optional)
    }
    
    /// Creates a `.value(T)` or `.undefined` if the `optional` is nil.
    public init(orUndefined optional: Optional<T>)  {
        if let value = optional {
            self = .value(value)
        } else {
            self = .undefined
        }
    }
}

extension GraphQL.Selection: Equatable {}
public func ==(lhs: GraphQL.Selection, rhs: GraphQL.Selection) -> Bool {
	return (lhs === rhs) || (lhs.field == rhs.field && lhs.alias == rhs.alias && lhs.args == rhs.args && lhs.subfields == rhs.subfields)
}

extension GraphQL.AbstractQuery: Equatable {}
public func ==(lhs: GraphQL.AbstractQuery, rhs: GraphQL.AbstractQuery) -> Bool {
	return (lhs === rhs) || (lhs.selections == rhs.selections)
}

extension GraphQL.AbstractQuery: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(selections.description)
    }
}
