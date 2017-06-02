//
//  UIImageView+Remote.swift
//  Storefront
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
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
        
        /* ---------------------------------
         ** If the url is provided, kick off
         ** the image request and update the
         ** current data task.
         */
        if let url = url {
            
            if let cachedImage = ImageCache.shared.imageFor(url) {
                self.image = cachedImage
            } else {
                self.image = placeholder
            }
            
            self.currentTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data, let image = UIImage(data: data) {
                    
                    ImageCache.shared.set(image, for: url)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
            self.currentTask?.resume()
            
        } else {
            self.image       = placeholder
            self.currentTask = nil
        }
    }
}

// ----------------------------------
//  MARK: - Image Cache -
//
private class ImageCache: NSCache<NSString, UIImage> {
    
    static let shared = ImageCache()
    
    func set(_ image: UIImage, for url: URL) {
        self.setObject(image, forKey: url.absoluteString as NSString)
    }
    
    func imageFor(_ url: URL?) -> UIImage? {
        guard let url = url else {
            return nil
        }
        return self.object(forKey: url.absoluteString as NSString)
    }
}
