//
//  CartSelectableAddressInput.swift
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
	/// The input fields for a selectable delivery address in a cart. 
	open class CartSelectableAddressInput {
		/// Exactly one kind of delivery address. 
		open var address: CartAddressInput

		/// Sets exactly one address as pre-selected for the buyer. 
		open var selected: Input<Bool>

		/// When true, this delivery address will not be associated with the buyer 
		/// after a successful checkout. 
		open var oneTimeUse: Input<Bool>

		/// Defines what kind of address validation is requested. 
		open var validationStrategy: Input<DeliveryAddressValidationStrategy>

		/// Creates the input object.
		///
		/// - parameters:
		///     - address: Exactly one kind of delivery address.
		///     - selected: Sets exactly one address as pre-selected for the buyer.
		///     - oneTimeUse: When true, this delivery address will not be associated with the buyer after a successful checkout.
		///     - validationStrategy: Defines what kind of address validation is requested.
		///
		public static func create(address: CartAddressInput, selected: Input<Bool> = .undefined, oneTimeUse: Input<Bool> = .undefined, validationStrategy: Input<DeliveryAddressValidationStrategy> = .undefined) -> CartSelectableAddressInput {
			return CartSelectableAddressInput(address: address, selected: selected, oneTimeUse: oneTimeUse, validationStrategy: validationStrategy)
		}

		private init(address: CartAddressInput, selected: Input<Bool> = .undefined, oneTimeUse: Input<Bool> = .undefined, validationStrategy: Input<DeliveryAddressValidationStrategy> = .undefined) {
			self.address = address
			self.selected = selected
			self.oneTimeUse = oneTimeUse
			self.validationStrategy = validationStrategy
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - address: Exactly one kind of delivery address.
		///     - selected: Sets exactly one address as pre-selected for the buyer.
		///     - oneTimeUse: When true, this delivery address will not be associated with the buyer after a successful checkout.
		///     - validationStrategy: Defines what kind of address validation is requested.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(address: CartAddressInput, selected: Bool? = nil, oneTimeUse: Bool? = nil, validationStrategy: DeliveryAddressValidationStrategy? = nil) {
			self.init(address: address, selected: selected.orUndefined, oneTimeUse: oneTimeUse.orUndefined, validationStrategy: validationStrategy.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("address:\(address.serialize())")

			switch selected {
				case .value(let selected):
				guard let selected = selected else {
					fields.append("selected:null")
					break
				}
				fields.append("selected:\(selected)")
				case .undefined: break
			}

			switch oneTimeUse {
				case .value(let oneTimeUse):
				guard let oneTimeUse = oneTimeUse else {
					fields.append("oneTimeUse:null")
					break
				}
				fields.append("oneTimeUse:\(oneTimeUse)")
				case .undefined: break
			}

			switch validationStrategy {
				case .value(let validationStrategy):
				guard let validationStrategy = validationStrategy else {
					fields.append("validationStrategy:null")
					break
				}
				fields.append("validationStrategy:\(validationStrategy.rawValue)")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
