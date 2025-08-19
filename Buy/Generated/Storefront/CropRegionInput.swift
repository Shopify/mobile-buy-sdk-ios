//
//  CropRegionInput.swift
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
	/// The input fields for defining an arbitrary cropping region. 
	open class CropRegionInput {
		/// Left position of the region of the image to extract when using the region 
		/// crop mode. 
		open var `left`: Int32

		/// Top position of the region of the image to extract when using the region 
		/// crop mode. 
		open var top: Int32

		/// Width of the region of the image to extract when using the region crop 
		/// mode. 
		open var width: Int32

		/// Height of the region of the image to extract when using the region crop 
		/// mode. 
		open var height: Int32

		/// Creates the input object.
		///
		/// - parameters:
		///     - left: Left position of the region of the image to extract when using the region crop mode.
		///     - top: Top position of the region of the image to extract when using the region crop mode.
		///     - width: Width of the region of the image to extract when using the region crop mode.
		///     - height: Height of the region of the image to extract when using the region crop mode.
		///
		public static func create(`left`: Int32, top: Int32, width: Int32, height: Int32) -> CropRegionInput {
			return CropRegionInput(left: left, top: top, width: width, height: height)
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - left: Left position of the region of the image to extract when using the region crop mode.
		///     - top: Top position of the region of the image to extract when using the region crop mode.
		///     - width: Width of the region of the image to extract when using the region crop mode.
		///     - height: Height of the region of the image to extract when using the region crop mode.
		///
		public init(`left`: Int32, top: Int32, width: Int32, height: Int32) {
			self.`left` = `left`
			self.top = top
			self.width = width
			self.height = height
		}

		internal func serialize() -> String {
			var fields: [String] = []

			fields.append("left:\(left)")

			fields.append("top:\(top)")

			fields.append("width:\(width)")

			fields.append("height:\(height)")

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
