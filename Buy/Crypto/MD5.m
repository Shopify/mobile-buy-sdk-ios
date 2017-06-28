//
//  MD5.m
//  Buy
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

#import "MD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation MD5

+ (NSString *)data:(NSData *)data {
    uint8_t digest[16];
    [self data:data md5:digest];
    
    return [self string16FromDigest:digest];
}

+ (NSString *)string:(NSString *)string {
    return [self data:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (void)data:(NSData *)data md5:(uint8_t *)md5 {
    __block CC_MD5_CTX context;
    CC_MD5_Init(&context);
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        CC_MD5_Update(&context, bytes, (CC_LONG)byteRange.length);
    }];
    
    CC_MD5_Final(md5, &context);
}

+ (NSString *)string16FromDigest:(uint8_t *)d {
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            d[0],  d[1],  d[2],  d[3],  d[4],  d[5],  d[6],  d[7],
            d[8],  d[9],  d[10], d[11], d[12], d[13], d[14], d[15]
            ];
}

@end
