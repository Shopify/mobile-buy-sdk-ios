//
//  OrdersViewController.swift
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

class OrdersViewController: UIViewController {
    
    var customer: BUYCustomer!

    @IBOutlet private weak var tableView: UITableView!
    
    fileprivate var orders = [BUYOrder]()
    
    fileprivate let dateFormatter: DateFormatter = {
        let f       = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadOrders()
    }
    
    private func loadOrders() {
        BUYClient.sharedClient.getOrdersForCustomerCallback { (orders, error) in
            if let orders = orders {
                self.orders = orders
                self.tableView.reloadData()
            } else {
                print("Could not fetch orders: \(error)")
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - UI Actions -
    //
    @IBAction func logoutAction(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension OrdersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders[section].lineItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let order = self.orders[section]
        return "\(self.dateFormatter.string(from: order.processedAt)) - \(order.name!)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let order = self.orders[section]
        return "Order total: $\(order.totalPrice!)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LineItemCell
        let lineItem = self.orders[(indexPath as NSIndexPath).section].lineItemsArray()[(indexPath as NSIndexPath).row]
        
        cell.setLineItem(lineItem)
        
        return cell
    }
}
