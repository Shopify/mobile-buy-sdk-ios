//
//  AccountViewController.swift
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

class AccountViewController: UIViewController {
    
    @IBOutlet weak var loginContainerView:  UIView!
    @IBOutlet weak var signupContainerView: UIView!
    
    private var loginViewController:  LoginViewController!
    private var signupViewController: SignupViewController!
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("loginSegue"):
            self.loginViewController = segue.destination as! LoginViewController
            self.loginViewController.delegate = self
            
        case .some("signupSegue"):
            self.signupViewController = segue.destination as! SignupViewController
            self.signupViewController.delegate = self
            
        default:
            break
        }
        
        if self.loginViewController != nil && self.signupViewController != nil {
            self.updateSelectedIndex(0)
        }
    }
    
    // ----------------------------------
    //  MARK: - Updates -
    //
    private func updateSelectedIndex(_ index: Int) {
        self.loginContainerView.isHidden  = (index != 0)
        self.signupContainerView.isHidden = (index == 0)
    }
    
    // ----------------------------------
    //  MARK: - UI Actions -
    //
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        self.updateSelectedIndex(sender.selectedSegmentIndex)
    }
}

// ----------------------------------
//  MARK: - AuthenticationDelegate -
//
extension AccountViewController: AuthenticationDelegate {
    func authenticationDidSucceedForCustomer(_ customer: BUYCustomer, withToken token: String) {
        
        if let orders = self.storyboard?.instantiateViewController(withIdentifier: "ordersViewController") as? OrdersViewController {
            orders.customer = customer
            self.navigationController?.pushViewController(orders, animated: true)
        }
    }
    
    func authenticationDidFailWithError(_ error: NSError?) {
        let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
