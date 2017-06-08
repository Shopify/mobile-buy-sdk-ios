//
//  CartViewController.swift
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
import Pay
import SafariServices

class CartViewController: ParallaxViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    private var totalsViewController: TotalsViewController!
    
    fileprivate var paySession: PaySession?
    
    // ----------------------------------
    //  MARK: - Segue -
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
        case "TotalsViewController":
            self.totalsViewController          = segue.destination as! TotalsViewController
            self.totalsViewController.delegate = self
        default:
            break
        }
    }
    
    // ----------------------------------
    //  MARK: - View Loading -
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureParallax()
        self.configureTableView()
        
        self.updateSubtotal()
        
        self.registerNotifications()
    }
    
    deinit {
        self.unregisterNotifications()
    }
    
    private func configureParallax() {
        self.layout       = .headerAbove
        self.headerHeight = self.view.bounds.width * 0.5 // 2:1 ratio
        self.multiplier   = 0.0
    }
    
    private func configureTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        
        if self.traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
    
    // ----------------------------------
    //  MARK: - Notifications -
    //
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartControllerItemsDidChange(_:)), name: Notification.Name.CartControllerItemsDidChange, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private dynamic func cartControllerItemsDidChange(_ notification: Notification) {
        self.updateSubtotal()
    }
    
    // ----------------------------------
    //  MARK: - Update -
    //
    func updateSubtotal() {
        self.totalsViewController.subtotal  = CartController.shared.subtotal
        self.totalsViewController.itemCount = CartController.shared.itemCount
    }
    
    // ----------------------------------
    //  MARK: - Actions -
    //
    func openSafariFor(_ checkout: CheckoutViewModel) {
        let safari                  = SFSafariViewController(url: checkout.webURL)
        safari.navigationItem.title = "Checkout"
        self.navigationController?.show(safari, sender: self)
    }
    
    func authorizePaymentWith(_ checkout: CheckoutViewModel) {
        let payCurrency = PayCurrency(currencyCode: "CAD", countryCode: "CA")
        let payItems    = checkout.lineItems.map { item in
            PayLineItem(price: item.totalPrice, quantity: item.quantity)
        }
        
        let payCheckout = PayCheckout(
            id:              checkout.id,
            lineItems:       payItems,
            discount:        nil,
            shippingAddress: nil,
            shippingRate:    nil,
            subtotalPrice:   checkout.subtotalPrice,
            needsShipping:   checkout.requiresShipping,
            totalTax:        checkout.totalTax,
            paymentDue:      checkout.paymentDue
        )
        
        let paySession      = PaySession(checkout: payCheckout, currency: payCurrency, merchantID: "com.mechant.identifier")
        paySession.delegate = self
        self.paySession     = paySession
        
        paySession.authorize()
    }
    
    // ----------------------------------
    //  MARK: - View Controllers -
    //
    func productDetailsViewControllerWith(_ product: ProductViewModel) -> ProductDetailsViewController {
        let controller: ProductDetailsViewController = self.storyboard!.instantiateViewController()
        controller.product = product
        return controller
    }
}

// ----------------------------------
//  MARK: - Actions -
//
extension CartViewController {
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// ----------------------------------
//  MARK: - TotalsControllerDelegate -
//
extension CartViewController: TotalsControllerDelegate {
    
    func totalsController(_ totalsController: TotalsViewController, didRequestPaymentWith type: PaymentType) {
        let cartItems = CartController.shared.items
        Client.shared.createCheckout(with: cartItems) { checkout in
            if let checkout = checkout {
                
                switch type {
                case .webCheckout: self.openSafariFor(checkout)
                case .applePay:    self.authorizePaymentWith(checkout)
                }
                
            } else {
                print("Failed to create checkout")
            }
        }
    }
}

// ----------------------------------
//  MARK: - PaySessionDelegate -
//
extension CartViewController: PaySessionDelegate {
    
    func paySession(_ paySession: PaySession, didRequestShippingRatesFor address: PayPostalAddress, checkout: PayCheckout, provide: @escaping  (PayCheckout?, [PayShippingRate]) -> Void) {
        
        print("Updating checkout with address...")
        Client.shared.updateCheckout(checkout.id, updatingShippingAddress: address) { checkout in
            
            guard let checkout = checkout else {
                print("Update for checkout failed.")
                provide(nil, [])
                return
            }
            
            print("Getting shipping rates...")
            Client.shared.fetchShippingRatesForCheckout(checkout.id) { result in
                if let result = result {
                    print("Fetched shipping rates.")
                    provide(result.checkout.payCheckout, result.rates.payShippingRates)
                } else {
                    provide(nil, [])
                }
            }
        }
    }
    
    func paySession(_ paySession: PaySession, didSelectShippingRate shippingRate: PayShippingRate, checkout: PayCheckout, provide: @escaping  (PayCheckout?) -> Void) {
        
        print("Selecting shipping rate...")
        Client.shared.updateCheckout(checkout.id, updatingShippingRate: shippingRate) { updatedCheckout in
            print("Selected shipping rate.")
            provide(updatedCheckout?.payCheckout)
        }
    }
    
    func paySession(_ paySession: PaySession, didAuthorizePayment authorization: PayAuthorization, checkout: PayCheckout, completeTransaction: @escaping (PaySession.TransactionStatus) -> Void) {
        
        guard let email = authorization.shippingAddress.email else {
            print("Unable to update checkout email. Aborting transaction.")
            completeTransaction(.failure)
            return
        }
        
        print("Updating checkout email...")
        Client.shared.updateCheckout(checkout.id, updatingEmail: email) { updatedCheckout in
            
            guard let _ = updatedCheckout else {
                completeTransaction(.failure)
                return
            }
            
            print("Checkout email updated: \(email)")
            print("Completing checkout...")
            Client.shared.completeCheckout(checkout, billingAddress: authorization.billingAddress, applePayToken: authorization.token, idempotencyToken: paySession.identifier) { payment in
                if let payment = payment, checkout.paymentDue == payment.amount {
                    print("Checkout completed successfully.")
                    completeTransaction(.success)
                } else {
                    print("Checkout failed to complete.")
                    completeTransaction(.failure)
                }
            }
        }
    }
    
    func paySessionDidFinish(_ paySession: PaySession) {
        
    }
}

// ----------------------------------
//  MARK: - UIViewControllerPreviewingDelegate -
//
extension CartViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let tableView = previewingContext.sourceView as! UITableView
        if let indexPath = tableView.indexPathForRow(at: location) {
            
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            
            let cell    = tableView.cellForRow(at: indexPath) as! CartCell
            let product = cell.viewModel!.model.product
            
            return self.productDetailsViewControllerWith(product)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController!.show(viewControllerToCommit, sender: self)
    }
}

// ----------------------------------
//  MARK: - CartCellDelegate -
//
extension CartViewController: CartCellDelegate {
    
    func cartCell(_ cell: CartCell, didUpdateQuantity quantity: Int) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            let didUpdate = CartController.shared.updateQuantity(quantity, at: indexPath.row)
            if didUpdate {
                
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .none)
                self.tableView.endUpdates()
            }
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDataSource -
//
extension CartViewController: UITableViewDataSource {
    
    // ----------------------------------
    //  MARK: - Data -
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartController.shared.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell     = tableView.dequeueReusableCell(withIdentifier: CartCell.className, for: indexPath) as! CartCell
        let cartItem = CartController.shared.items[indexPath.row]
        
        cell.delegate = self
        cell.configureFrom(cartItem.viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            tableView.beginUpdates()
            
            CartController.shared.removeAllQuantities(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        default:
            break
        }
    }
}

// ----------------------------------
//  MARK: - UITableViewDelegate -
//
extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateParallax()
    }
}
