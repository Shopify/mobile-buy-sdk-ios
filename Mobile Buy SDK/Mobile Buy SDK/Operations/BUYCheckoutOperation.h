//
//  BUYCheckoutOperation.h
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYOperation.h"

@class BUYClient;
@class BUYCheckout;
@protocol BUYPaymentToken;

typedef void (^BUYOperationCheckoutCompletion)(BUYCheckout *checkout, NSError *error);

@interface BUYCheckoutOperation : BUYOperation

@property (strong, nonatomic, readonly) BUYOperationCheckoutCompletion completion;

- (instancetype)initWithCheckout:(BUYCheckout *)checkout token:(id<BUYPaymentToken>)token client:(BUYClient *)client completion:(BUYOperationCheckoutCompletion)completion;

@end
