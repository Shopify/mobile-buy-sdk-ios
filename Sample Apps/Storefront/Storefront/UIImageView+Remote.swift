//
//  UIImageView+Remote.swift
//  Storefront
//
//  Created by Dima Bart on 2017-02-24.
//  Copyright © 2017 Shopify Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    
    typealias Completion = () -> Void
    
    private struct Key {
        static var image = "com.storefront.image.key"
    }
    
    private var currentTask: URLSessionDataTask? {
        get {
            return objc_getAssociatedObject(self, &Key.image) as? URLSessionDataTask
        }
        set {
            objc_setAssociatedObject(self, &Key.image, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setImageFrom(_ url: URL?, placeholder: UIImage? = nil, completion: Completion? = nil) {
        
        self.currentTask?.cancel()
        self.image = nil
        
        /* -----------------------------------
         ** Set the placeholder image if one
         ** was provided.
         */
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        /* ---------------------------------
         ** If the url is provided, kick off
         ** the image request and update the
         ** current data task.
         */
        if let url = url {
            
            self.currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            self.currentTask?.resume()
            
        } else {
            self.image       = nil
            self.currentTask = nil
        }
    }
}
