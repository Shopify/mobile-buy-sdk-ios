//
//  Hash.m
//  Crypto
//
//  Created by Shopify.
//  Copyright (c) 2017 Shopify Inc. All rights reserved.
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

#import "Hash.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSData (ShopifyHash)

- (NSString *)shopify_hexadecimalString {
    NSMutableString *builder = [[NSMutableString alloc] initWithCapacity:self.length * 2];
    const unsigned char *buffer = self.bytes;
    for (NSUInteger i = 0; i < self.length; i++) {
        [builder appendFormat:@"%02x", buffer[i]];
    }
    return builder;
}

- (NSString *)shopify_md5 {
    void *buffer = malloc(CC_MD5_DIGEST_LENGTH);
    CC_MD5(self.bytes, (CC_LONG) self.length, buffer);
    return [[NSData dataWithBytesNoCopy:buffer length:CC_MD5_DIGEST_LENGTH] shopify_hexadecimalString];
}

@end

@implementation NSString (ShopifyHash)

- (NSString *)shopify_md5 {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] shopify_md5];
}

@end
