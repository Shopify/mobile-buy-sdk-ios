//
//  ViewController.swift
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

import UIKit
import Buy

class ViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    
    var productVariant: BUYProductVariant?
    let client: BUYClient
    
    required init(coder aDecoder: NSCoder) {
        
        client = BUYClient(shopDomain: Config.shopDomain, apiKey: Config.apiKey, appId: Config.appId)
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client.getProductById(Config.productId) { (product, error) in
            
            guard let product = product else { return }
            
            self.titleLabel.text = product.title
            self.productVariant = product.variantsArray().first
            
            guard let buyImage = product.images?.firstObject as? BUYImageLink else { return }

            NSURLSession.sharedSession().dataTaskWithURL(buyImage.sourceURL) { (data, response, error) in
                
                guard let data = data else { return }
                
                dispatch_async(dispatch_get_main_queue()) {
                    let image = UIImage(data: data)
                    self.imageView.image = image
                }
            }.resume()
        }
    }
    
    @IBAction func didTapCheckout(sender: UIButton) {
        
        // Create the checkout
        let cart = client.modelManager.buy_objectWithEntityName(BUYCart.entityName(), JSONDictionary: nil) as! BUYCart
        cart.addVariant(productVariant!)
        
        let checkout = client.modelManager.checkoutWithCart(cart)
        
        client.createCheckout(checkout) { (checkout, error) -> Void in
            
            if let checkoutURL = checkout?.webCheckoutURL {
                if (UIApplication.sharedApplication().canOpenURL(checkoutURL)) {
                    UIApplication.sharedApplication().openURL(checkoutURL)
                }
            }
        }
    }
}

