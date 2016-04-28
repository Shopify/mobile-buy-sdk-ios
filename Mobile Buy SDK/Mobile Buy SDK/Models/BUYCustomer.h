//
//  BUYCustomer.h
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-04-28.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYObject.h"

@interface BUYCustomer : BUYObject

@property (nonatomic, assign) BOOL taxExempt;

@property (nonatomic, assign) BOOL verifiedEmail;

@property (nonatomic, assign) BOOL acceptsMarketing;

@property (nonatomic, assign) BOOL customerState;

@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) NSString *firstName;

@property (nonatomic, strong) NSString *lastName;

@property (nonatomic, strong) NSNumber *lastOrderID;

@property (nonatomic, strong) NSString *lastOrderName;

@property (nonatomic, strong) NSString *multipassIdentifier;

@property (nonatomic, strong) NSString *note;

@property (nonatomic, strong) NSString *tags;

@property (nonatomic, strong) NSNumber *ordersCount;

@property (nonatomic, strong) NSDecimalNumber *totalSpent;

@property (nonatomic, strong) NSDate *createdAt;

@property (nonatomic, strong) NSDate *updatedAt;

@end
