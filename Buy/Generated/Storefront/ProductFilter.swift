//
//  ProductFilter.swift
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

extension Storefront {
	/// The input fields for a filter used to view a subset of products in a 
	/// collection. By default, the `available` and `price` filters are enabled. 
	/// Filters are customized with the Shopify Search & Discovery app. Learn more 
	/// about [customizing storefront 
	/// filtering](https://help.shopify.com/manual/online-store/themes/customizing-themes/storefront-filters). 
	open class ProductFilter {
		/// Filter on if the product is available for sale. 
		open var available: Input<Bool>

		/// A variant option to filter on. 
		open var variantOption: Input<VariantOptionFilter>

		/// The product type to filter on. 
		open var productType: Input<String>

		/// The product vendor to filter on. 
		open var productVendor: Input<String>

		/// A range of prices to filter with-in. 
		open var price: Input<PriceRangeFilter>

		/// A product metafield to filter on. 
		open var productMetafield: Input<MetafieldFilter>

		/// A variant metafield to filter on. 
		open var variantMetafield: Input<MetafieldFilter>

		/// A product tag to filter on. 
		open var tag: Input<String>

		/// Creates the input object.
		///
		/// - parameters:
		///     - available: Filter on if the product is available for sale.
		///     - variantOption: A variant option to filter on.
		///     - productType: The product type to filter on.
		///     - productVendor: The product vendor to filter on.
		///     - price: A range of prices to filter with-in.
		///     - productMetafield: A product metafield to filter on.
		///     - variantMetafield: A variant metafield to filter on.
		///     - tag: A product tag to filter on.
		///
		public static func create(available: Input<Bool> = .undefined, variantOption: Input<VariantOptionFilter> = .undefined, productType: Input<String> = .undefined, productVendor: Input<String> = .undefined, price: Input<PriceRangeFilter> = .undefined, productMetafield: Input<MetafieldFilter> = .undefined, variantMetafield: Input<MetafieldFilter> = .undefined, tag: Input<String> = .undefined) -> ProductFilter {
			return ProductFilter(available: available, variantOption: variantOption, productType: productType, productVendor: productVendor, price: price, productMetafield: productMetafield, variantMetafield: variantMetafield, tag: tag)
		}

		private init(available: Input<Bool> = .undefined, variantOption: Input<VariantOptionFilter> = .undefined, productType: Input<String> = .undefined, productVendor: Input<String> = .undefined, price: Input<PriceRangeFilter> = .undefined, productMetafield: Input<MetafieldFilter> = .undefined, variantMetafield: Input<MetafieldFilter> = .undefined, tag: Input<String> = .undefined) {
			self.available = available
			self.variantOption = variantOption
			self.productType = productType
			self.productVendor = productVendor
			self.price = price
			self.productMetafield = productMetafield
			self.variantMetafield = variantMetafield
			self.tag = tag
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - available: Filter on if the product is available for sale.
		///     - variantOption: A variant option to filter on.
		///     - productType: The product type to filter on.
		///     - productVendor: The product vendor to filter on.
		///     - price: A range of prices to filter with-in.
		///     - productMetafield: A product metafield to filter on.
		///     - variantMetafield: A variant metafield to filter on.
		///     - tag: A product tag to filter on.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(available: Bool? = nil, variantOption: VariantOptionFilter? = nil, productType: String? = nil, productVendor: String? = nil, price: PriceRangeFilter? = nil, productMetafield: MetafieldFilter? = nil, variantMetafield: MetafieldFilter? = nil, tag: String? = nil) {
			self.init(available: available.orUndefined, variantOption: variantOption.orUndefined, productType: productType.orUndefined, productVendor: productVendor.orUndefined, price: price.orUndefined, productMetafield: productMetafield.orUndefined, variantMetafield: variantMetafield.orUndefined, tag: tag.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch available {
				case .value(let available): 
				guard let available = available else {
					fields.append("available:null")
					break
				}
				fields.append("available:\(available)")
				case .undefined: break
			}

			switch variantOption {
				case .value(let variantOption): 
				guard let variantOption = variantOption else {
					fields.append("variantOption:null")
					break
				}
				fields.append("variantOption:\(variantOption.serialize())")
				case .undefined: break
			}

			switch productType {
				case .value(let productType): 
				guard let productType = productType else {
					fields.append("productType:null")
					break
				}
				fields.append("productType:\(GraphQL.quoteString(input: productType))")
				case .undefined: break
			}

			switch productVendor {
				case .value(let productVendor): 
				guard let productVendor = productVendor else {
					fields.append("productVendor:null")
					break
				}
				fields.append("productVendor:\(GraphQL.quoteString(input: productVendor))")
				case .undefined: break
			}

			switch price {
				case .value(let price): 
				guard let price = price else {
					fields.append("price:null")
					break
				}
				fields.append("price:\(price.serialize())")
				case .undefined: break
			}

			switch productMetafield {
				case .value(let productMetafield): 
				guard let productMetafield = productMetafield else {
					fields.append("productMetafield:null")
					break
				}
				fields.append("productMetafield:\(productMetafield.serialize())")
				case .undefined: break
			}

			switch variantMetafield {
				case .value(let variantMetafield): 
				guard let variantMetafield = variantMetafield else {
					fields.append("variantMetafield:null")
					break
				}
				fields.append("variantMetafield:\(variantMetafield.serialize())")
				case .undefined: break
			}

			switch tag {
				case .value(let tag): 
				guard let tag = tag else {
					fields.append("tag:null")
					break
				}
				fields.append("tag:\(GraphQL.quoteString(input: tag))")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
