//
//  CustomerViewController.swift
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

protocol CustomerControllerDelegate: class {
    func customerControllerDidCancel(_ customerController: CustomerViewController)
    func customerControllerDidLogout(_ customerController: CustomerViewController)
}

class CustomerViewController: ParallaxViewController {
    
    weak var delegate: CustomerControllerDelegate?
    
    private var profileViewController: ProfileViewController!
    
    @IBOutlet private weak var tableView: StorefrontTableView!
    
    private var customer: CustomerViewModel!
    private var orders: PageableArray<OrderViewModel>!
    private var token: String!
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
        case "ProfileViewController":
            self.profileViewController = (segue.destination as! ProfileViewController)
        default:
            break
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.token = AccountController.shared.accessToken
        
        self.configureTableView()
        self.configureParallax()
        
        self.fetchOrders()
    }
    
    private func configureTableView() {
        self.tableView.paginationDelegate = self
    }
    
    private func configureParallax() {
        self.layout       = .headerAbove
        self.headerHeight = self.view.bounds.width * 0.3
        self.multiplier   = 0.0
    }
    
    // ----------------------------------
    //  MARK: - Fetching -
    //
    fileprivate func fetchOrders(after cursor: String? = nil) {
        Client.shared.fetchCustomerAndOrders(after: cursor, accessToken: self.token) { container in
            if let container = container {
                self.customer = container.customer
                self.orders   = container.orders
                self.tableView.reloadData()
                
                self.profileViewController.customer = container.customer
            }
        }
    }
}

// ----------------------------------
//  MARK: - UI Actions -
//
extension CustomerViewController {
    @IBAction func cancelAction(_ sender: Any) {
        self.delegate?.customerControllerDidCancel(self)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        self.delegate?.customerControllerDidLogout(self)
    }
}

// ----------------------------------
//  MARK: - StorefrontTableViewDelegate -
//
extension CustomerViewController: StorefrontTableViewDelegate {
    
    func tableViewShouldBeginPaging(_ table: StorefrontTableView) -> Bool {
        return self.orders?.hasNextPage ?? false
    }
    
    func tableViewWillBeginPaging(_ table: StorefrontTableView) {
        if let orders = self.orders,
            let lastOrder = orders.items.last {
            
            Client.shared.fetchCustomerAndOrders(after: lastOrder.cursor, accessToken: self.token) { container in
                if let orders = container?.orders {
                    
                    self.orders.appendPage(from: orders)
                    
                    self.tableView.reloadData()
                    self.tableView.completePaging()
                }
            }
        }
    }
    
    func tableViewDidCompletePaging(_ table: StorefrontTableView) {
        
    }
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
extension CustomerViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateParallax()
    }
}

// ----------------------------------
//  MARK: - UICollectionViewDataSource -
//
extension CustomerViewController: UITableViewDataSource {
    
    // ----------------------------------
    //  MARK: - Data -
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orders?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell   = tableView.dequeueReusableCell(withIdentifier: OrderCell.className, for: indexPath) as! OrderCell
        let order = self.orders.items[indexPath.section]
        
        cell.configureFrom(order)
        
        return cell
    }
}
