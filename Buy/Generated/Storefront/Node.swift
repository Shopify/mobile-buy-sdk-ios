//
//  Node.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// An object with an ID to support global identification. 
public protocol Node {
	var id: GraphQL.ID { get }
}

extension Storefront {
	/// An object with an ID to support global identification. 
	open class NodeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Node

		/// Globally unique identifier. 
		@discardableResult
		open func id(alias: String? = nil) -> NodeQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onAppliedGiftCard(subfields: (AppliedGiftCardQuery) -> Void) -> NodeQuery {
			let subquery = AppliedGiftCardQuery()
			subfields(subquery)
			addInlineFragment(on: "AppliedGiftCard", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> NodeQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onBlog(subfields: (BlogQuery) -> Void) -> NodeQuery {
			let subquery = BlogQuery()
			subfields(subquery)
			addInlineFragment(on: "Blog", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onCheckout(subfields: (CheckoutQuery) -> Void) -> NodeQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)
			addInlineFragment(on: "Checkout", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onCheckoutLineItem(subfields: (CheckoutLineItemQuery) -> Void) -> NodeQuery {
			let subquery = CheckoutLineItemQuery()
			subfields(subquery)
			addInlineFragment(on: "CheckoutLineItem", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> NodeQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onComment(subfields: (CommentQuery) -> Void) -> NodeQuery {
			let subquery = CommentQuery()
			subfields(subquery)
			addInlineFragment(on: "Comment", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onMailingAddress(subfields: (MailingAddressQuery) -> Void) -> NodeQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)
			addInlineFragment(on: "MailingAddress", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onOrder(subfields: (OrderQuery) -> Void) -> NodeQuery {
			let subquery = OrderQuery()
			subfields(subquery)
			addInlineFragment(on: "Order", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onPayment(subfields: (PaymentQuery) -> Void) -> NodeQuery {
			let subquery = PaymentQuery()
			subfields(subquery)
			addInlineFragment(on: "Payment", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> NodeQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onProductOption(subfields: (ProductOptionQuery) -> Void) -> NodeQuery {
			let subquery = ProductOptionQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductOption", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> NodeQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		/// An object with an ID to support global identification. 
		@discardableResult
		open func onShopPolicy(subfields: (ShopPolicyQuery) -> Void) -> NodeQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)
			addInlineFragment(on: "ShopPolicy", subfields: subquery)
			return self
		}
	}

	/// An object with an ID to support global identification. 
	open class UnknownNode: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = NodeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: type(of: self), field: fieldName, value: fieldValue)
			}
		}

		internal static func create(fields: [String: Any]) throws -> Node {
			guard let typeName = fields["__typename"] as? String else {
				throw SchemaViolationError(type: UnknownNode.self, field: "__typename", value: fields["__typename"] ?? NSNull())
			}
			switch typeName {
				case "AppliedGiftCard": return try AppliedGiftCard.init(fields: fields)

				case "Article": return try Article.init(fields: fields)

				case "Blog": return try Blog.init(fields: fields)

				case "Checkout": return try Checkout.init(fields: fields)

				case "CheckoutLineItem": return try CheckoutLineItem.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Comment": return try Comment.init(fields: fields)

				case "MailingAddress": return try MailingAddress.init(fields: fields)

				case "Order": return try Order.init(fields: fields)

				case "Payment": return try Payment.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "ProductOption": return try ProductOption.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				case "ShopPolicy": return try ShopPolicy.init(fields: fields)

				default:
				return try UnknownNode.init(fields: fields)
			}
		}

		/// Globally unique identifier. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse]  {
			return []
		}
	}
}
