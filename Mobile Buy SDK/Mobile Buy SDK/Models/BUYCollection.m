//
//  BUYCollection.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-14.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYCollection.h"
#import "NSDateFormatter+BUYAdditions.h"
#import "NSURL+BUYAdditions.h"	

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
	_imageURL = [NSURL buy_urlWithString:dictionary[@"image"][@"src"]];
	_handle = dictionary[@"handle"];
	_published = [dictionary[@"published"] boolValue];
	_collectionId = dictionary[@"collection_id"];
	
	NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterForPublications];
	_createdAtDate = [dateFormatter dateFromString:dictionary[@"created_at"]];
	_updatedAtDate = [dateFormatter dateFromString:dictionary[@"updated_at"]];
	_publishedAtDate = [dateFormatter dateFromString:dictionary[@"published_at"]];
}

@end
