//
//  ProductItem.swift
//  Mobile Buy SDK Advanced Sample
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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
import Buy
import WatchKit

class ProductItem {
    
    var index: Int = 0
    var product: BUYProduct!
    var productsModel: ProductsModel!
    var variants: [BUYProductVariant?] = []
    
    init(index: Int, product:BUYProduct, productsModel: ProductsModel) {
        self.index = index
        self.productsModel = productsModel
        self.product = product
    }
    
    func configure(controller: ProductDetailsInterfaceController) {
        self.productsModel.configure(interfaceController: controller, index: self.index)
        self.configure(picker: controller.variantPicker)
    }
    
    func configure(picker:WKInterfacePicker) {
        if self.product.optionsArray().count > 1 {
            picker.setHidden(true)
        } else {
            self.variants = self.product.variantsArray()
            let caption = self.product.optionsArray().first?.name
            var pickerItems: [WKPickerItem] = []
            for index in 0..<variants.count {
                let pickerItem = WKPickerItem()
                pickerItem.title = self.variants[index]?.title
                pickerItem.caption = caption
                pickerItems.append(pickerItem)
            }
            picker.setItems(pickerItems)
        }
    }
}
