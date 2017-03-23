//
//  SubtitleButton.swift
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

class SubtitleButton: RoundedButton {
    
    @IBInspectable var subtitle: String = ""
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        
        guard let title = title else {
            super.setTitle(nil, for: state)
            return
        }
        
        let currentFont  = self.titleLabel!.font!
        let currentColor = self.titleColor(for: state) ?? .white
        
        let style           = NSMutableParagraphStyle()
        style.alignment     = .center
        style.lineBreakMode = .byClipping
        
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [
            NSFontAttributeName           : currentFont,
            NSParagraphStyleAttributeName : style,
            NSForegroundColorAttributeName: currentColor
            ])
        
        let attributedSubtitle = NSAttributedString(string: "\n\(self.subtitle)", attributes: [
            NSFontAttributeName           : UIFont(descriptor: currentFont.fontDescriptor, size: currentFont.pointSize * 0.6),
            NSParagraphStyleAttributeName : style,
            NSForegroundColorAttributeName: currentColor.withAlphaComponent(0.6)
            ])
        
        attributedTitle.append(attributedSubtitle)
        
        self.titleLabel?.numberOfLines = 0
        
        super.setAttributedTitle(attributedTitle, for: state)
    }
}
