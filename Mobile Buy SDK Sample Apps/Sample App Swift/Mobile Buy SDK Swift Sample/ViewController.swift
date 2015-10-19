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

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    let shopDomain = ""
    let apiKey = ""
    let channelId = ""
    let productId = ""
    
    var productVariant: BUYProductVariant?
    let client: BUYClient
    
    required init(coder aDecoder: NSCoder) {
        
        
        client = BUYClient(shopDomain: shopDomain, apiKey: apiKey, channelId: channelId)
        super.init(coder: aDecoder)!

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        client.getProductById(productId) { (product, error) -> Void in
            self.titleLabel.text = product.title
            
            if let variants = product.variants as? [BUYProductVariant] {
                self.productVariant = variants.first
            }
            
            if (product != nil && error == nil) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    let images = product.images as NSArray
                    let buyImage = images.firstObject as! BUYImage
                    let url = NSURL(string: buyImage.src!)
                    
                    let data = NSData(contentsOfURL: url!)
                    let image = UIImage(data: data!)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.imageView.image = image
                    }
                }
            }
        }
    }
    
    @IBAction func didTapCheckout(sender: UIButton) {
        
        // Create the checkout
        let cart = BUYCart()
        cart.addVariant(productVariant!)
        
        let checkout = BUYCheckout(cart: cart)
        client.createCheckout(checkout) { (checkout, error) -> Void in
            
            let checkoutURL = checkout.webCheckoutURL
            
            if (UIApplication.sharedApplication().canOpenURL(checkoutURL)) {
                UIApplication.sharedApplication().openURL(checkoutURL)
            }
            
        }
        
    }
}

