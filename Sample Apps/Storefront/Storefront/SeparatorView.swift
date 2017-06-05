//
//  SeparatorView.swift
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

class SeparatorView: UIView {
    
    enum Position: Int {
        case top
        case left
        case bottom
        case right
    }
    
    @IBInspectable dynamic private var separatorPosition: Int = 0 {
        willSet(positionValue) {
            self.position = Position(rawValue: positionValue)!
        }
    }
    
    var position: Position = .top {
        didSet {
            guard let superview = self.superview else {
                return
            }
            
            self.updateFrameIn(superview)
            self.updateAutoresizeMask()
        }
    }
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(position: Position) {
        self.position = position
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // ----------------------------------
    //  MARK: - Superview -
    //
    override func willMove(toSuperview newSuperview: UIView?) {
        if let superview = newSuperview {
            self.updateFrameIn(superview)
            self.updateAutoresizeMask()
        }
    }
    
    // ----------------------------------
    //  MARK: - Updates -
    //
    private func updateFrameIn(_ superview: UIView) {
        
        let length = 1.0 / UIScreen.main.scale
        var frame  = superview.bounds
        
        switch self.position {
        case .top:
            frame.size.height = length
            frame.size.width  = superview.bounds.width
        case .bottom:
            frame.size.height = length
            frame.size.width  = superview.bounds.width
            frame.origin.y    = superview.bounds.height - length
        case .left:
            frame.size.height = superview.bounds.height
            frame.size.width  = length
            frame.origin.y    = superview.bounds.height - length
        case .right:
            frame.size.height = superview.bounds.height
            frame.size.width  = length
            frame.origin.x    = superview.bounds.width - length
        }
        
        self.frame = frame
    }
    
    private func updateAutoresizeMask() {
        switch self.position {
        case .top:
            self.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        case .left:
            self.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        case .bottom:
            self.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        case .right:
            self.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        }
    }
}
