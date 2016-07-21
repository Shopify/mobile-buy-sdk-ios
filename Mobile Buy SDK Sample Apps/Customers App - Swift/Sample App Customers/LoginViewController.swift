//
//  LoginViewController.swift
//  Sample App Customers
//
//  Created by Shopify.
//  Copyright (c) 2016 Shopify Inc. All rights reserved.
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
import Buy

class LoginViewController: UITableViewController {

    weak var delegate: AuthenticationDelegate?
    
    @IBOutlet private weak var emailField:    UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var actionCell:    ActionCell!
    
    private var email:    String { return self.emailField.text    ?? "" }
    private var password: String { return self.passwordField.text ?? "" }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actionCell.loading = false
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    private func loginUser() {
        guard !self.actionCell.loading else { return }
        
        let credentials  = BUYAccountCredentials(items: [
            BUYAccountCredentialItem(email: self.email),
            BUYAccountCredentialItem(password: self.password),
        ])
        
        self.actionCell.loading = true
        BUYClient.sharedClient.loginCustomerWithCredentials(credentials) { (customer, token, error) in
            self.actionCell.loading = false
            
            if let customer = customer,
                let token = token {
                self.clear()
                self.delegate?.authenticationDidSucceedForCustomer(customer, withToken: token)
            } else {
                self.delegate?.authenticationDidFailWithError(error)
            }
        }
    }
    
    private func clear() {
        self.emailField.text     = ""
        self.passwordField.text  = ""
    }
    
    // ----------------------------------
    //  MARK: - UITableViewDelegate -
    //
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            
            if !self.email.isEmpty &&
                !self.password.isEmpty {
                
                self.loginUser()
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
