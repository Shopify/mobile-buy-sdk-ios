//
//  BUYCNPostalAddress.m
//  Mobile Buy SDK
//
//  Created by Shopify.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
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

#import "BUYCNPostalAddress.h"

@interface BUYCNPostalAddress () {
	NSString *_street;
	NSString *_city;
	NSString *_state;
	NSString *_postalCode;
	NSString *_country;
	NSString *_ISOCountryCode;
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

- (void)setISOCountryCode:(NSString*)ISOCountryCode
{
	_ISOCountryCode = ISOCountryCode;
}

- (NSString*)ISOCountryCode
{
	return _ISOCountryCode;
}

@end
