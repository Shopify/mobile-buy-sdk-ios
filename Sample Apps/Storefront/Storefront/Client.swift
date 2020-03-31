//
//  Client.swift
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

import Foundation
import Buy
import Pay

final class Client {
    
    static let shopDomain = "graphql.myshopify.com"
    static let apiKey     = "8e2fef6daed4b93cf4e731f580799dd1"
    static let merchantID = "merchant.com.your.id"
    static let locale   = Locale(identifier: "en-US")
    
    static let shared = Client()
    
    private let client: Graph.Client = Graph.Client(shopDomain: Client.shopDomain, apiKey: Client.apiKey, locale: Client.locale)
    
    // ----------------------------------
    //  MARK: - Init -
    //
    private init() {
        self.client.cachePolicy = .cacheFirst(expireIn: 3600)
    }
    
    // ----------------------------------
    //  MARK: - Customers -
    //
    @discardableResult
    func login(email: String, password: String, completion: @escaping (String?) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationForLogin(email: email, password: password)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let container = mutation?.customerAccessTokenCreate?.customerAccessToken {
                completion(container.accessToken)
            } else {
                let errors = mutation?.customerAccessTokenCreate?.customerUserErrors ?? []
                print("Failed to login customer: \(errors)")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func logout(accessToken: String, completion: @escaping (Bool) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationForLogout(accessToken: accessToken)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let deletedToken = mutation?.customerAccessTokenDelete?.deletedAccessToken {
                completion(deletedToken == accessToken)
            } else {
                let errors = mutation?.customerAccessTokenDelete?.userErrors ?? []
                print("Failed to logout customer: \(errors)")
                completion(false)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func fetchCustomerAndOrders(limit: Int = 25, after cursor: String? = nil, accessToken: String, completion: @escaping ((customer: CustomerViewModel, orders: PageableArray<OrderViewModel>)?) -> Void) -> Task {
        
        let query = ClientQuery.queryForCustomer(limit: limit, after: cursor, accessToken: accessToken)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let customer = query?.customer {
                let viewModel   = customer.viewModel
                let collections = PageableArray(
                    with:     customer.orders.edges,
                    pageInfo: customer.orders.pageInfo
                )
                completion((viewModel, collections))
            } else {
                print("Failed to load customer and orders: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Shop -
    //
    @discardableResult
    func fetchShopName(completion: @escaping (String?) -> Void) -> Task {
        
        let query = ClientQuery.queryForShopName()
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                completion(query.shop.name)
            } else {
                print("Failed to fetch shop name: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Collections -
    //
    @discardableResult
    func fetchCollections(limit: Int = 25, after cursor: String? = nil, productLimit: Int = 25, productCursor: String? = nil, completion: @escaping (PageableArray<CollectionViewModel>?) -> Void) -> Task {
        
        let query = ClientQuery.queryForCollections(limit: limit, after: cursor, productLimit: productLimit, productCursor: productCursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query {
                let collections = PageableArray(
                    with:     query.collections.edges,
                    pageInfo: query.collections.pageInfo
                )
                completion(collections)
            } else {
                print("Failed to load collections: \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Products -
    //
    @discardableResult
    func fetchProducts(in collection: CollectionViewModel, limit: Int = 25, after cursor: String? = nil, completion: @escaping (PageableArray<ProductViewModel>?) -> Void) -> Task {
        
        let query = ClientQuery.queryForProducts(in: collection, limit: limit, after: cursor)
        let task  = self.client.queryGraphWith(query) { (query, error) in
            error.debugPrint()
            
            if let query = query,
                let collection = query.node as? Storefront.Collection {
                
                let products = PageableArray(
                    with:     collection.products.edges,
                    pageInfo: collection.products.pageInfo
                )
                completion(products)
                
            } else {
                print("Failed to load products in collection (\(collection.model.node.id.rawValue)): \(String(describing: error))")
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Discounts -
    //
    @discardableResult
    func applyDiscount(_ discountCode: String, to checkoutID: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForApplyingDiscount(discountCode, to: checkoutID)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            completion(response?.checkoutDiscountCodeApplyV2?.checkout?.viewModel)
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Gift Cards -
    //
    @discardableResult
    func applyGiftCard(_ giftCardCode: String, to checkoutID: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForApplyingGiftCard(giftCardCode, to: checkoutID)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            completion(response?.checkoutGiftCardsAppend?.checkout?.viewModel)
        }
        
        task.resume()
        return task
    }
    
    // ----------------------------------
    //  MARK: - Checkout -
    //
    @discardableResult
    func createCheckout(with cartItems: [CartItem], completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForCreateCheckout(with: cartItems)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            completion(response?.checkoutCreate?.checkout?.viewModel)
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func updateCheckout(_ id: String, updatingPartialShippingAddress address: PayPostalAddress, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingPartialShippingAddress: address)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            if let checkout = response?.checkoutShippingAddressUpdateV2?.checkout,
                let _ = checkout.shippingAddress {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func updateCheckout(_ id: String, updatingCompleteShippingAddress address: PayAddress, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingCompleteShippingAddress: address)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            if let checkout = response?.checkoutShippingAddressUpdateV2?.checkout,
                let _ = checkout.shippingAddress {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func updateCheckout(_ id: String, updatingShippingRate shippingRate: PayShippingRate, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingShippingRate: shippingRate)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            if let checkout = response?.checkoutShippingLineUpdate?.checkout,
                let _ = checkout.shippingLine {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func updateCheckout(_ id: String, updatingEmail email: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        let mutation = ClientQuery.mutationForUpdateCheckout(id, updatingEmail: email)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            if let checkout = response?.checkoutEmailUpdateV2?.checkout,
                let _ = checkout.email {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func updateCheckout(_ id: String, associatingCustomer accessToken: String, completion: @escaping (CheckoutViewModel?) -> Void) -> Task {
        
        let mutation = ClientQuery.mutationForUpdateCheckout(id, associatingCustomer: accessToken)
        let task     = self.client.mutateGraphWith(mutation) { (mutation, error) in
            error.debugPrint()
            
            if let checkout = mutation?.checkoutCustomerAssociateV2?.checkout {
                completion(checkout.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func fetchShippingRatesForCheckout(_ id: String, completion: @escaping ((checkout: CheckoutViewModel, rates: [ShippingRateViewModel])?) -> Void) -> Task {
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { response, error -> Bool in
            error.debugPrint()
            
            if let response = response {
                return (response.node as! Storefront.Checkout).availableShippingRates?.ready ?? false == false
            } else {
                return false
            }
        }
        
        let query = ClientQuery.queryShippingRatesForCheckout(id)
        let task  = self.client.queryGraphWith(query, cachePolicy: .networkOnly, retryHandler: retry) { response, error in
            error.debugPrint()
            
            if let response = response,
                let checkout = response.node as? Storefront.Checkout {
                completion((checkout.viewModel, checkout.availableShippingRates!.shippingRates!.viewModels))
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        return task
    }
    
    func completeCheckout(_ checkout: PayCheckout, billingAddress: PayAddress, applePayToken token: String, idempotencyToken: String, completion: @escaping (PaymentViewModel?) -> Void) {
        
        let mutation = ClientQuery.mutationForCompleteCheckoutUsingApplePay(checkout, billingAddress: billingAddress, token: token, idempotencyToken: idempotencyToken)
        let task     = self.client.mutateGraphWith(mutation) { response, error in
            error.debugPrint()
            
            if let payment = response?.checkoutCompleteWithTokenizedPaymentV2?.payment {
                
                print("Payment created, fetching status...")
                self.fetchCompletedPayment(payment.id.rawValue) { paymentViewModel in
                    completion(paymentViewModel)
                }
                
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func fetchCompletedPayment(_ id: String, completion: @escaping (PaymentViewModel?) -> Void) {
        
        let retry = Graph.RetryHandler<Storefront.QueryRoot>(endurance: .finite(30)) { response, error -> Bool in
            error.debugPrint()
            
            if let payment = response?.node as? Storefront.Payment {
                print("Payment not ready yet, retrying...")
                return !payment.ready
            } else {
                return false
            }
        }
        
        let query = ClientQuery.queryForPayment(id)
        let task  = self.client.queryGraphWith(query, retryHandler: retry) { query, error in
            
            if let payment = query?.node as? Storefront.Payment {
                print("Payment error: \(payment.errorMessage ?? "none")")
                completion(payment.viewModel)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

// ----------------------------------
//  MARK: - GraphError -
//
extension Optional where Wrapped == Graph.QueryError {
    
    func debugPrint() {
        switch self {
        case .some(let value):
            print("Graph.QueryError: \(value)")
        case .none:
            break
        }
    }
}
