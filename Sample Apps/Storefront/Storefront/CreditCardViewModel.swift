//
//  CreditCardViewModel.swift
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

import Foundation
import Buy

final class CreditCardViewModel: ViewModel {
    
    typealias ModelType = Storefront.CreditCard
    
    let model:  ModelType
    
    let firstName:    String?
    let lastName:     String?
    
    let firstDigits:  String?
    let lastDigits:   String?
    let maskedDigits: String?
    
    let expMonth:     Int?
    let expYear:      Int?
    let brand:        String?
    
    // ----------------------------------
    //  MARK: - Init -
    //
    required init(from model: ModelType) {
        self.model        = model
        
        self.firstName    = model.firstName
        self.lastName     = model.lastName
        
        self.firstDigits  = model.firstDigits
        self.lastDigits   = model.lastDigits
        self.maskedDigits = model.maskedNumber
        
        self.expMonth     = model.expiryMonth == nil ? nil : Int(model.expiryMonth!)
        self.expYear      = model.expiryYear  == nil ? nil : Int(model.expiryYear!)
        self.brand        = model.brand
    }
}

extension Storefront.CreditCard: ViewModeling {
    typealias ViewModelType = CreditCardViewModel
}
