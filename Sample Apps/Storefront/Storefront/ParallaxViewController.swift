//
//  ParallaxViewController.swift
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

class ParallaxViewController: UIViewController {
    
    enum Layout {
        case headerBelow
        case headerAbove
    }
    
    @IBInspectable var insets:       UIEdgeInsets = .zero { didSet { self.view.setNeedsLayout() } }
    @IBInspectable var headerHeight: CGFloat      = 200.0 { didSet { self.view.setNeedsLayout() } }
    @IBInspectable var multiplier:   CGFloat      = 0.5   { didSet { self.view.setNeedsLayout() } }

    @IBOutlet private weak var headerView: UIView! {
        willSet {
            self.proxyView.headerView = newValue
            if self.isViewLoaded {
                self.view.setNeedsLayout()
            }
        }
    }
    
    @IBOutlet private weak var scrollView: UIScrollView! {
        willSet {
            self.proxyView.scrollView = newValue
            if self.isViewLoaded {
                self.view.setNeedsLayout()
            }
        }
    }
    
    private var proxyView = ProxyView(frame: .zero)
    
    private var topY: CGFloat {
        return max(self.insets.top, self.topLayoutGuide.length)
    }
    
    private var midY: CGFloat {
        return self.topY + self.headerHeight
    }
    
    private var bottomSpace: CGFloat {
        return self.bottomLayoutGuide.length
    }
    
    var layout: Layout = .headerBelow {
        didSet {
            if self.isViewLoaded {
                self.view.setNeedsLayout()
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureProxyView()
        self.configureScrollView()
    }
    
    private func configureProxyView() {
        self.proxyView.headerView = headerView
        self.proxyView.scrollView = scrollView
    }
    
    private func configureScrollView() {
        self.scrollView.backgroundColor = .clear
    }
    
    // ----------------------------------
    //  MARK: - Updates -
    //
    func updateParallax() {
        
        let headerOffset = self.scrollView.contentOffset.y + self.midY
        let headerY      = min(self.topY - (headerOffset * self.multiplier), self.topY)
        let headerHeight = max(self.headerHeight, self.headerHeight - headerOffset)
        
        var frame             = self.headerView.frame
        frame.origin.y        = headerY
        frame.size.height     = headerHeight
        self.headerView.frame = frame
    }
    
    // ----------------------------------
    //  MARK: - Layout Subviews -
    //
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.layoutProxyView()
        self.layoutHeaderView()
        self.layoutScrollView()
        
        self.adjustZIndex()
        self.updateParallax()
    }
    
    private func layoutProxyView() {
        self.proxyView.frame = self.view.bounds
    }
    
    private func layoutHeaderView() {
        var frame             = self.view.bounds
        frame.origin.y        = self.topY
        frame.size.height     = self.headerHeight
        self.headerView.frame = frame
    }
    
    private func layoutScrollView() {
        self.scrollView.frame = self.view.bounds
        
        /* -----------------------------------
         ** In order to ensure that the scroll
         ** doesn't appear half-scroller, we
         ** have set the content size to zero 
         ** before setting `contentInset`. We
         ** then restore the previoiusly set
         ** content size.
         */
        let contentSize = self.scrollView.contentSize
        self.scrollView.contentSize  = .zero
        
        var insets                   = self.scrollView.contentInset
        insets.top                   = self.midY
        insets.bottom                = self.bottomSpace
        self.scrollView.contentInset = insets
        self.scrollView.scrollIndicatorInsets = insets
        
        self.scrollView.contentSize  = contentSize
    }
    
    private func adjustZIndex() {
        
        switch self.layout {
        case .headerBelow:
            self.view.insertSubview(self.headerView, at: 0)
            self.view.insertSubview(self.scrollView, at: 1)
        case .headerAbove:
            self.view.insertSubview(self.scrollView, at: 0)
            self.view.insertSubview(self.headerView, at: 1)
        }
        self.view.insertSubview(self.proxyView, at: 2)
    }
}

// ----------------------------------
//  MARK: - ProxyView -
//
private class ProxyView: UIView {
    
    weak var headerView: UIView?
    weak var scrollView: UIScrollView?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if let scrollView = self.scrollView,
            let headerView = self.headerView {
            
            /* ---------------------------------
             ** Test if the point is contained
             ** by the scroll view first.
             */
            let scrollViewPoint = scrollView.convert(point, from: self)
            if scrollView.point(inside: scrollViewPoint, with: event) {
                
                /* -----------------------------------
                 ** Ensure that the point doesn't fall
                 ** into scroll view's inset space at
                 ** the top.
                 */
                if scrollViewPoint.y > 0.0 {
                    return scrollView.hitTest(scrollViewPoint, with: event)
                }
            }
            
            /* ------------------------------------
             ** Then test if the point is contained
             ** by the header view.
             */
            let headerPoint = headerView.convert(point, from: self)
            if headerView.point(inside: headerPoint, with: event) {
                return headerView.hitTest(headerPoint, with: event)
            }
            
        } else {
            print("ParallaxViewController must have a non-nill headerView and scrollView assigned to it.")
        }
        
        return self.superview?.hitTest(point, with: event)
    }
}
