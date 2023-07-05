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

/// An object with an ID field to support global identification, in accordance 
/// with the [Relay 
/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
/// This interface is used by the 
/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
/// queries. 
public protocol Node {
	var id: GraphQL.ID { get }
}

extension Storefront {
	/// An object with an ID field to support global identification, in accordance 
	/// with the [Relay 
	/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
	/// This interface is used by the 
	/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
	/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
	/// queries. 
	open class NodeQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Node

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> NodeQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		override init() {
			super.init()
			addField(field: "__typename")
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onAppliedGiftCard(subfields: (AppliedGiftCardQuery) -> Void) -> NodeQuery {
			let subquery = AppliedGiftCardQuery()
			subfields(subquery)
			addInlineFragment(on: "AppliedGiftCard", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onArticle(subfields: (ArticleQuery) -> Void) -> NodeQuery {
			let subquery = ArticleQuery()
			subfields(subquery)
			addInlineFragment(on: "Article", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onBlog(subfields: (BlogQuery) -> Void) -> NodeQuery {
			let subquery = BlogQuery()
			subfields(subquery)
			addInlineFragment(on: "Blog", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onCart(subfields: (CartQuery) -> Void) -> NodeQuery {
			let subquery = CartQuery()
			subfields(subquery)
			addInlineFragment(on: "Cart", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onCartLine(subfields: (CartLineQuery) -> Void) -> NodeQuery {
			let subquery = CartLineQuery()
			subfields(subquery)
			addInlineFragment(on: "CartLine", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onCheckout(subfields: (CheckoutQuery) -> Void) -> NodeQuery {
			let subquery = CheckoutQuery()
			subfields(subquery)
			addInlineFragment(on: "Checkout", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onCheckoutLineItem(subfields: (CheckoutLineItemQuery) -> Void) -> NodeQuery {
			let subquery = CheckoutLineItemQuery()
			subfields(subquery)
			addInlineFragment(on: "CheckoutLineItem", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onCollection(subfields: (CollectionQuery) -> Void) -> NodeQuery {
			let subquery = CollectionQuery()
			subfields(subquery)
			addInlineFragment(on: "Collection", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onComment(subfields: (CommentQuery) -> Void) -> NodeQuery {
			let subquery = CommentQuery()
			subfields(subquery)
			addInlineFragment(on: "Comment", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onComponentizableCartLine(subfields: (ComponentizableCartLineQuery) -> Void) -> NodeQuery {
			let subquery = ComponentizableCartLineQuery()
			subfields(subquery)
			addInlineFragment(on: "ComponentizableCartLine", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onExternalVideo(subfields: (ExternalVideoQuery) -> Void) -> NodeQuery {
			let subquery = ExternalVideoQuery()
			subfields(subquery)
			addInlineFragment(on: "ExternalVideo", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onGenericFile(subfields: (GenericFileQuery) -> Void) -> NodeQuery {
			let subquery = GenericFileQuery()
			subfields(subquery)
			addInlineFragment(on: "GenericFile", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onLocation(subfields: (LocationQuery) -> Void) -> NodeQuery {
			let subquery = LocationQuery()
			subfields(subquery)
			addInlineFragment(on: "Location", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMailingAddress(subfields: (MailingAddressQuery) -> Void) -> NodeQuery {
			let subquery = MailingAddressQuery()
			subfields(subquery)
			addInlineFragment(on: "MailingAddress", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMarket(subfields: (MarketQuery) -> Void) -> NodeQuery {
			let subquery = MarketQuery()
			subfields(subquery)
			addInlineFragment(on: "Market", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMediaImage(subfields: (MediaImageQuery) -> Void) -> NodeQuery {
			let subquery = MediaImageQuery()
			subfields(subquery)
			addInlineFragment(on: "MediaImage", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMediaPresentation(subfields: (MediaPresentationQuery) -> Void) -> NodeQuery {
			let subquery = MediaPresentationQuery()
			subfields(subquery)
			addInlineFragment(on: "MediaPresentation", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMenu(subfields: (MenuQuery) -> Void) -> NodeQuery {
			let subquery = MenuQuery()
			subfields(subquery)
			addInlineFragment(on: "Menu", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMenuItem(subfields: (MenuItemQuery) -> Void) -> NodeQuery {
			let subquery = MenuItemQuery()
			subfields(subquery)
			addInlineFragment(on: "MenuItem", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMetafield(subfields: (MetafieldQuery) -> Void) -> NodeQuery {
			let subquery = MetafieldQuery()
			subfields(subquery)
			addInlineFragment(on: "Metafield", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onMetaobject(subfields: (MetaobjectQuery) -> Void) -> NodeQuery {
			let subquery = MetaobjectQuery()
			subfields(subquery)
			addInlineFragment(on: "Metaobject", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onModel3d(subfields: (Model3dQuery) -> Void) -> NodeQuery {
			let subquery = Model3dQuery()
			subfields(subquery)
			addInlineFragment(on: "Model3d", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onOrder(subfields: (OrderQuery) -> Void) -> NodeQuery {
			let subquery = OrderQuery()
			subfields(subquery)
			addInlineFragment(on: "Order", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onPage(subfields: (PageQuery) -> Void) -> NodeQuery {
			let subquery = PageQuery()
			subfields(subquery)
			addInlineFragment(on: "Page", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onPayment(subfields: (PaymentQuery) -> Void) -> NodeQuery {
			let subquery = PaymentQuery()
			subfields(subquery)
			addInlineFragment(on: "Payment", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onProduct(subfields: (ProductQuery) -> Void) -> NodeQuery {
			let subquery = ProductQuery()
			subfields(subquery)
			addInlineFragment(on: "Product", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onProductOption(subfields: (ProductOptionQuery) -> Void) -> NodeQuery {
			let subquery = ProductOptionQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductOption", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onProductVariant(subfields: (ProductVariantQuery) -> Void) -> NodeQuery {
			let subquery = ProductVariantQuery()
			subfields(subquery)
			addInlineFragment(on: "ProductVariant", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onShop(subfields: (ShopQuery) -> Void) -> NodeQuery {
			let subquery = ShopQuery()
			subfields(subquery)
			addInlineFragment(on: "Shop", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onShopPolicy(subfields: (ShopPolicyQuery) -> Void) -> NodeQuery {
			let subquery = ShopPolicyQuery()
			subfields(subquery)
			addInlineFragment(on: "ShopPolicy", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onUrlRedirect(subfields: (UrlRedirectQuery) -> Void) -> NodeQuery {
			let subquery = UrlRedirectQuery()
			subfields(subquery)
			addInlineFragment(on: "UrlRedirect", subfields: subquery)
			return self
		}

		/// An object with an ID field to support global identification, in accordance 
		/// with the [Relay 
		/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
		/// This interface is used by the 
		/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
		/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
		/// queries. 
		@discardableResult
		open func onVideo(subfields: (VideoQuery) -> Void) -> NodeQuery {
			let subquery = VideoQuery()
			subfields(subquery)
			addInlineFragment(on: "Video", subfields: subquery)
			return self
		}
	}

	/// An object with an ID field to support global identification, in accordance 
	/// with the [Relay 
	/// specification](https://relay.dev/graphql/objectidentification.htm#sec-Node-Interface). 
	/// This interface is used by the 
	/// [node](https://shopify.dev/api/admin-graphql/unstable/queries/node) and 
	/// [nodes](https://shopify.dev/api/admin-graphql/unstable/queries/nodes) 
	/// queries. 
	open class UnknownNode: GraphQL.AbstractResponse, GraphQLObject, Node {
		public typealias Query = NodeQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: UnknownNode.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				default:
				throw SchemaViolationError(type: UnknownNode.self, field: fieldName, value: fieldValue)
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

				case "Cart": return try Cart.init(fields: fields)

				case "CartLine": return try CartLine.init(fields: fields)

				case "Checkout": return try Checkout.init(fields: fields)

				case "CheckoutLineItem": return try CheckoutLineItem.init(fields: fields)

				case "Collection": return try Collection.init(fields: fields)

				case "Comment": return try Comment.init(fields: fields)

				case "ComponentizableCartLine": return try ComponentizableCartLine.init(fields: fields)

				case "ExternalVideo": return try ExternalVideo.init(fields: fields)

				case "GenericFile": return try GenericFile.init(fields: fields)

				case "Location": return try Location.init(fields: fields)

				case "MailingAddress": return try MailingAddress.init(fields: fields)

				case "Market": return try Market.init(fields: fields)

				case "MediaImage": return try MediaImage.init(fields: fields)

				case "MediaPresentation": return try MediaPresentation.init(fields: fields)

				case "Menu": return try Menu.init(fields: fields)

				case "MenuItem": return try MenuItem.init(fields: fields)

				case "Metafield": return try Metafield.init(fields: fields)

				case "Metaobject": return try Metaobject.init(fields: fields)

				case "Model3d": return try Model3d.init(fields: fields)

				case "Order": return try Order.init(fields: fields)

				case "Page": return try Page.init(fields: fields)

				case "Payment": return try Payment.init(fields: fields)

				case "Product": return try Product.init(fields: fields)

				case "ProductOption": return try ProductOption.init(fields: fields)

				case "ProductVariant": return try ProductVariant.init(fields: fields)

				case "Shop": return try Shop.init(fields: fields)

				case "ShopPolicy": return try ShopPolicy.init(fields: fields)

				case "UrlRedirect": return try UrlRedirect.init(fields: fields)

				case "Video": return try Video.init(fields: fields)

				default:
				return try UnknownNode.init(fields: fields)
			}
		}

		/// A globally-unique ID. 
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
