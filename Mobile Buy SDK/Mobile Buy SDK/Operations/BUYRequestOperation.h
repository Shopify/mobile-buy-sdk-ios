//
//  BUYRequestOperation.h
//  Mobile Buy SDK
//
//  Created by Dima Bart on 2016-05-13.
//  Copyright © 2016 Shopify Inc. All rights reserved.
//

#import "BUYOperation.h"
NS_ASSUME_NONNULL_BEGIN

@protocol BUYSerializable;

typedef void (^BUYRequestOperationCompletion)(NSDictionary * _Nullable json, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface BUYRequestOperation : BUYOperation

@property (strong, nonatomic, readonly, nonnull) NSURLSession *session;
@property (strong, nonatomic, readonly, nonnull) NSURLRequest *originalRequest;

+ (instancetype)operationWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable> _Nullable)payload completion:(BUYRequestOperationCompletion)completion;

- (instancetype)initWithSession:(NSURLSession *)session request:(NSURLRequest *)request payload:(id<BUYSerializable> _Nullable)payload completion:(BUYRequestOperationCompletion)completion;

@end

NS_ASSUME_NONNULL_END
