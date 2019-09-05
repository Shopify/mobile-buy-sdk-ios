//
//  LoginViewController.swift
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

protocol LoginControllerDelegate: class {
    func loginControllerDidCancel(_ loginController: LoginViewController)
    func loginController(_ loginController: LoginViewController, didLoginWith email: String, passowrd: String)
}

class LoginViewController: UIViewController {
    
    weak var delegate: LoginControllerDelegate?
    
    @IBOutlet private weak var loginButton:   UIButton!
    @IBOutlet private weak var usernameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    
    private var email: String {
        return self.usernameField.text ?? ""
    }
    
    private var password: String {
        return self.passwordField.text ?? ""
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateLoginState()
    }
    
    // ----------------------------------
    //  MARK: - Updates -
    //
    private func updateLoginState() {
        let isValid = !self.email.isEmpty && !self.password.isEmpty
        
        self.loginButton.isEnabled = isValid
        self.loginButton.alpha     = isValid ? 1.0 : 0.5
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension LoginViewController {
 
    @IBAction private func textFieldValueDidChange(textField: UITextField) {
        self.updateLoginState()
    }
    
    @IBAction private func loginAction(_ sender: UIButton) {
        self.delegate?.loginController(self, didLoginWith: self.email, passowrd: self.password)
    }
    
    @IBAction private func cancelAction(_ sender: UIButton) {
        self.delegate?.loginControllerDidCancel(self)
    }
}
