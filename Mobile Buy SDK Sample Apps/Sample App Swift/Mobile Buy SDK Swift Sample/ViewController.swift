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

    let shopDomain = ""
    let apiKey = ""
    let channelId = ""
    let productId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let client = BUYClient(shopDomain: shopDomain, apiKey: apiKey, channelId: channelId)
        
        client.getProductById(productId) { (product, error) -> Void in
            self.titleLabel.text = product.title
            
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
}

