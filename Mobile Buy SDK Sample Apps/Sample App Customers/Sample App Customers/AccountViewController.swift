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

class AccountViewController: UIViewController {
    
    @IBOutlet weak var loginContainerView:  UIView!
    @IBOutlet weak var signupContainerView: UIView!
    
    private var loginViewController:  LoginViewController!
    private var signupViewController: SignupViewController!

    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case let login where login == "loginSegue":
            self.loginViewController  = segue.destinationViewController as! LoginViewController
            
        case let signup where signup == "signupSegue":
            self.signupViewController = segue.destinationViewController as! SignupViewController
            
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
    private func updateSelectedIndex(index: Int) {
        self.loginContainerView.hidden  = (index != 0)
        self.signupContainerView.hidden = (index == 0)
    }
    
    // ----------------------------------
    //  MARK: - UI Actions -
    //
    @IBAction func segmentAction(sender: UISegmentedControl) {
        self.updateSelectedIndex(sender.selectedSegmentIndex)
    }
}
