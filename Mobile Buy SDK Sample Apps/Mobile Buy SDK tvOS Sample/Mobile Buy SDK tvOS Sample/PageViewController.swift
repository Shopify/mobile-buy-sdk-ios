//
//  PageViewController.swift
//  Mobile Buy SDK tvOS Sample App
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

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private let productImageViewControllerCache = NSCache<NSString, ProductImageViewController>()
    
    var productImages: [BUYImageLink] = []
    
    required init(product: ProductItem) {
        self.productImages = product.productImages
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let initialViewController = productImageViewController(forPage: 0)
        setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)
    }
    
    // MARK: UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = indexOfImageItem(forViewController: viewController)
        
        if index > 0 {
            return productImageViewController(forPage: index - 1)
        }
        else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = indexOfImageItem(forViewController: viewController)
        
        if index < productImages.count - 1 {
            return productImageViewController(forPage: index + 1)
        }
        else {
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return productImages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = pageViewController.viewControllers?.first else { fatalError("Unable to get the page controller's current view controller.") }
        
        return indexOfImageItem(forViewController: currentViewController)
    }
    
    // MARK: Convenience
    
    private func indexOfImageItem(forViewController viewController: UIViewController) -> Int {
        guard let viewController = viewController as? ProductImageViewController else { fatalError("Unexpected view controller type in page view controller.") }
        guard let viewControllerIndex = productImages.index(of: viewController.imageItem.imageLink) else { fatalError("View controller's image item not found.") }
        
        return viewControllerIndex
    }
    
    private func productImageViewController(forPage index: Int) -> ProductImageViewController {
        let image = productImages[index]
        
        if let cachedController = productImageViewControllerCache.object(forKey: image.identifier.stringValue as NSString) {
            return cachedController
        } else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(withIdentifier: ProductImageViewController.identifier) as? ProductImageViewController
                else { fatalError("Unable to instantiate a ProductImageViewController.") }
            controller.loadView()
            controller.configure(imageItem: ImageItem(image: image))
            controller.productImageView.load(image, animateChange: true, completion: nil)
            
            self.productImageViewControllerCache.setObject(controller, forKey: image.identifier.stringValue as NSString)

            return controller
        }
    }
}
