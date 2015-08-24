//
//  BUYCNPostalAddress.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-24.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "BUYCNPostalAddress.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
@interface BUYCNPostalAddress () {
	NSString *_street;
	NSString *_city;
	NSString *_state;
	NSString *_postalCode;
	NSString *_country;
}

@end

@implementation BUYCNPostalAddress

- (void)setStreet:(NSString*)street
{
	_street = street;
}

- (NSString *)street
{
	return _street;
}

- (void)setCity:(NSString*)city
{
	_city = city;
}

- (NSString*)city
{
	return _city;
}

- (void)setState:(NSString*)state
{
	_state = state;
}

- (NSString *)state
{
	return _state;
}

- (void)setPostalCode:(NSString*)postalCode
{
	_postalCode = postalCode;
}

- (NSString*)postalCode
{
	return _postalCode;
}

- (void)setCountry:(NSString*)country
{
	_country = country;
}

- (NSString*)country
{
	return _country;
}

@end
#endif
