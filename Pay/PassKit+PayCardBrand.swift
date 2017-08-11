//
//  PassKit+PayCardBrand.swift
//  Pay
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

import PassKit

extension PKPaymentNetwork {
    
    init?(_ cardBrand: PayCardBrand) {
        if #available(iOS 10.1, *) {
            switch cardBrand {
            case .visa:            self = .visa
            case .masterCard:      self = .masterCard
            case .discover:        self = .discover
            case .americanExpress: self = .amex
            case .jcb:             self = .JCB
            default:
                return nil
            }
        } else {
            switch cardBrand {
            case .visa:            self = .visa
            case .masterCard:      self = .masterCard
            case .discover:        self = .discover
            case .americanExpress: self = .amex
            case .jcb:
                Log("WARNING: Attempting to convert PayCardBrand.jcb to PKPaymentNetwork on iOS 10.0 or lower. PKPaymentNetwork.JCB requires iOS 10.1 or higher.")
                fallthrough
            default:
                return nil
            }
        }
    }
}

extension Array where Element == PayCardBrand {
    
    var paymentNetworks: [PKPaymentNetwork] {
        return self.flatMap {
            PKPaymentNetwork($0)
        }
    }
}
