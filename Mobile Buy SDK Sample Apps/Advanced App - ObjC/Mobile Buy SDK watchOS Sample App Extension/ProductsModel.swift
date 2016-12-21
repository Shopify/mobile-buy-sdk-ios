//
//  ProductsModel.swift
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

class ProductsModel: BaseModel {
    
    fileprivate var products: [BUYProduct?] = []
    var dataProvider: DataProvider!
    
    var numberOfProducts: Int {
        return self.products.count
    }
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func getProduct(index: Int) -> BUYProduct {
        return self.products[index]!
    }
    
    func getProducts (completion: @escaping () -> Void) {
        let operation = self.dataProvider.getProducts() { (products) in
            self.products = products
            completion()
        }
        self.setCurrentOperation(operation: operation)
    }
    
    func configure(row: ProductRowController, index: Int) {
        let product = products[index]
        let priceString = self.dataProvider.getCurrencyFormatter().string(from: (product?.minimumPrice)!)!
        if let image = product?.imagesArray().first {
            let session = URLSession.shared.dataTask(with: image.imageURL(with: .size480x480), completionHandler: { (data, urlResponse, error) in
                row.productImage.setImageData(data)
            })
            session.resume()
        } else {
            row.productImage.setImage(UIImage.init(named: "temp"))
        }

        row.configure(price: priceString, title: (product?.title)!)
    }
    
    func configure(interfaceController: ProductDetailsInterfaceController, index: Int) {
        let product = products[index]
        interfaceController.setTitle(product?.title)
        if let image = product?.imagesArray().first {
            let session = URLSession.shared.dataTask(with: image.imageURL(with: .size480x480), completionHandler: { (data, urlResponse, error) in
                interfaceController.productImage.setImageData(data)
            })
            session.resume()
        } else {
            interfaceController.productImage.setImage(UIImage.init(named: "temp"))
        }
        interfaceController.updateUserActivity(Constants.handoffActivityType, userInfo: ["product": product?.identifier as Any], webpageURL: nil)
    }
}
