//
//  BUYCNPostalAddress.h
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-24.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
#import <Contacts/Contacts.h>

@interface BUYCNPostalAddress : CNPostalAddress

- (void)setStreet:(NSString*)street;
- (void)setCity:(NSString*)city;
- (void)setState:(NSString*)state;
- (void)setPostalCode:(NSString*)postalCode;
- (void)setCountry:(NSString*)country;

@end
#endif
