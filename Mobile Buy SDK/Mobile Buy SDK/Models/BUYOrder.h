//
//  BUYOrder.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-09-08.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

@interface BUYOrder : BUYObject

/**
 *  The unique order ID
 */
@property (nonatomic, copy, readonly) NSNumber *orderId;

/**
 *  URL for the website showing the order status
 */
@property (nonatomic, strong, readonly) NSURL *statusURL;

/**
 *  The customer's order name as represented by a number.
 */
@property (nonatomic, strong, readonly) NSString *name;

@end
