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
    
    private var index: Int = 0
    private var product: BUYProduct!
    private var variants: [BUYProductVariant?] = []
    
    var productsModel: ProductsModel!
    
    init(index: Int, product: BUYProduct, productsModel: ProductsModel) {
        self.index = index
        self.productsModel = productsModel
        self.product = product
    }
    
    /// Returns the variant price given the index of the variant picker
    ///
    /// - Parameter index: index of the variant picker
    /// - Returns: the String representation of the price of the variant using the currency formatter
    func variantPrice(index: Int) -> String {
        return self.price(variant: self.variants[index])
    }
    
    /// Returns the BUYProductVariant given the index of the variant picker
    ///
    /// - Parameter atIndex: index of the variant picker
    /// - Returns: the `BUYProductVariant`
    func variant(atIndex: Int) -> BUYProductVariant {
        return self.variants[atIndex]!
    }
    
    /// Configures the `ProductDetailsInterfaceController`
    ///
    /// - Parameter controller: the `ProductDetailsInterfaceController` that needs configuration
    func configure(controller: ProductDetailsInterfaceController) {
        self.productsModel.configure(interfaceController: controller, index: self.index)

        if self.product.optionsArray().count > 1 {
            controller.applePayButton.setHidden(true)
            controller.variantPicker.setHidden(true)
            controller.topSeparator.setHidden(true)
        } else {
            self.variants = self.product.variantsArray()
            let caption = String(format: "%@:", (self.product.optionsArray().first?.name)!)
            controller.productOptionLabel.setText(caption)
            controller.productPriceLabel.setText(self.price(variant: self.variants[0]))
            self.configure(picker: controller.variantPicker, variants: self.variants)
        }

    }
    
    /// Configures the `WKInterfacePicker`
    ///
    /// - Parameters:
    ///   - picker: the `WKInterfacePicker` that needs configuration
    ///   - variants: the variants that need to be added to the picker
    private func configure(picker: WKInterfacePicker, variants: [BUYProductVariant?]) {
        var pickerItems: [WKPickerItem] = []
        for index in 0..<variants.count {
            let pickerItem = WKPickerItem()
            pickerItem.title = self.variants[index]?.title
            pickerItems.append(pickerItem)
        }
        picker.setItems(pickerItems)
    }
    
    /// Returns the String representation of the price of the given variant
    ///
    /// - Parameter variant: the `BUYProductVariant`
    /// - Returns: the String representation of the price using the currency formatter
    private func price(variant: BUYProductVariant?) -> String {
        return self.productsModel.dataProvider.getCurrencyFormatter().string(from: (variant!.price)!)!
    }
}
