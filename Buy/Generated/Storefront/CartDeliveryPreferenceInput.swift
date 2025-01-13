//
//  CartDeliveryPreferenceInput.swift
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
	/// Delivery preferences can be used to prefill the delivery section at 
	/// checkout. 
	open class CartDeliveryPreferenceInput {
		/// The preferred delivery methods such as shipping, local pickup or through 
		/// pickup points. The input must not contain more than `250` values. 
		open var deliveryMethod: Input<[PreferenceDeliveryMethodType]>

		/// The pickup handle prefills checkout fields with the location for either 
		/// local pickup or pickup points delivery methods. It accepts both location ID 
		/// for local pickup and external IDs for pickup points. The input must not 
		/// contain more than `250` values. 
		open var pickupHandle: Input<[String]>

		/// The coordinates of a delivery location in order of preference. 
		open var coordinates: Input<CartDeliveryCoordinatesPreferenceInput>

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryMethod: The preferred delivery methods such as shipping, local pickup or through pickup points.  The input must not contain more than `250` values.
		///     - pickupHandle: The pickup handle prefills checkout fields with the location for either local pickup or pickup points delivery methods. It accepts both location ID for local pickup and external IDs for pickup points.  The input must not contain more than `250` values.
		///     - coordinates: The coordinates of a delivery location in order of preference.
		///
		public static func create(deliveryMethod: Input<[PreferenceDeliveryMethodType]> = .undefined, pickupHandle: Input<[String]> = .undefined, coordinates: Input<CartDeliveryCoordinatesPreferenceInput> = .undefined) -> CartDeliveryPreferenceInput {
			return CartDeliveryPreferenceInput(deliveryMethod: deliveryMethod, pickupHandle: pickupHandle, coordinates: coordinates)
		}

		private init(deliveryMethod: Input<[PreferenceDeliveryMethodType]> = .undefined, pickupHandle: Input<[String]> = .undefined, coordinates: Input<CartDeliveryCoordinatesPreferenceInput> = .undefined) {
			self.deliveryMethod = deliveryMethod
			self.pickupHandle = pickupHandle
			self.coordinates = coordinates
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - deliveryMethod: The preferred delivery methods such as shipping, local pickup or through pickup points.  The input must not contain more than `250` values.
		///     - pickupHandle: The pickup handle prefills checkout fields with the location for either local pickup or pickup points delivery methods. It accepts both location ID for local pickup and external IDs for pickup points.  The input must not contain more than `250` values.
		///     - coordinates: The coordinates of a delivery location in order of preference.
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(deliveryMethod: [PreferenceDeliveryMethodType]? = nil, pickupHandle: [String]? = nil, coordinates: CartDeliveryCoordinatesPreferenceInput? = nil) {
			self.init(deliveryMethod: deliveryMethod.orUndefined, pickupHandle: pickupHandle.orUndefined, coordinates: coordinates.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch deliveryMethod {
				case .value(let deliveryMethod):
				guard let deliveryMethod = deliveryMethod else {
					fields.append("deliveryMethod:null")
					break
				}
				fields.append("deliveryMethod:[\(deliveryMethod.map { "\($0.rawValue)" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch pickupHandle {
				case .value(let pickupHandle):
				guard let pickupHandle = pickupHandle else {
					fields.append("pickupHandle:null")
					break
				}
				fields.append("pickupHandle:[\(pickupHandle.map { "\(GraphQL.quoteString(input: $0))" }.joined(separator: ","))]")
				case .undefined: break
			}

			switch coordinates {
				case .value(let coordinates):
				guard let coordinates = coordinates else {
					fields.append("coordinates:null")
					break
				}
				fields.append("coordinates:\(coordinates.serialize())")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
