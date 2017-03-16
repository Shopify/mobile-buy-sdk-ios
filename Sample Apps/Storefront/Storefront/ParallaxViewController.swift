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
    
    @IBInspectable var insets:       UIEdgeInsets = .zero
    @IBInspectable var headerHeight: CGFloat      = 200.0
    @IBInspectable var multiplier:   CGFloat      = 0.5

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    lazy private var proxyView: ProxyView = {
        let view = ProxyView(frame: self.view.bounds)
        self.view.addSubview(view)
        return view
    }()
    
    private var minY: CGFloat {
        return max(self.insets.top, self.topLayoutGuide.length)
    }
    
    private var midY: CGFloat {
        return self.minY + self.headerHeight
    }
    
    private var maxY: CGFloat {
        return self.bottomLayoutGuide.length
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
        let headerY      = min(self.minY - (headerOffset * self.multiplier), self.minY)
        let headerHeight = max(self.headerHeight, self.headerHeight + (headerOffset * -1.0))
        
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
    }
    
    private func layoutProxyView() {
        self.proxyView.frame = self.view.bounds
    }
    
    private func layoutHeaderView() {
        var frame             = self.view.bounds
        frame.origin.y        = self.minY
        frame.size.height     = self.headerHeight
        self.headerView.frame = frame
    }
    
    private func layoutScrollView() {
        self.scrollView.frame = self.view.bounds
        
        var insets                   = self.scrollView.contentInset
        insets.top                   = self.midY
        insets.bottom                = self.maxY
        self.scrollView.contentInset = insets
    }
    
    private func adjustZIndex() {
        self.view.insertSubview(self.scrollView, aboveSubview: self.headerView)
        self.view.insertSubview(self.proxyView,  aboveSubview: self.scrollView)
    }
    
    // ----------------------------------
    //  MARK: - Verification -
    //
    private func isChild(_ view: UIView) -> Bool {
        for subview in self.view.subviews {
            if subview === view {
                return true
            }
        }
        return false
    }
}

// ----------------------------------
//  MARK: - ProxyView -
//
private class ProxyView: UIView {
    
    weak var headerView: UIView!
    weak var scrollView: UIScrollView!
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let headerPoint = self.headerView.convert(point, from: self)
        if self.headerView.bounds.contains(headerPoint) {
            return self.headerView
        }
        
        let scrollViewPoint = self.scrollView.convert(point, from: self)
        if self.scrollView.bounds.contains(scrollViewPoint) {
            return self.scrollView
        }
        
        return self.superview
    }
}
