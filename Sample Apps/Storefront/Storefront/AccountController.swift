//
//  AccountController.swift
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

/// This class provides insufficient security for
/// storing customer access token and is provided
/// for sample purposes only. All secure credentials
/// should be stored using Keychain.
///
class AccountController {
    
    static let shared = AccountController()
    
    private(set) var accessToken: String?
    
    private let defaults = UserDefaults.standard
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.loadToken()
    }
    
    // ----------------------------------
    //  MARK: - Management -
    //
    func save(accessToken: String) {
        self.accessToken = accessToken
        self.defaults.set(accessToken, forKey: Key.token)
        self.defaults.synchronize()
    }
    
    func deleteAccessToken() {
        self.accessToken = nil
        self.defaults.removeObject(forKey: Key.token)
        self.defaults.synchronize()
    }
    
    @discardableResult
    func loadToken() -> String? {
        self.accessToken = self.defaults.string(forKey: Key.token)
        return self.accessToken
    }
}

private extension AccountController {
    enum Key {
        static let token = "com.shopify.storefront.customerAccessToken"
    }
}
