//
//  BUYPKContact.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-21.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "BUYPKContact.h"
#import "BUYNSPersonNameComponents.h"
#import "BUYCNPostalAddress.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
@interface BUYPKContact () {
	BUYNSPersonNameComponents *_name;
	BUYCNPostalAddress *_postalAddress;
	CNPhoneNumber *_phoneNumber;
}

@end

@implementation BUYPKContact

- (void)setName:(BUYNSPersonNameComponents *)name
{
	_name = name;
}

-(NSPersonNameComponents *)name
{
	return _name;
}

- (void)setPostalAddress:(BUYCNPostalAddress *)postalAddress
{
	_postalAddress = postalAddress;
}

- (CNPostalAddress *)postalAddress
{
	return _postalAddress;
}

- (void)setPhoneNumber:(CNPhoneNumber*)phoneNumber
{
	_phoneNumber = phoneNumber;
}

- (CNPhoneNumber *)phoneNumber
{
	return _phoneNumber;
}

@end
#else
@implementation BUYPKContact
@end
#endif
