//
//  ClientQuery.swift
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

final class ClientQuery {

    // ----------------------------------
    //  MARK: - Storefront -
    //
    static func queryForCollections(limit: Int, after cursor: String? = nil, productLimit: Int = 25, productCursor: String? = nil) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .shop { $0
                .collections(first: Int32(limit), after: cursor) { $0
                    .pageInfo { $0
                        .hasNextPage()
                    }
                    .edges { $0
                        .cursor()
                        .node { $0
                            .id()
                            .title()
                            .descriptionHtml()
                            .image { $0
                                .src()
                            }
                            
                            .products(first: Int32(productLimit), after: productCursor) { $0
                                .fragmentForStandardProduct()
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func queryForProducts(in collection: CollectionViewModel, limit: Int, after cursor: String? = nil) -> Storefront.QueryRootQuery {
        
        return Storefront.buildQuery { $0
            .node(id: collection.model.node.id) { $0
                .onCollection { $0
                    .products(first: Int32(limit), after: cursor) { $0
                        .fragmentForStandardProduct()
                    }
                }
            }
        }
    }
    
    // ----------------------------------
    //  MARK: - Checkout -
    //
    static func mutationForCreateCheckout(with cartItems: [CartItem]) -> Storefront.MutationQuery {
        let lineItems = cartItems.map { item in
            Storefront.CheckoutLineItemInput(variantId: GraphQL.ID(rawValue: item.variant.id), quantity: Int32(item.quantity))
        }
        
        let checkoutInput = Storefront.CheckoutCreateInput(
            lineItems: lineItems,
            allowPartialAddresses: true
        )
        
        return Storefront.buildMutation { $0
            .checkoutCreate(input: checkoutInput) { $0
                .checkout { $0
                    .fragmentForCheckout()
                }
            }
        }
    }
    
    static func mutationForUpdateCheckout(_ id: String, updatingShippingAddress address: PayPostalAddress) -> Storefront.MutationQuery {
        
        
        let checkoutID   = GraphQL.ID(rawValue: id)
        let addressInput = Storefront.MailingAddressInput(
            city:     address.city,
            country:  address.country,
            province: address.province,
            zip:      address.zip
        )
        
        return Storefront.buildMutation { $0
            .checkoutShippingAddressUpdate(shippingAddress: addressInput, checkoutId: checkoutID) { $0
                .userErrors { $0
                    .field()
                    .message()
                }
                .checkout { $0
                    .fragmentForCheckout()
                }
            }
        }
    }
    
    static func mutationForUpdateCheckout(_ id: String, updatingShippingRate shippingRate: PayShippingRate) -> Storefront.MutationQuery {
        
        return Storefront.buildMutation { $0
            .checkoutShippingLineUpdate(checkoutId: GraphQL.ID(rawValue: id), shippingRateHandle: shippingRate.handle) { $0
                .userErrors { $0
                    .field()
                    .message()
                }
                .checkout { $0
                    .fragmentForCheckout()
                }
            }
        }
    }
    
    static func mutationForUpdateCheckout(_ id: String, updatingEmail email: String) -> Storefront.MutationQuery {
        
        return Storefront.buildMutation { $0
            .checkoutEmailUpdate(checkoutId: GraphQL.ID(rawValue: id), email: email) { $0
                .userErrors { $0
                    .field()
                    .message()
                }
                .checkout { $0
                    .fragmentForCheckout()
                }
            }
        }
    }
    
    static func mutationForCompleteCheckoutUsingApplePay(_ checkout: PayCheckout, billingAddress: PayAddress, token: String, idempotencyToken: String) -> Storefront.MutationQuery {
        
        let mailingAddress = Storefront.MailingAddressInput(
            address1:  billingAddress.addressLine1,
            address2:  billingAddress.addressLine2,
            city:      billingAddress.city,
            country:   billingAddress.country,
            firstName: billingAddress.firstName,
            lastName:  billingAddress.lastName,
            province:  billingAddress.province,
            zip:       billingAddress.zip
        )
        
        let paymentInput = Storefront.TokenizedPaymentInput(
            amount:         checkout.paymentDue,
            idempotencyKey: idempotencyToken,
            billingAddress: mailingAddress,
            type:           CheckoutViewModel.PaymentType.applePay.rawValue,
            paymentData:    token
        )
        
        return Storefront.buildMutation { $0
            .checkoutCompleteWithTokenizedPayment(checkoutId: GraphQL.ID(rawValue: checkout.id), payment: paymentInput) { $0
                .userErrors { $0
                    .field()
                    .message()
                }
                .payment { $0
                    .fragmentForPayment()
                }
            }
        }
    }
    
    static func queryForPayment(_ id: String) -> Storefront.QueryRootQuery {
        return Storefront.buildQuery { $0
            .node(id: GraphQL.ID(rawValue: id)) { $0
                .onPayment { $0
                    .fragmentForPayment()
                }
            }
        }
    }
    
    static func queryShippingRatesForCheckout(_ id: String) -> Storefront.QueryRootQuery {
        
        return Storefront.buildQuery { $0
            .node(id: GraphQL.ID(rawValue: id)) { $0
                .onCheckout { $0
                    .fragmentForCheckout()
                    .availableShippingRates { $0
                        .ready()
                        .shippingRates { $0
                            .handle()
                            .price()
                            .title()
                        }
                    }
                }
            }
        }
    }
}
