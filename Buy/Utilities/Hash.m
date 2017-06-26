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

#pragma mark - Hash -
@interface Hash : NSObject

+ (void)data:(NSData *)data md5:(uint8_t *)md5;

@end

@implementation Hash

+ (void)data:(NSData *)data md5:(uint8_t *)md5 {
    __block CC_MD5_CTX context;
    CC_MD5_Init(&context);
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        CC_MD5_Update(&context, bytes, (CC_LONG)byteRange.length);
    }];
    
    CC_MD5_Final(md5, &context);
}

@end

#pragma mark - NSString -
@interface NSString (Digest)

+ (NSString *)md5UsingDigest:(uint8_t *)d;

@end

@implementation NSString (Digest)

+ (NSString *)md5UsingDigest:(uint8_t *)d {
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            d[0],  d[1],  d[2],  d[3],  d[4],  d[5],  d[6],  d[7],
            d[8],  d[9],  d[10], d[11], d[12], d[13], d[14], d[15]
            ];
}

@end

#pragma mark - NSData -
@implementation NSData (Hash)

- (NSString *)md5 {
    uint8_t digest[16];
    [Hash data:self md5:digest];
    
    return [NSString md5UsingDigest:digest];
}

@end

#pragma mark - NSString -
@implementation NSString (Hash)

- (NSString *)md5 {
    return [self dataUsingEncoding:NSUTF8StringEncoding].md5;
}

@end
