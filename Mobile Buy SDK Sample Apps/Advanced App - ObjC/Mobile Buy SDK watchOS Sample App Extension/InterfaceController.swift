//
//  InterfaceController.swift
//  Mobile Buy SDK watchOS Sample App Extension
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

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    /* ---------------------------------
     ** Configure store credentials to
     ** use with your specific store.
     */
    let shopDomain: String = ""
    let apiKey:     String = ""
    let appID:      String = ""
    
    @IBOutlet var loadingLabel: WKInterfaceLabel!
    @IBOutlet var productsTable: WKInterfaceTable!
    var dataProvider: DataProvider!
    var productsModel: ProductsModel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        self.dataProvider = DataProvider(shopDomain: self.shopDomain, apiKey: self.apiKey, appId: self.appID)
        self.productsModel = ProductsModel(dataProvider: self.dataProvider)
        self.productsModel.getProducts {
            self.productsTable.setNumberOfRows(self.productsModel.numberOfProducts, withRowType: "ProductRow")
            self.loadingLabel.setHidden(true)
            for index in 0..<self.productsModel.numberOfProducts {
                if let controller = self.productsTable.rowController(at: index) as? ProductRowController {
                    self.productsModel.configure(row: controller, index: index)
                }
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let product = ProductItem(index: rowIndex, productsModel: self.productsModel)
        self.pushController(withName: "ProductDetailsInterfaceController", context: product)
    }

}
