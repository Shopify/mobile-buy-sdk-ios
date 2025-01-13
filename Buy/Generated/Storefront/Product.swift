//
//  Product.swift
//  Buy
//
//  Created by Shopify.
//  Copyright (c) 2025 Shopify Inc. All rights reserved.
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

extension Storefront {
	/// The `Product` object lets you manage products in a merchant’s store. 
	/// Products are the goods and services that merchants offer to customers. They 
	/// can include various details such as title, description, price, images, and 
	/// options such as size or color. You can use [product 
	/// variants](/docs/api/storefront/latest/objects/ProductVariant) to create or 
	/// update different versions of the same product. You can also add or update 
	/// product [media](/docs/api/storefront/latest/interfaces/Media). Products can 
	/// be organized by grouping them into a 
	/// [collection](/docs/api/storefront/latest/objects/Collection). Learn more 
	/// about working with [products and 
	/// collections](/docs/storefronts/headless/building-with-the-storefront-api/products-collections). 
	open class ProductQuery: GraphQL.AbstractQuery, GraphQLQuery {
		public typealias Response = Product

		/// A list of variants whose selected options differ with the provided selected 
		/// options by one, ordered by variant id. If selected options are not 
		/// provided, adjacent variants to the first available variant is returned. 
		/// Note that this field returns an array of variants. In most cases, the 
		/// number of variants in this array will be low. However, with a low number of 
		/// options and a high number of values per option, the number of variants 
		/// returned here can be high. In such cases, it recommended to avoid using 
		/// this field. This list of variants can be used in combination with the 
		/// `options` field to build a rich variant picker that includes variant 
		/// availability or other variant information. 
		///
		/// - parameters:
		///     - selectedOptions: The input fields used for a selected option.
		///        
		///        The input must not contain more than `250` values.
		///     - ignoreUnknownOptions: Whether to ignore product options that are not present on the requested product.
		///     - caseInsensitiveMatch: Whether to perform case insensitive match on option names and values.
		///
		@discardableResult
		open func adjacentVariants(alias: String? = nil, selectedOptions: [SelectedOptionInput]? = nil, ignoreUnknownOptions: Bool? = nil, caseInsensitiveMatch: Bool? = nil, _ subfields: (ProductVariantQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let selectedOptions = selectedOptions {
				args.append("selectedOptions:[\(selectedOptions.map { "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let ignoreUnknownOptions = ignoreUnknownOptions {
				args.append("ignoreUnknownOptions:\(ignoreUnknownOptions)")
			}

			if let caseInsensitiveMatch = caseInsensitiveMatch {
				args.append("caseInsensitiveMatch:\(caseInsensitiveMatch)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "adjacentVariants", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Indicates if at least one product variant is available for sale. 
		@discardableResult
		open func availableForSale(alias: String? = nil) -> ProductQuery {
			addField(field: "availableForSale", aliasSuffix: alias)
			return self
		}

		/// The category of a product from [Shopify's Standard Product 
		/// Taxonomy](https://shopify.github.io/product-taxonomy/releases/unstable/?categoryId=sg-4-17-2-17). 
		@discardableResult
		open func category(alias: String? = nil, _ subfields: (TaxonomyCategoryQuery) -> Void) -> ProductQuery {
			let subquery = TaxonomyCategoryQuery()
			subfields(subquery)

			addField(field: "category", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A list of [collections](/docs/api/storefront/latest/objects/Collection) 
		/// that include the product. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func collections(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (CollectionConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = CollectionConnectionQuery()
			subfields(subquery)

			addField(field: "collections", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The [compare-at price 
		/// range](https://help.shopify.com/manual/products/details/product-pricing/sale-pricing) 
		/// of the product in the shop's default currency. 
		@discardableResult
		open func compareAtPriceRange(alias: String? = nil, _ subfields: (ProductPriceRangeQuery) -> Void) -> ProductQuery {
			let subquery = ProductPriceRangeQuery()
			subfields(subquery)

			addField(field: "compareAtPriceRange", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The date and time when the product was created. 
		@discardableResult
		open func createdAt(alias: String? = nil) -> ProductQuery {
			addField(field: "createdAt", aliasSuffix: alias)
			return self
		}

		/// A single-line description of the product, with [HTML 
		/// tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed. 
		///
		/// - parameters:
		///     - truncateAt: Truncates a string after the given length.
		///
		@discardableResult
		open func description(alias: String? = nil, truncateAt: Int32? = nil) -> ProductQuery {
			var args: [String] = []

			if let truncateAt = truncateAt {
				args.append("truncateAt:\(truncateAt)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			addField(field: "description", aliasSuffix: alias, args: argsString)
			return self
		}

		/// The description of the product, with HTML tags. For example, the 
		/// description might include bold `<strong></strong>` and italic `<i></i>` 
		/// text. 
		@discardableResult
		open func descriptionHtml(alias: String? = nil) -> ProductQuery {
			addField(field: "descriptionHtml", aliasSuffix: alias)
			return self
		}

		/// An encoded string containing all option value combinations with a 
		/// corresponding variant that is currently available for sale. Integers 
		/// represent option and values: [0,1] represents option_value at array index 0 
		/// for the option at array index 0 `:`, `,`, ` ` and `-` are control 
		/// characters. `:` indicates a new option. ex: 0:1 indicates value 0 for the 
		/// option in position 1, value 1 for the option in position 2. `,` indicates 
		/// the end of a repeated prefix, mulitple consecutive commas indicate the end 
		/// of multiple repeated prefixes. ` ` indicates a gap in the sequence of 
		/// option values. ex: 0 4 indicates option values in position 0 and 4 are 
		/// present. `-` indicates a continuous range of option values. ex: 0 1-3 4 
		/// Decoding process: Example options: [Size, Color, Material] Example values: 
		/// [[Small, Medium, Large], [Red, Blue], [Cotton, Wool]] Example encoded 
		/// string: "0:0:0,1:0-1,,1:0:0-1,1:1,,2:0:1,1:0,," Step 1: Expand ranges into 
		/// the numbers they represent: "0:0:0,1:0 1,,1:0:0 1,1:1,,2:0:1,1:0,," Step 2: 
		/// Expand repeated prefixes: "0:0:0,0:1:0 1,1:0:0 1,1:1:1,2:0:1,2:1:0," Step 
		/// 3: Expand shared prefixes so data is encoded as a string: 
		/// "0:0:0,0:1:0,0:1:1,1:0:0,1:0:1,1:1:1,2:0:1,2:1:0," Step 4: Map to options + 
		/// option values to determine existing variants: [Small, Red, Cotton] (0:0:0), 
		/// [Small, Blue, Cotton] (0:1:0), [Small, Blue, Wool] (0:1:1), [Medium, Red, 
		/// Cotton] (1:0:0), [Medium, Red, Wool] (1:0:1), [Medium, Blue, Wool] (1:1:1), 
		/// [Large, Red, Wool] (2:0:1), [Large, Blue, Cotton] (2:1:0). 
		@discardableResult
		open func encodedVariantAvailability(alias: String? = nil) -> ProductQuery {
			addField(field: "encodedVariantAvailability", aliasSuffix: alias)
			return self
		}

		/// An encoded string containing all option value combinations with a 
		/// corresponding variant. Integers represent option and values: [0,1] 
		/// represents option_value at array index 0 for the option at array index 0 
		/// `:`, `,`, ` ` and `-` are control characters. `:` indicates a new option. 
		/// ex: 0:1 indicates value 0 for the option in position 1, value 1 for the 
		/// option in position 2. `,` indicates the end of a repeated prefix, mulitple 
		/// consecutive commas indicate the end of multiple repeated prefixes. ` ` 
		/// indicates a gap in the sequence of option values. ex: 0 4 indicates option 
		/// values in position 0 and 4 are present. `-` indicates a continuous range of 
		/// option values. ex: 0 1-3 4 Decoding process: Example options: [Size, Color, 
		/// Material] Example values: [[Small, Medium, Large], [Red, Blue], [Cotton, 
		/// Wool]] Example encoded string: "0:0:0,1:0-1,,1:0:0-1,1:1,,2:0:1,1:0,," Step 
		/// 1: Expand ranges into the numbers they represent: "0:0:0,1:0 1,,1:0:0 
		/// 1,1:1,,2:0:1,1:0,," Step 2: Expand repeated prefixes: "0:0:0,0:1:0 1,1:0:0 
		/// 1,1:1:1,2:0:1,2:1:0," Step 3: Expand shared prefixes so data is encoded as 
		/// a string: "0:0:0,0:1:0,0:1:1,1:0:0,1:0:1,1:1:1,2:0:1,2:1:0," Step 4: Map to 
		/// options + option values to determine existing variants: [Small, Red, 
		/// Cotton] (0:0:0), [Small, Blue, Cotton] (0:1:0), [Small, Blue, Wool] 
		/// (0:1:1), [Medium, Red, Cotton] (1:0:0), [Medium, Red, Wool] (1:0:1), 
		/// [Medium, Blue, Wool] (1:1:1), [Large, Red, Wool] (2:0:1), [Large, Blue, 
		/// Cotton] (2:1:0). 
		@discardableResult
		open func encodedVariantExistence(alias: String? = nil) -> ProductQuery {
			addField(field: "encodedVariantExistence", aliasSuffix: alias)
			return self
		}

		/// The featured image for the product. This field is functionally equivalent 
		/// to `images(first: 1)`. 
		@discardableResult
		open func featuredImage(alias: String? = nil, _ subfields: (ImageQuery) -> Void) -> ProductQuery {
			let subquery = ImageQuery()
			subfields(subquery)

			addField(field: "featuredImage", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A unique, human-readable string of the product's title. A handle can 
		/// contain letters, hyphens (`-`), and numbers, but no spaces. The handle is 
		/// used in the online store URL for the product. 
		@discardableResult
		open func handle(alias: String? = nil) -> ProductQuery {
			addField(field: "handle", aliasSuffix: alias)
			return self
		}

		/// A globally-unique ID. 
		@discardableResult
		open func id(alias: String? = nil) -> ProductQuery {
			addField(field: "id", aliasSuffix: alias)
			return self
		}

		/// List of images associated with the product. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///
		@discardableResult
		open func images(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductImageSortKeys? = nil, _ subfields: (ImageConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ImageConnectionQuery()
			subfields(subquery)

			addField(field: "images", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// Whether the product is a gift card. 
		@discardableResult
		open func isGiftCard(alias: String? = nil) -> ProductQuery {
			addField(field: "isGiftCard", aliasSuffix: alias)
			return self
		}

		/// The [media](/docs/apps/build/online-store/product-media) that are 
		/// associated with the product. Valid media are images, 3D models, videos. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///
		@discardableResult
		open func media(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductMediaSortKeys? = nil, _ subfields: (MediaConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MediaConnectionQuery()
			subfields(subquery)

			addField(field: "media", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		///
		/// - parameters:
		///     - namespace: The container the metafield belongs to. If omitted, the app-reserved namespace will be used.
		///     - key: The identifier for the metafield.
		///
		@discardableResult
		open func metafield(alias: String? = nil, namespace: String? = nil, key: String, _ subfields: (MetafieldQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("key:\(GraphQL.quoteString(input: key))")

			if let namespace = namespace {
				args.append("namespace:\(GraphQL.quoteString(input: namespace))")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafield", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
		///
		/// - parameters:
		///     - identifiers: The list of metafields to retrieve by namespace and key.
		///        
		///        The input must not contain more than `250` values.
		///
		@discardableResult
		open func metafields(alias: String? = nil, identifiers: [HasMetafieldsIdentifier], _ subfields: (MetafieldQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("identifiers:[\(identifiers.map { "\($0.serialize())" }.joined(separator: ","))]")

			let argsString = "(\(args.joined(separator: ",")))"

			let subquery = MetafieldQuery()
			subfields(subquery)

			addField(field: "metafields", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The product's URL on the online store. If `null`, then the product isn't 
		/// published to the online store sales channel. 
		@discardableResult
		open func onlineStoreUrl(alias: String? = nil) -> ProductQuery {
			addField(field: "onlineStoreUrl", aliasSuffix: alias)
			return self
		}

		/// A list of product options. The limit is defined by the [shop's resource 
		/// limits for product 
		/// options](/docs/api/admin-graphql/latest/objects/Shop#field-resourcelimits) 
		/// (`Shop.resourceLimits.maxProductOptions`). 
		///
		/// - parameters:
		///     - first: Truncate the array result to this size.
		///
		@discardableResult
		open func options(alias: String? = nil, first: Int32? = nil, _ subfields: (ProductOptionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductOptionQuery()
			subfields(subquery)

			addField(field: "options", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The minimum and maximum prices of a product, expressed in decimal numbers. 
		/// For example, if the product is priced between $10.00 and $50.00, then the 
		/// price range is $10.00 - $50.00. 
		@discardableResult
		open func priceRange(alias: String? = nil, _ subfields: (ProductPriceRangeQuery) -> Void) -> ProductQuery {
			let subquery = ProductPriceRangeQuery()
			subfields(subquery)

			addField(field: "priceRange", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The [product 
		/// type](https://help.shopify.com/manual/products/details/product-type) that 
		/// merchants define. 
		@discardableResult
		open func productType(alias: String? = nil) -> ProductQuery {
			addField(field: "productType", aliasSuffix: alias)
			return self
		}

		/// The date and time when the product was published to the channel. 
		@discardableResult
		open func publishedAt(alias: String? = nil) -> ProductQuery {
			addField(field: "publishedAt", aliasSuffix: alias)
			return self
		}

		/// Whether the product can only be purchased with a [selling 
		/// plan](/docs/apps/build/purchase-options/subscriptions/selling-plans). 
		/// Products that are sold on subscription (`requiresSellingPlan: true`) can be 
		/// updated only for online stores. If you update a product to be 
		/// subscription-only (`requiresSellingPlan:false`), then the product is 
		/// unpublished from all channels, except the online store. 
		@discardableResult
		open func requiresSellingPlan(alias: String? = nil) -> ProductQuery {
			addField(field: "requiresSellingPlan", aliasSuffix: alias)
			return self
		}

		/// Find an active product variant based on selected options, availability or 
		/// the first variant. All arguments are optional. If no selected options are 
		/// provided, the first available variant is returned. If no variants are 
		/// available, the first variant is returned. 
		///
		/// - parameters:
		///     - selectedOptions: The input fields used for a selected option.
		///        
		///        The input must not contain more than `250` values.
		///     - ignoreUnknownOptions: Whether to ignore unknown product options.
		///     - caseInsensitiveMatch: Whether to perform case insensitive match on option names and values.
		///
		@discardableResult
		open func selectedOrFirstAvailableVariant(alias: String? = nil, selectedOptions: [SelectedOptionInput]? = nil, ignoreUnknownOptions: Bool? = nil, caseInsensitiveMatch: Bool? = nil, _ subfields: (ProductVariantQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let selectedOptions = selectedOptions {
				args.append("selectedOptions:[\(selectedOptions.map { "\($0.serialize())" }.joined(separator: ","))]")
			}

			if let ignoreUnknownOptions = ignoreUnknownOptions {
				args.append("ignoreUnknownOptions:\(ignoreUnknownOptions)")
			}

			if let caseInsensitiveMatch = caseInsensitiveMatch {
				args.append("caseInsensitiveMatch:\(caseInsensitiveMatch)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "selectedOrFirstAvailableVariant", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A list of all [selling plan 
		/// groups](/docs/apps/build/purchase-options/subscriptions/selling-plans/build-a-selling-plan) 
		/// that are associated with the product either directly, or through the 
		/// product's variants. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///
		@discardableResult
		open func sellingPlanGroups(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, _ subfields: (SellingPlanGroupConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = SellingPlanGroupConnectionQuery()
			subfields(subquery)

			addField(field: "sellingPlanGroups", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The [SEO title and 
		/// description](https://help.shopify.com/manual/promoting-marketing/seo/adding-keywords) 
		/// that are associated with a product. 
		@discardableResult
		open func seo(alias: String? = nil, _ subfields: (SEOQuery) -> Void) -> ProductQuery {
			let subquery = SEOQuery()
			subfields(subquery)

			addField(field: "seo", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// A comma-separated list of searchable keywords that are associated with the 
		/// product. For example, a merchant might apply the `sports` and `summer` tags 
		/// to products that are associated with sportwear for summer. Updating `tags` 
		/// overwrites any existing tags that were previously added to the product. To 
		/// add new tags without overwriting existing tags, use the GraphQL Admin API's 
		/// [`tagsAdd`](/docs/api/admin-graphql/latest/mutations/tagsadd) mutation. 
		@discardableResult
		open func tags(alias: String? = nil) -> ProductQuery {
			addField(field: "tags", aliasSuffix: alias)
			return self
		}

		/// The name for the product that displays to customers. The title is used to 
		/// construct the product's handle. For example, if a product is titled "Black 
		/// Sunglasses", then the handle is `black-sunglasses`. 
		@discardableResult
		open func title(alias: String? = nil) -> ProductQuery {
			addField(field: "title", aliasSuffix: alias)
			return self
		}

		/// The quantity of inventory that's in stock. 
		@discardableResult
		open func totalInventory(alias: String? = nil) -> ProductQuery {
			addField(field: "totalInventory", aliasSuffix: alias)
			return self
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		@discardableResult
		open func trackingParameters(alias: String? = nil) -> ProductQuery {
			addField(field: "trackingParameters", aliasSuffix: alias)
			return self
		}

		/// The date and time when the product was last modified. A product's 
		/// `updatedAt` value can change for different reasons. For example, if an 
		/// order is placed for a product that has inventory tracking set up, then the 
		/// inventory adjustment is counted as an update. 
		@discardableResult
		open func updatedAt(alias: String? = nil) -> ProductQuery {
			addField(field: "updatedAt", aliasSuffix: alias)
			return self
		}

		/// Find a product’s variant based on its selected options. This is useful for 
		/// converting a user’s selection of product options into a single matching 
		/// variant. If there is not a variant for the selected options, `null` will be 
		/// returned. 
		///
		/// - parameters:
		///     - selectedOptions: The input fields used for a selected option.
		///        
		///        The input must not contain more than `250` values.
		///     - ignoreUnknownOptions: Whether to ignore unknown product options.
		///     - caseInsensitiveMatch: Whether to perform case insensitive match on option names and values.
		///
		@discardableResult
		open func variantBySelectedOptions(alias: String? = nil, selectedOptions: [SelectedOptionInput], ignoreUnknownOptions: Bool? = nil, caseInsensitiveMatch: Bool? = nil, _ subfields: (ProductVariantQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			args.append("selectedOptions:[\(selectedOptions.map { "\($0.serialize())" }.joined(separator: ","))]")

			if let ignoreUnknownOptions = ignoreUnknownOptions {
				args.append("ignoreUnknownOptions:\(ignoreUnknownOptions)")
			}

			if let caseInsensitiveMatch = caseInsensitiveMatch {
				args.append("caseInsensitiveMatch:\(caseInsensitiveMatch)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantQuery()
			subfields(subquery)

			addField(field: "variantBySelectedOptions", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// A list of [variants](/docs/api/storefront/latest/objects/ProductVariant) 
		/// that are associated with the product. 
		///
		/// - parameters:
		///     - first: Returns up to the first `n` elements from the list.
		///     - after: Returns the elements that come after the specified cursor.
		///     - last: Returns up to the last `n` elements from the list.
		///     - before: Returns the elements that come before the specified cursor.
		///     - reverse: Reverse the order of the underlying list.
		///     - sortKey: Sort the underlying list by the given key.
		///
		@discardableResult
		open func variants(alias: String? = nil, first: Int32? = nil, after: String? = nil, last: Int32? = nil, before: String? = nil, reverse: Bool? = nil, sortKey: ProductVariantSortKeys? = nil, _ subfields: (ProductVariantConnectionQuery) -> Void) -> ProductQuery {
			var args: [String] = []

			if let first = first {
				args.append("first:\(first)")
			}

			if let after = after {
				args.append("after:\(GraphQL.quoteString(input: after))")
			}

			if let last = last {
				args.append("last:\(last)")
			}

			if let before = before {
				args.append("before:\(GraphQL.quoteString(input: before))")
			}

			if let reverse = reverse {
				args.append("reverse:\(reverse)")
			}

			if let sortKey = sortKey {
				args.append("sortKey:\(sortKey.rawValue)")
			}

			let argsString: String? = args.isEmpty ? nil : "(\(args.joined(separator: ",")))"

			let subquery = ProductVariantConnectionQuery()
			subfields(subquery)

			addField(field: "variants", aliasSuffix: alias, args: argsString, subfields: subquery)
			return self
		}

		/// The number of 
		/// [variants](/docs/api/storefront/latest/objects/ProductVariant) that are 
		/// associated with the product. 
		@discardableResult
		open func variantsCount(alias: String? = nil, _ subfields: (CountQuery) -> Void) -> ProductQuery {
			let subquery = CountQuery()
			subfields(subquery)

			addField(field: "variantsCount", aliasSuffix: alias, subfields: subquery)
			return self
		}

		/// The name of the product's vendor. 
		@discardableResult
		open func vendor(alias: String? = nil) -> ProductQuery {
			addField(field: "vendor", aliasSuffix: alias)
			return self
		}
	}

	/// The `Product` object lets you manage products in a merchant’s store. 
	/// Products are the goods and services that merchants offer to customers. They 
	/// can include various details such as title, description, price, images, and 
	/// options such as size or color. You can use [product 
	/// variants](/docs/api/storefront/latest/objects/ProductVariant) to create or 
	/// update different versions of the same product. You can also add or update 
	/// product [media](/docs/api/storefront/latest/interfaces/Media). Products can 
	/// be organized by grouping them into a 
	/// [collection](/docs/api/storefront/latest/objects/Collection). Learn more 
	/// about working with [products and 
	/// collections](/docs/storefronts/headless/building-with-the-storefront-api/products-collections). 
	open class Product: GraphQL.AbstractResponse, GraphQLObject, HasMetafields, MenuItemResource, MetafieldParentResource, MetafieldReference, Node, OnlineStorePublishable, SearchResultItem, Trackable {
		public typealias Query = ProductQuery

		internal override func deserializeValue(fieldName: String, value: Any) throws -> Any? {
			let fieldValue = value
			switch fieldName {
				case "adjacentVariants":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ProductVariant(fields: $0) }

				case "availableForSale":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "category":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try TaxonomyCategory(fields: value)

				case "collections":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try CollectionConnection(fields: value)

				case "compareAtPriceRange":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductPriceRange(fields: value)

				case "createdAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "description":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "descriptionHtml":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "encodedVariantAvailability":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "encodedVariantExistence":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "featuredImage":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try Image(fields: value)

				case "handle":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "id":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.ID(rawValue: value)

				case "images":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ImageConnection(fields: value)

				case "isGiftCard":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "media":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try MediaConnection(fields: value)

				case "metafield":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value)

				case "metafields":
				guard let value = value as? [Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try value.map { if $0 is NSNull { return nil }
				guard let value = $0 as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try Metafield(fields: value) } as [Any?]

				case "onlineStoreUrl":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return URL(string: value)!

				case "options":
				guard let value = value as? [[String: Any]] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try value.map { return try ProductOption(fields: $0) }

				case "priceRange":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductPriceRange(fields: value)

				case "productType":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "publishedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "requiresSellingPlan":
				guard let value = value as? Bool else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "selectedOrFirstAvailableVariant":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				case "sellingPlanGroups":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try SellingPlanGroupConnection(fields: value)

				case "seo":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try SEO(fields: value)

				case "tags":
				guard let value = value as? [String] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value.map { return $0 }

				case "title":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "totalInventory":
				if value is NSNull { return nil }
				guard let value = value as? Int else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return Int32(value)

				case "trackingParameters":
				if value is NSNull { return nil }
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				case "updatedAt":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return GraphQL.iso8601DateParser.date(from: value)!

				case "variantBySelectedOptions":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariant(fields: value)

				case "variants":
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try ProductVariantConnection(fields: value)

				case "variantsCount":
				if value is NSNull { return nil }
				guard let value = value as? [String: Any] else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return try Count(fields: value)

				case "vendor":
				guard let value = value as? String else {
					throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
				}
				return value

				default:
				throw SchemaViolationError(type: Product.self, field: fieldName, value: fieldValue)
			}
		}

		/// A list of variants whose selected options differ with the provided selected 
		/// options by one, ordered by variant id. If selected options are not 
		/// provided, adjacent variants to the first available variant is returned. 
		/// Note that this field returns an array of variants. In most cases, the 
		/// number of variants in this array will be low. However, with a low number of 
		/// options and a high number of values per option, the number of variants 
		/// returned here can be high. In such cases, it recommended to avoid using 
		/// this field. This list of variants can be used in combination with the 
		/// `options` field to build a rich variant picker that includes variant 
		/// availability or other variant information. 
		open var adjacentVariants: [Storefront.ProductVariant] {
			return internalGetAdjacentVariants()
		}

		open func aliasedAdjacentVariants(alias: String) -> [Storefront.ProductVariant] {
			return internalGetAdjacentVariants(alias: alias)
		}

		func internalGetAdjacentVariants(alias: String? = nil) -> [Storefront.ProductVariant] {
			return field(field: "adjacentVariants", aliasSuffix: alias) as! [Storefront.ProductVariant]
		}

		/// Indicates if at least one product variant is available for sale. 
		open var availableForSale: Bool {
			return internalGetAvailableForSale()
		}

		func internalGetAvailableForSale(alias: String? = nil) -> Bool {
			return field(field: "availableForSale", aliasSuffix: alias) as! Bool
		}

		/// The category of a product from [Shopify's Standard Product 
		/// Taxonomy](https://shopify.github.io/product-taxonomy/releases/unstable/?categoryId=sg-4-17-2-17). 
		open var category: Storefront.TaxonomyCategory? {
			return internalGetCategory()
		}

		func internalGetCategory(alias: String? = nil) -> Storefront.TaxonomyCategory? {
			return field(field: "category", aliasSuffix: alias) as! Storefront.TaxonomyCategory?
		}

		/// A list of [collections](/docs/api/storefront/latest/objects/Collection) 
		/// that include the product. 
		open var collections: Storefront.CollectionConnection {
			return internalGetCollections()
		}

		open func aliasedCollections(alias: String) -> Storefront.CollectionConnection {
			return internalGetCollections(alias: alias)
		}

		func internalGetCollections(alias: String? = nil) -> Storefront.CollectionConnection {
			return field(field: "collections", aliasSuffix: alias) as! Storefront.CollectionConnection
		}

		/// The [compare-at price 
		/// range](https://help.shopify.com/manual/products/details/product-pricing/sale-pricing) 
		/// of the product in the shop's default currency. 
		open var compareAtPriceRange: Storefront.ProductPriceRange {
			return internalGetCompareAtPriceRange()
		}

		func internalGetCompareAtPriceRange(alias: String? = nil) -> Storefront.ProductPriceRange {
			return field(field: "compareAtPriceRange", aliasSuffix: alias) as! Storefront.ProductPriceRange
		}

		/// The date and time when the product was created. 
		open var createdAt: Date {
			return internalGetCreatedAt()
		}

		func internalGetCreatedAt(alias: String? = nil) -> Date {
			return field(field: "createdAt", aliasSuffix: alias) as! Date
		}

		/// A single-line description of the product, with [HTML 
		/// tags](https://developer.mozilla.org/en-US/docs/Web/HTML) removed. 
		open var description: String {
			return internalGetDescription()
		}

		open func aliasedDescription(alias: String) -> String {
			return internalGetDescription(alias: alias)
		}

		func internalGetDescription(alias: String? = nil) -> String {
			return field(field: "description", aliasSuffix: alias) as! String
		}

		/// The description of the product, with HTML tags. For example, the 
		/// description might include bold `<strong></strong>` and italic `<i></i>` 
		/// text. 
		open var descriptionHtml: String {
			return internalGetDescriptionHtml()
		}

		func internalGetDescriptionHtml(alias: String? = nil) -> String {
			return field(field: "descriptionHtml", aliasSuffix: alias) as! String
		}

		/// An encoded string containing all option value combinations with a 
		/// corresponding variant that is currently available for sale. Integers 
		/// represent option and values: [0,1] represents option_value at array index 0 
		/// for the option at array index 0 `:`, `,`, ` ` and `-` are control 
		/// characters. `:` indicates a new option. ex: 0:1 indicates value 0 for the 
		/// option in position 1, value 1 for the option in position 2. `,` indicates 
		/// the end of a repeated prefix, mulitple consecutive commas indicate the end 
		/// of multiple repeated prefixes. ` ` indicates a gap in the sequence of 
		/// option values. ex: 0 4 indicates option values in position 0 and 4 are 
		/// present. `-` indicates a continuous range of option values. ex: 0 1-3 4 
		/// Decoding process: Example options: [Size, Color, Material] Example values: 
		/// [[Small, Medium, Large], [Red, Blue], [Cotton, Wool]] Example encoded 
		/// string: "0:0:0,1:0-1,,1:0:0-1,1:1,,2:0:1,1:0,," Step 1: Expand ranges into 
		/// the numbers they represent: "0:0:0,1:0 1,,1:0:0 1,1:1,,2:0:1,1:0,," Step 2: 
		/// Expand repeated prefixes: "0:0:0,0:1:0 1,1:0:0 1,1:1:1,2:0:1,2:1:0," Step 
		/// 3: Expand shared prefixes so data is encoded as a string: 
		/// "0:0:0,0:1:0,0:1:1,1:0:0,1:0:1,1:1:1,2:0:1,2:1:0," Step 4: Map to options + 
		/// option values to determine existing variants: [Small, Red, Cotton] (0:0:0), 
		/// [Small, Blue, Cotton] (0:1:0), [Small, Blue, Wool] (0:1:1), [Medium, Red, 
		/// Cotton] (1:0:0), [Medium, Red, Wool] (1:0:1), [Medium, Blue, Wool] (1:1:1), 
		/// [Large, Red, Wool] (2:0:1), [Large, Blue, Cotton] (2:1:0). 
		open var encodedVariantAvailability: String? {
			return internalGetEncodedVariantAvailability()
		}

		func internalGetEncodedVariantAvailability(alias: String? = nil) -> String? {
			return field(field: "encodedVariantAvailability", aliasSuffix: alias) as! String?
		}

		/// An encoded string containing all option value combinations with a 
		/// corresponding variant. Integers represent option and values: [0,1] 
		/// represents option_value at array index 0 for the option at array index 0 
		/// `:`, `,`, ` ` and `-` are control characters. `:` indicates a new option. 
		/// ex: 0:1 indicates value 0 for the option in position 1, value 1 for the 
		/// option in position 2. `,` indicates the end of a repeated prefix, mulitple 
		/// consecutive commas indicate the end of multiple repeated prefixes. ` ` 
		/// indicates a gap in the sequence of option values. ex: 0 4 indicates option 
		/// values in position 0 and 4 are present. `-` indicates a continuous range of 
		/// option values. ex: 0 1-3 4 Decoding process: Example options: [Size, Color, 
		/// Material] Example values: [[Small, Medium, Large], [Red, Blue], [Cotton, 
		/// Wool]] Example encoded string: "0:0:0,1:0-1,,1:0:0-1,1:1,,2:0:1,1:0,," Step 
		/// 1: Expand ranges into the numbers they represent: "0:0:0,1:0 1,,1:0:0 
		/// 1,1:1,,2:0:1,1:0,," Step 2: Expand repeated prefixes: "0:0:0,0:1:0 1,1:0:0 
		/// 1,1:1:1,2:0:1,2:1:0," Step 3: Expand shared prefixes so data is encoded as 
		/// a string: "0:0:0,0:1:0,0:1:1,1:0:0,1:0:1,1:1:1,2:0:1,2:1:0," Step 4: Map to 
		/// options + option values to determine existing variants: [Small, Red, 
		/// Cotton] (0:0:0), [Small, Blue, Cotton] (0:1:0), [Small, Blue, Wool] 
		/// (0:1:1), [Medium, Red, Cotton] (1:0:0), [Medium, Red, Wool] (1:0:1), 
		/// [Medium, Blue, Wool] (1:1:1), [Large, Red, Wool] (2:0:1), [Large, Blue, 
		/// Cotton] (2:1:0). 
		open var encodedVariantExistence: String? {
			return internalGetEncodedVariantExistence()
		}

		func internalGetEncodedVariantExistence(alias: String? = nil) -> String? {
			return field(field: "encodedVariantExistence", aliasSuffix: alias) as! String?
		}

		/// The featured image for the product. This field is functionally equivalent 
		/// to `images(first: 1)`. 
		open var featuredImage: Storefront.Image? {
			return internalGetFeaturedImage()
		}

		func internalGetFeaturedImage(alias: String? = nil) -> Storefront.Image? {
			return field(field: "featuredImage", aliasSuffix: alias) as! Storefront.Image?
		}

		/// A unique, human-readable string of the product's title. A handle can 
		/// contain letters, hyphens (`-`), and numbers, but no spaces. The handle is 
		/// used in the online store URL for the product. 
		open var handle: String {
			return internalGetHandle()
		}

		func internalGetHandle(alias: String? = nil) -> String {
			return field(field: "handle", aliasSuffix: alias) as! String
		}

		/// A globally-unique ID. 
		open var id: GraphQL.ID {
			return internalGetId()
		}

		func internalGetId(alias: String? = nil) -> GraphQL.ID {
			return field(field: "id", aliasSuffix: alias) as! GraphQL.ID
		}

		/// List of images associated with the product. 
		open var images: Storefront.ImageConnection {
			return internalGetImages()
		}

		open func aliasedImages(alias: String) -> Storefront.ImageConnection {
			return internalGetImages(alias: alias)
		}

		func internalGetImages(alias: String? = nil) -> Storefront.ImageConnection {
			return field(field: "images", aliasSuffix: alias) as! Storefront.ImageConnection
		}

		/// Whether the product is a gift card. 
		open var isGiftCard: Bool {
			return internalGetIsGiftCard()
		}

		func internalGetIsGiftCard(alias: String? = nil) -> Bool {
			return field(field: "isGiftCard", aliasSuffix: alias) as! Bool
		}

		/// The [media](/docs/apps/build/online-store/product-media) that are 
		/// associated with the product. Valid media are images, 3D models, videos. 
		open var media: Storefront.MediaConnection {
			return internalGetMedia()
		}

		open func aliasedMedia(alias: String) -> Storefront.MediaConnection {
			return internalGetMedia(alias: alias)
		}

		func internalGetMedia(alias: String? = nil) -> Storefront.MediaConnection {
			return field(field: "media", aliasSuffix: alias) as! Storefront.MediaConnection
		}

		/// A [custom field](https://shopify.dev/docs/apps/build/custom-data), 
		/// including its `namespace` and `key`, that's associated with a Shopify 
		/// resource for the purposes of adding and storing additional information. 
		open var metafield: Storefront.Metafield? {
			return internalGetMetafield()
		}

		open func aliasedMetafield(alias: String) -> Storefront.Metafield? {
			return internalGetMetafield(alias: alias)
		}

		func internalGetMetafield(alias: String? = nil) -> Storefront.Metafield? {
			return field(field: "metafield", aliasSuffix: alias) as! Storefront.Metafield?
		}

		/// A list of [custom fields](/docs/apps/build/custom-data) that a merchant 
		/// associates with a Shopify resource. 
		open var metafields: [Storefront.Metafield?] {
			return internalGetMetafields()
		}

		open func aliasedMetafields(alias: String) -> [Storefront.Metafield?] {
			return internalGetMetafields(alias: alias)
		}

		func internalGetMetafields(alias: String? = nil) -> [Storefront.Metafield?] {
			return field(field: "metafields", aliasSuffix: alias) as! [Storefront.Metafield?]
		}

		/// The product's URL on the online store. If `null`, then the product isn't 
		/// published to the online store sales channel. 
		open var onlineStoreUrl: URL? {
			return internalGetOnlineStoreUrl()
		}

		func internalGetOnlineStoreUrl(alias: String? = nil) -> URL? {
			return field(field: "onlineStoreUrl", aliasSuffix: alias) as! URL?
		}

		/// A list of product options. The limit is defined by the [shop's resource 
		/// limits for product 
		/// options](/docs/api/admin-graphql/latest/objects/Shop#field-resourcelimits) 
		/// (`Shop.resourceLimits.maxProductOptions`). 
		open var options: [Storefront.ProductOption] {
			return internalGetOptions()
		}

		open func aliasedOptions(alias: String) -> [Storefront.ProductOption] {
			return internalGetOptions(alias: alias)
		}

		func internalGetOptions(alias: String? = nil) -> [Storefront.ProductOption] {
			return field(field: "options", aliasSuffix: alias) as! [Storefront.ProductOption]
		}

		/// The minimum and maximum prices of a product, expressed in decimal numbers. 
		/// For example, if the product is priced between $10.00 and $50.00, then the 
		/// price range is $10.00 - $50.00. 
		open var priceRange: Storefront.ProductPriceRange {
			return internalGetPriceRange()
		}

		func internalGetPriceRange(alias: String? = nil) -> Storefront.ProductPriceRange {
			return field(field: "priceRange", aliasSuffix: alias) as! Storefront.ProductPriceRange
		}

		/// The [product 
		/// type](https://help.shopify.com/manual/products/details/product-type) that 
		/// merchants define. 
		open var productType: String {
			return internalGetProductType()
		}

		func internalGetProductType(alias: String? = nil) -> String {
			return field(field: "productType", aliasSuffix: alias) as! String
		}

		/// The date and time when the product was published to the channel. 
		open var publishedAt: Date {
			return internalGetPublishedAt()
		}

		func internalGetPublishedAt(alias: String? = nil) -> Date {
			return field(field: "publishedAt", aliasSuffix: alias) as! Date
		}

		/// Whether the product can only be purchased with a [selling 
		/// plan](/docs/apps/build/purchase-options/subscriptions/selling-plans). 
		/// Products that are sold on subscription (`requiresSellingPlan: true`) can be 
		/// updated only for online stores. If you update a product to be 
		/// subscription-only (`requiresSellingPlan:false`), then the product is 
		/// unpublished from all channels, except the online store. 
		open var requiresSellingPlan: Bool {
			return internalGetRequiresSellingPlan()
		}

		func internalGetRequiresSellingPlan(alias: String? = nil) -> Bool {
			return field(field: "requiresSellingPlan", aliasSuffix: alias) as! Bool
		}

		/// Find an active product variant based on selected options, availability or 
		/// the first variant. All arguments are optional. If no selected options are 
		/// provided, the first available variant is returned. If no variants are 
		/// available, the first variant is returned. 
		open var selectedOrFirstAvailableVariant: Storefront.ProductVariant? {
			return internalGetSelectedOrFirstAvailableVariant()
		}

		open func aliasedSelectedOrFirstAvailableVariant(alias: String) -> Storefront.ProductVariant? {
			return internalGetSelectedOrFirstAvailableVariant(alias: alias)
		}

		func internalGetSelectedOrFirstAvailableVariant(alias: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "selectedOrFirstAvailableVariant", aliasSuffix: alias) as! Storefront.ProductVariant?
		}

		/// A list of all [selling plan 
		/// groups](/docs/apps/build/purchase-options/subscriptions/selling-plans/build-a-selling-plan) 
		/// that are associated with the product either directly, or through the 
		/// product's variants. 
		open var sellingPlanGroups: Storefront.SellingPlanGroupConnection {
			return internalGetSellingPlanGroups()
		}

		open func aliasedSellingPlanGroups(alias: String) -> Storefront.SellingPlanGroupConnection {
			return internalGetSellingPlanGroups(alias: alias)
		}

		func internalGetSellingPlanGroups(alias: String? = nil) -> Storefront.SellingPlanGroupConnection {
			return field(field: "sellingPlanGroups", aliasSuffix: alias) as! Storefront.SellingPlanGroupConnection
		}

		/// The [SEO title and 
		/// description](https://help.shopify.com/manual/promoting-marketing/seo/adding-keywords) 
		/// that are associated with a product. 
		open var seo: Storefront.SEO {
			return internalGetSeo()
		}

		func internalGetSeo(alias: String? = nil) -> Storefront.SEO {
			return field(field: "seo", aliasSuffix: alias) as! Storefront.SEO
		}

		/// A comma-separated list of searchable keywords that are associated with the 
		/// product. For example, a merchant might apply the `sports` and `summer` tags 
		/// to products that are associated with sportwear for summer. Updating `tags` 
		/// overwrites any existing tags that were previously added to the product. To 
		/// add new tags without overwriting existing tags, use the GraphQL Admin API's 
		/// [`tagsAdd`](/docs/api/admin-graphql/latest/mutations/tagsadd) mutation. 
		open var tags: [String] {
			return internalGetTags()
		}

		func internalGetTags(alias: String? = nil) -> [String] {
			return field(field: "tags", aliasSuffix: alias) as! [String]
		}

		/// The name for the product that displays to customers. The title is used to 
		/// construct the product's handle. For example, if a product is titled "Black 
		/// Sunglasses", then the handle is `black-sunglasses`. 
		open var title: String {
			return internalGetTitle()
		}

		func internalGetTitle(alias: String? = nil) -> String {
			return field(field: "title", aliasSuffix: alias) as! String
		}

		/// The quantity of inventory that's in stock. 
		open var totalInventory: Int32? {
			return internalGetTotalInventory()
		}

		func internalGetTotalInventory(alias: String? = nil) -> Int32? {
			return field(field: "totalInventory", aliasSuffix: alias) as! Int32?
		}

		/// URL parameters to be added to a page URL to track the origin of on-site 
		/// search traffic for [analytics 
		/// reporting](https://help.shopify.com/manual/reports-and-analytics/shopify-reports/report-types/default-reports/behaviour-reports). 
		/// Returns a result when accessed through the 
		/// [search](https://shopify.dev/docs/api/storefront/current/queries/search) or 
		/// [predictiveSearch](https://shopify.dev/docs/api/storefront/current/queries/predictiveSearch) 
		/// queries, otherwise returns null. 
		open var trackingParameters: String? {
			return internalGetTrackingParameters()
		}

		func internalGetTrackingParameters(alias: String? = nil) -> String? {
			return field(field: "trackingParameters", aliasSuffix: alias) as! String?
		}

		/// The date and time when the product was last modified. A product's 
		/// `updatedAt` value can change for different reasons. For example, if an 
		/// order is placed for a product that has inventory tracking set up, then the 
		/// inventory adjustment is counted as an update. 
		open var updatedAt: Date {
			return internalGetUpdatedAt()
		}

		func internalGetUpdatedAt(alias: String? = nil) -> Date {
			return field(field: "updatedAt", aliasSuffix: alias) as! Date
		}

		/// Find a product’s variant based on its selected options. This is useful for 
		/// converting a user’s selection of product options into a single matching 
		/// variant. If there is not a variant for the selected options, `null` will be 
		/// returned. 
		open var variantBySelectedOptions: Storefront.ProductVariant? {
			return internalGetVariantBySelectedOptions()
		}

		open func aliasedVariantBySelectedOptions(alias: String) -> Storefront.ProductVariant? {
			return internalGetVariantBySelectedOptions(alias: alias)
		}

		func internalGetVariantBySelectedOptions(alias: String? = nil) -> Storefront.ProductVariant? {
			return field(field: "variantBySelectedOptions", aliasSuffix: alias) as! Storefront.ProductVariant?
		}

		/// A list of [variants](/docs/api/storefront/latest/objects/ProductVariant) 
		/// that are associated with the product. 
		open var variants: Storefront.ProductVariantConnection {
			return internalGetVariants()
		}

		open func aliasedVariants(alias: String) -> Storefront.ProductVariantConnection {
			return internalGetVariants(alias: alias)
		}

		func internalGetVariants(alias: String? = nil) -> Storefront.ProductVariantConnection {
			return field(field: "variants", aliasSuffix: alias) as! Storefront.ProductVariantConnection
		}

		/// The number of 
		/// [variants](/docs/api/storefront/latest/objects/ProductVariant) that are 
		/// associated with the product. 
		open var variantsCount: Storefront.Count? {
			return internalGetVariantsCount()
		}

		func internalGetVariantsCount(alias: String? = nil) -> Storefront.Count? {
			return field(field: "variantsCount", aliasSuffix: alias) as! Storefront.Count?
		}

		/// The name of the product's vendor. 
		open var vendor: String {
			return internalGetVendor()
		}

		func internalGetVendor(alias: String? = nil) -> String {
			return field(field: "vendor", aliasSuffix: alias) as! String
		}

		internal override func childResponseObjectMap() -> [GraphQL.AbstractResponse] {
			var response: [GraphQL.AbstractResponse] = []
			objectMap.keys.forEach {
				switch $0 {
					case "adjacentVariants":
					internalGetAdjacentVariants().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "category":
					if let value = internalGetCategory() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "collections":
					response.append(internalGetCollections())
					response.append(contentsOf: internalGetCollections().childResponseObjectMap())

					case "compareAtPriceRange":
					response.append(internalGetCompareAtPriceRange())
					response.append(contentsOf: internalGetCompareAtPriceRange().childResponseObjectMap())

					case "featuredImage":
					if let value = internalGetFeaturedImage() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "images":
					response.append(internalGetImages())
					response.append(contentsOf: internalGetImages().childResponseObjectMap())

					case "media":
					response.append(internalGetMedia())
					response.append(contentsOf: internalGetMedia().childResponseObjectMap())

					case "metafield":
					if let value = internalGetMetafield() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "metafields":
					internalGetMetafields().forEach {
						if let value = $0 {
							response.append(value)
							response.append(contentsOf: value.childResponseObjectMap())
						}
					}

					case "options":
					internalGetOptions().forEach {
						response.append($0)
						response.append(contentsOf: $0.childResponseObjectMap())
					}

					case "priceRange":
					response.append(internalGetPriceRange())
					response.append(contentsOf: internalGetPriceRange().childResponseObjectMap())

					case "selectedOrFirstAvailableVariant":
					if let value = internalGetSelectedOrFirstAvailableVariant() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "sellingPlanGroups":
					response.append(internalGetSellingPlanGroups())
					response.append(contentsOf: internalGetSellingPlanGroups().childResponseObjectMap())

					case "seo":
					response.append(internalGetSeo())
					response.append(contentsOf: internalGetSeo().childResponseObjectMap())

					case "variantBySelectedOptions":
					if let value = internalGetVariantBySelectedOptions() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					case "variants":
					response.append(internalGetVariants())
					response.append(contentsOf: internalGetVariants().childResponseObjectMap())

					case "variantsCount":
					if let value = internalGetVariantsCount() {
						response.append(value)
						response.append(contentsOf: value.childResponseObjectMap())
					}

					default:
					break
				}
			}
			return response
		}
	}
}
