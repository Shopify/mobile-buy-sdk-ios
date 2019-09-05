//
//  CustomerCoordinator.swift
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

class CustomerCoordinator: UIViewController {
    
    private let hostController = UINavigationController(navigationBarClass: UINavigationBar.self, toolbarClass: UIToolbar.self)
    
    // ----------------------------------
    //  MARK: - View -
    //
    override func loadView() {
        super.loadView()
        
        self.addChild(self.hostController)
        self.view.addSubview(self.hostController.view)
        self.hostController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.hostController.view.frame = self.view.bounds
        self.hostController.didMove(toParent: self)
        
        if let _ = AccountController.shared.accessToken {
            self.showOrders(animated: false)
        } else {
            self.showLogin(animated: false)
        }
    }
    
    private func showOrders(animated: Bool) {
        let customerController: CustomerViewController = self.storyboard!.instantiateViewController()
        customerController.delegate = self
        self.hostController.setViewControllers([customerController], animated: animated)
    }
    
    private func showLogin(animated: Bool) {
        let loginController: LoginViewController = self.storyboard!.instantiateViewController()
        loginController.delegate = self
        self.hostController.setViewControllers([loginController], animated: animated)
    }
}

// ----------------------------------
//  MARK: - CustomerControllerDelegate -
//
extension CustomerCoordinator: CustomerControllerDelegate {
    func customerControllerDidCancel(_ customerController: CustomerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func customerControllerDidLogout(_ customerController: CustomerViewController) {
        guard let accessToken = AccountController.shared.accessToken else {
            return
        }
        
        Client.shared.logout(accessToken: accessToken) { success in
            if success {
                AccountController.shared.deleteAccessToken()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// ----------------------------------
//  MARK: - LoginControllerDelegate -
//
extension CustomerCoordinator: LoginControllerDelegate {
    
    func loginControllerDidCancel(_ loginController: LoginViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginController(_ loginController: LoginViewController, didLoginWith email: String, passowrd: String) {
        Client.shared.login(email: email, password: passowrd) { accessToken in
            if let accessToken = accessToken {
                AccountController.shared.save(accessToken: accessToken)
                self.showOrders(animated: true)
            } else {
                let alert = UIAlertController(title: "Login Error", message: "Failed to login a customer with this email and password. Please check your credentials and try again.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
