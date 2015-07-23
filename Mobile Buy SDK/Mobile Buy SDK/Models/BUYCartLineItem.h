//
//  BUYCartLineItem.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-07-22.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import <Buy/Buy.h>

/**
 *  BUYCartLineItem is a subclass of BUYLineItem that extends the object
 *  by exposing the BUYProductVariant that the line item was initialized with
 *  using `initWithVariant:`.
 *
 *  Note that this object is only used for a BUYCart and line item objects on
 *  BUYCheckout are represented by BUYLineItem objects that only contain the
 *  variant ID (if created from a BUYProductVariant).
 */
@interface BUYCartLineItem : BUYLineItem

/**
 *  The BUYProductVariant object associated with the line item
 *  when created using the preferred `initWithVariant:` initializer.
 */
@property (nonatomic, strong, readonly) BUYProductVariant *variant;

@end
