//
//  String+HTML.swift
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

extension String {
    
    func interpretAsHTML(font: String, size: CGFloat) -> NSAttributedString? {
        
        var style = ""
        style += "<style>* { "
        style += "font-family: \"\(font)\" !important;"
        style += "font-size: \(size) !important;"
        style += "}</style>"
        
        let styledHTML = self.trimmingCharacters(in: CharacterSet.newlines).appending(style)
        let htmlData   = styledHTML.data(using: .utf8)!
        
        let options: [String: Any] = [
            NSDocumentTypeDocumentAttribute      : NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute : String.Encoding.utf8.rawValue,
        ]
        
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
}
