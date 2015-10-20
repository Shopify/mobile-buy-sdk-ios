//
//  BUYCollection.m
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

#import "BUYCollection.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSURL+BUYAdditions.h"	
#import "NSDictionary+Additions.h"

@interface BUYCollection ()
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *htmlDescription;
@property (nonatomic, strong) NSString *handle;
@property (nonatomic, assign) BOOL published;
@property (nonatomic, strong) NSNumber *collectionId;
@end

@implementation BUYCollection

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
	[super updateWithDictionary:dictionary];
	
	_title = dictionary[@"title"];
	_htmlDescription = dictionary[@"body_html"];
	_imageURL = [NSURL buy_urlWithString:[dictionary buy_objectForKey:@"image"][@"src"]];
	_handle = dictionary[@"handle"];
	_published = [dictionary[@"published"] boolValue];
	_collectionId = dictionary[@"collection_id"];
	
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	_createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	_publishedAtDate = [dateFormatter dateFromString:dictionary[@"published_at"]];
}

@end
