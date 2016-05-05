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

    @IBOutlet private weak var tableView: UITableView!
    
    private var orders = [BUYOrder]()
    
    private let dateFormatter: NSDateFormatter = {
        let f       = NSDateFormatter()
        f.dateStyle = .MediumStyle
        f.timeStyle = .NoStyle
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
        BUYClient.sharedClient.getOrdersForCustomerWithCallback { (orders, error) in
            if let orders = orders {
                self.orders = orders
                self.tableView.reloadData()
            } else {
                print("Could not fetch orders: \(error)")
            }
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension OrdersViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.orders.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders[section].lineItems.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let order = self.orders[section]
        return "\(self.dateFormatter.stringFromDate(order.processedAt)) - \(order.name)"
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let order = self.orders[section]
        return "Order total: $\(order.totalPrice) \(order.currency)"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! LineItemCell
        let lineItem = self.orders[indexPath.section].lineItems[indexPath.row]
        
        cell.setLineItem(lineItem)
        
        return cell
    }
}

// ----------------------------------
//  MARK: - BUYOrder -
//
extension BUYOrder {
    
    var lineItems: [BUYLineItem] {
        var items = self.fulfilledLineItems
        items.appendContentsOf(self.unfulfilledLineItems)
        return items
    }
}