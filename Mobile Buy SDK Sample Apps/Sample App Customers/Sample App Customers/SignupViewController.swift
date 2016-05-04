//
//  SignupViewController.swift
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

class SignupViewController: UITableViewController {

    @IBOutlet private weak var firstNameField:       UITextField!
    @IBOutlet private weak var lastNameField:        UITextField!
    @IBOutlet private weak var emailField:           UITextField!
    @IBOutlet private weak var passwordField:        UITextField!
    @IBOutlet private weak var passwordConfirmField: UITextField!
    
    var firstName:       String { return self.firstNameField.text ?? "" }
    var lastName:        String { return self.lastNameField.text  ?? "" }
    var email:           String { return self.emailField.text     ?? "" }
    var password:        String { return self.passwordField.text  ?? "" }
    var passwordConfirm: String { return self.passwordField.text  ?? "" }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    private func createUser() {
        let credentials = BUYAccountCredentials(items: [
            BUYAccountCredentialItem(firstName: self.firstName),
            BUYAccountCredentialItem(lastName: self.lastName),
            BUYAccountCredentialItem(email: self.email),
            BUYAccountCredentialItem(password: self.password),
            BUYAccountCredentialItem(passwordConfirmation: self.passwordConfirm),
        ])
        
        BUYClient.sharedClient.createCustomerWithCredentials(credentials) { (customer, token, error) in
            print("Customer: \(customer), Token: \(token), Error: \(error)")
        }
    }
    
    // ----------------------------------
    //  MARK: - UITableViewDelegate -
    //
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            
            if !self.email.isEmpty &&
                !self.password.isEmpty &&
                !self.firstName.isEmpty &&
                !self.lastName.isEmpty &&
                !self.passwordConfirm.isEmpty {
                
                self.createUser()
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}