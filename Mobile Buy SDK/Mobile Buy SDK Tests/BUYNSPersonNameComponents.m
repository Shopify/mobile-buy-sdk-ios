//
//  BUYNSPersonNameComponents.m
//  Mobile Buy SDK
//
//  Created by Rune Madsen on 2015-08-24.
//  Copyright © 2015 Shopify Inc. All rights reserved.
//

#import "BUYNSPersonNameComponents.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
@interface BUYNSPersonNameComponents () {
	NSString *_givenName;
	NSString *_familyName;
}

@end

@implementation BUYNSPersonNameComponents

- (void)setGivenName:(NSString *)givenName
{
	_givenName = givenName;
}

- (NSString *)givenName
{
	return _givenName;
}

- (void)setFamilyName:(NSString *)familyName
{
	_familyName = familyName;
}

- (NSString *)familyName
{
	return _familyName;
}

@end
#endif
