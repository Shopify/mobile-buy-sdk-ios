//
//  ViewController.swift
//  Mobile Buy SDK Swift Sample
//
//  Created by David Muzi on 2015-07-10.
//  Copyright (c) 2015 Shopify. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!

    let shopDomain = "davidmuzi.myshopify.com"
    let apiKey = "ad30d5343ef86e2b4babef12f1d90d13"
    let channelId = "237698"
    let productId = "470952706"
    
    var productVariant: BUYProductVariant?
    let client: BUYClient
    
    required init(coder aDecoder: NSCoder) {
        
        
        client = BUYClient(shopDomain: shopDomain, apiKey: apiKey, channelId: channelId)
        super.init(coder: aDecoder)

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
        
        var checkout = BUYCheckout(cart: cart)
        client.createCheckout(checkout) { (checkout, error) -> Void in
            
            let checkoutURL = checkout.webCheckoutURL
            
            if (UIApplication.sharedApplication().canOpenURL(checkoutURL)) {
                UIApplication.sharedApplication().openURL(checkoutURL)
            }
            
        }
        
    }
}

