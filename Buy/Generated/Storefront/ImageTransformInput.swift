//
//  ImageTransformInput.swift
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
	/// The available options for transforming an image. All transformation options 
	/// are considered best effort. Any transformation that the original image type 
	/// doesn't support will be ignored. 
	open class ImageTransformInput {
		/// The region of the image to remain after cropping. Must be used in 
		/// conjunction with the `maxWidth` and/or `maxHeight` fields, where the 
		/// `maxWidth` and `maxHeight` aren't equal. The `crop` argument should 
		/// coincide with the smaller value. A smaller `maxWidth` indicates a `LEFT` or 
		/// `RIGHT` crop, while a smaller `maxHeight` indicates a `TOP` or `BOTTOM` 
		/// crop. For example, `{ maxWidth: 5, maxHeight: 10, crop: LEFT }` will result 
		/// in an image with a width of 5 and height of 10, where the right side of the 
		/// image is removed. 
		open var crop: Input<CropRegion>

		/// Image width in pixels between 1 and 5760. 
		open var maxWidth: Input<Int32>

		/// Image height in pixels between 1 and 5760. 
		open var maxHeight: Input<Int32>

		/// Image size multiplier for high-resolution retina displays. Must be within 
		/// 1..3. 
		open var scale: Input<Int32>

		/// Convert the source image into the preferred content type. Supported 
		/// conversions: `.svg` to `.png`, any file type to `.jpg`, and any file type 
		/// to `.webp`. 
		open var preferredContentType: Input<ImageContentType>

		/// Creates the input object.
		///
		/// - parameters:
		///     - crop: The region of the image to remain after cropping. Must be used in conjunction with the `maxWidth` and/or `maxHeight` fields, where the `maxWidth` and `maxHeight` aren't equal. The `crop` argument should coincide with the smaller value. A smaller `maxWidth` indicates a `LEFT` or `RIGHT` crop, while a smaller `maxHeight` indicates a `TOP` or `BOTTOM` crop. For example, `{ maxWidth: 5, maxHeight: 10, crop: LEFT }` will result in an image with a width of 5 and height of 10, where the right side of the image is removed. 
		///     - maxWidth: Image width in pixels between 1 and 5760. 
		///     - maxHeight: Image height in pixels between 1 and 5760. 
		///     - scale: Image size multiplier for high-resolution retina displays. Must be within 1..3. 
		///     - preferredContentType: Convert the source image into the preferred content type. Supported conversions: `.svg` to `.png`, any file type to `.jpg`, and any file type to `.webp`. 
		///
		public static func create(crop: Input<CropRegion> = .undefined, maxWidth: Input<Int32> = .undefined, maxHeight: Input<Int32> = .undefined, scale: Input<Int32> = .undefined, preferredContentType: Input<ImageContentType> = .undefined) -> ImageTransformInput {
			return ImageTransformInput(crop: crop, maxWidth: maxWidth, maxHeight: maxHeight, scale: scale, preferredContentType: preferredContentType)
		}

		private init(crop: Input<CropRegion> = .undefined, maxWidth: Input<Int32> = .undefined, maxHeight: Input<Int32> = .undefined, scale: Input<Int32> = .undefined, preferredContentType: Input<ImageContentType> = .undefined) {
			self.crop = crop
			self.maxWidth = maxWidth
			self.maxHeight = maxHeight
			self.scale = scale
			self.preferredContentType = preferredContentType
		}

		/// Creates the input object.
		///
		/// - parameters:
		///     - crop: The region of the image to remain after cropping. Must be used in conjunction with the `maxWidth` and/or `maxHeight` fields, where the `maxWidth` and `maxHeight` aren't equal. The `crop` argument should coincide with the smaller value. A smaller `maxWidth` indicates a `LEFT` or `RIGHT` crop, while a smaller `maxHeight` indicates a `TOP` or `BOTTOM` crop. For example, `{ maxWidth: 5, maxHeight: 10, crop: LEFT }` will result in an image with a width of 5 and height of 10, where the right side of the image is removed. 
		///     - maxWidth: Image width in pixels between 1 and 5760. 
		///     - maxHeight: Image height in pixels between 1 and 5760. 
		///     - scale: Image size multiplier for high-resolution retina displays. Must be within 1..3. 
		///     - preferredContentType: Convert the source image into the preferred content type. Supported conversions: `.svg` to `.png`, any file type to `.jpg`, and any file type to `.webp`. 
		///
		@available(*, deprecated, message: "Use the static create() method instead.")
		public convenience init(crop: CropRegion? = nil, maxWidth: Int32? = nil, maxHeight: Int32? = nil, scale: Int32? = nil, preferredContentType: ImageContentType? = nil) {
			self.init(crop: crop.orUndefined, maxWidth: maxWidth.orUndefined, maxHeight: maxHeight.orUndefined, scale: scale.orUndefined, preferredContentType: preferredContentType.orUndefined)
		}

		internal func serialize() -> String {
			var fields: [String] = []

			switch crop {
				case .value(let crop): 
				guard let crop = crop else {
					fields.append("crop:null")
					break
				}
				fields.append("crop:\(crop.rawValue)")
				case .undefined: break
			}

			switch maxWidth {
				case .value(let maxWidth): 
				guard let maxWidth = maxWidth else {
					fields.append("maxWidth:null")
					break
				}
				fields.append("maxWidth:\(maxWidth)")
				case .undefined: break
			}

			switch maxHeight {
				case .value(let maxHeight): 
				guard let maxHeight = maxHeight else {
					fields.append("maxHeight:null")
					break
				}
				fields.append("maxHeight:\(maxHeight)")
				case .undefined: break
			}

			switch scale {
				case .value(let scale): 
				guard let scale = scale else {
					fields.append("scale:null")
					break
				}
				fields.append("scale:\(scale)")
				case .undefined: break
			}

			switch preferredContentType {
				case .value(let preferredContentType): 
				guard let preferredContentType = preferredContentType else {
					fields.append("preferredContentType:null")
					break
				}
				fields.append("preferredContentType:\(preferredContentType.rawValue)")
				case .undefined: break
			}

			return "{\(fields.joined(separator: ","))}"
		}
	}
}
