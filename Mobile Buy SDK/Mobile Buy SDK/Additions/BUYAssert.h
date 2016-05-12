//
//  BUYAssert.h
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-12.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#define BUYAssert(exp, ...) \
do { \
	if (!(exp)) { \
		@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:__VA_ARGS__] userInfo:nil]; \
	} \
} while(0)
