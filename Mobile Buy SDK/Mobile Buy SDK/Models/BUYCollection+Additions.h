//
//  BUYCollection+Additions.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-29.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCollection.h"
#import "BUYClient.h"

@interface BUYCollection (Additions)

+(NSString *)sortOrderParameterForCollectionSort:(BUYCollectionSort)sort;

@end
