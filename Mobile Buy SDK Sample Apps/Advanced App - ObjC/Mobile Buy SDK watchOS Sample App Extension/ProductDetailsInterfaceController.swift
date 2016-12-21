//
//  ProductDetailsInterfaceController.swift
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
import WatchKit

class ProductDetailsInterfaceController: WKInterfaceController {
    
    @IBOutlet var applePayButton: WKInterfacePaymentButton!
    @IBOutlet var productImage: WKInterfaceImage!
    @IBOutlet var productOptionLabel: WKInterfaceLabel!
    @IBOutlet var productPriceLabel: WKInterfaceLabel!
    @IBOutlet var topSeparator: WKInterfaceSeparator!
    @IBOutlet var variantPicker: WKInterfacePicker!
    
    var applePayHandler: ApplePayHandler!
    var pickerIndex: Int = 0
    var productItem: ProductItem!
    
    @IBAction func pickerAction(_ value: Int) {
        self.productPriceLabel.setText(self.productItem.variantPrice(index: value))
        self.pickerIndex = value
    }
    
    @IBAction func checkoutWithApplePay() {
        self.applePayHandler = ApplePayHandler(dataProvider: self.productItem.productsModel.dataProvider, interfaceController: self)
        self.applePayHandler.checkoutWithApplePay(variant: productItem.variant(atIndex: self.pickerIndex))
    }
    
    override func awake(withContext context: Any?) {
        if let product = context as? ProductItem {
            self.productItem = product
            self.productItem.configure(controller: self)
        }
    }
    
    override func willDisappear() {
        self.invalidateUserActivity()
    }
}
