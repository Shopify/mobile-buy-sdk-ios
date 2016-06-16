//
//  NSString+BUYAdditions.m
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

#import "BUYAssert.h"
#import "NSString+BUYAdditions.h"
#import "NSArray+BUYAdditions.h"
#import "NSRegularExpression+BUYAdditions.h"

/**
 * A regex pattern that matches all lowercase roman characters and numbers at the beginning of a string.
 */
static NSString * const InitialTokenPattern = @"^[a-z][a-z0-9]*";
/**
 * A regex pattern that matches a either one or more capitalized roman characters, or
 * a sequence of lower-case and number characters followed by a capitalized roman character.
 * This matches the reverse pattern of words in a camel-case string that are either UPPER case or Capitalized.
 */
static NSString * const ReverseSuccessiveTokenPattern = @"([A-Z]*|[a-z0-9]*)[A-Z]";

/**
 * A convenience macro for converting a getter-style selector name into a string, to use in key-value coding.
 */
#define StringForSelector(sel) NSStringFromSelector(@selector(sel))

@implementation NSString (BUYAdditions)

#pragma mark - Transformations -
static NSSet *acronyms;

+ (NSSet *)buy_acronyms
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		acronyms = [NSSet setWithArray:@[ @"url" ]];
	});
	return acronyms;
}

+ (NSArray *)buy_acronymStrings
{
	return [[self buy_acronyms] allObjects];
}

+ (void)buy_setAcronymStrings:(NSArray *)strings
{
	acronyms = [NSSet setWithArray:[strings buy_map:^(NSString *string) {
		return [string lowercaseString];
	}]];
}

- (NSString *)buy_camelCaseString
{
	NSArray *tokens = [self componentsSeparatedByString:@"_"];
	NSArray *tailTokens = [tokens.buy_tail buy_map:^(NSString *token) {
		return [token buy_camelCaseTailTokenForm];
	}];
	return [[tokens.firstObject buy_camelCaseFirstTokenForm] stringByAppendingString:[tailTokens componentsJoinedByString:@""]];
}

- (NSString *)buy_camelCaseFirstTokenForm
{
	return [self isAcronym] ? [self uppercaseString] : self;
}

- (NSString *)buy_camelCaseTailTokenForm
{
	return [self isAcronym] ? [self uppercaseString] : [self capitalizedString];
}

- (BOOL)isAcronym
{
	return [[NSString buy_acronyms] containsObject:self];
}

- (NSString *)buy_snakeCaseString
{
	return [[[self buy_camelCaseTokens] valueForKey:StringForSelector(lowercaseString)] componentsJoinedByString:@"_"];
}

- (NSArray *)buy_camelCaseTokens
{
	NSString *first = [self buy_firstCamelCaseToken];
	NSArray *rest = [self successiveCamelCaseTokens];
	return first.length > 0 ? [@[first] arrayByAddingObjectsFromArray:rest] : rest;
}

- (NSString *)buy_firstCamelCaseToken
{
	return [self buy_firstMatchForPattern:InitialTokenPattern];
}

- (NSArray *)successiveCamelCaseTokens
{
	return [[[self.buy_reversedString buy_matchesForPattern:ReverseSuccessiveTokenPattern] valueForKey:StringForSelector(buy_reversedString)] buy_reversedArray];
}

- (NSArray *)buy_matchesForRegularExpression:(NSRegularExpression *)regex
{
	return [[regex buy_matchesInString:self] buy_map:^id(NSTextCheckingResult *result) {
		return [self substringWithRange:result.range];
	}];
}

- (NSString *)buy_firstMatchForRegularExpression:(NSRegularExpression *)regex
{
	return [self substringWithRange:[regex buy_firstMatchInString:self].range];
}

- (NSArray *)buy_matchesForPattern:(NSString *)pattern
{
	return [self buy_matchesForRegularExpression:[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL]];
}

- (NSString *)buy_firstMatchForPattern:(NSString *)pattern
{
	return [self buy_firstMatchForRegularExpression:[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:NULL]];
}

- (NSString *)buy_reversedString
{
	BUYAssert([self canBeConvertedToEncoding:NSUTF8StringEncoding], @"Unable to reverse string; requires a string that can be encoded in UTF8");

	const char *str = [self UTF8String];
	unsigned long len = strlen(str);
	char *rev = malloc(sizeof(char) * len + 1);
	
	for (unsigned long i=0; i<len; ++i) {
		rev[i] = str[len-i-1];
	}
	rev[len] = '\0';
	
	NSString *reversedString = [NSString stringWithUTF8String:rev];
	free(rev);
	
	return reversedString;
}

#pragma mark - Path Extensions -
- (NSString *)directory
{
	return [self stringByDeletingLastPathComponent];
}

- (NSString *)baseFileName
{
	return [[self.pathComponents lastObject] stringByDeletingPathExtension];
}

- (NSString *)buy_stringByReplacingBaseFileName:(NSString *)newName
{
	if (self.pathExtension.length > 0) {
		newName = [newName stringByAppendingPathExtension:self.pathExtension];
	}
	return [self.directory stringByAppendingPathComponent:newName];
}

- (NSString *)buy_stringByReplacingDirectory:(NSString *)newDirectory
{
	return [newDirectory stringByAppendingPathComponent:[self.baseFileName stringByAppendingPathExtension:self.pathExtension]];
}

- (NSString *)buy_stringByAppendingBaseFileNameSuffix:(NSString *)suffix
{
	return [self buy_stringByReplacingBaseFileName:[self.baseFileName stringByAppendingString:suffix]];
}

- (NSString *)buy_stringByStrippingHTML
{
	NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
																			options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,  NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
																 documentAttributes:nil
																			  error:nil];
	
	
	return attributedString.string;
}

- (NSAttributedString *)buy_attributedStringWithLineSpacing:(CGFloat)spacing textAlignment:(NSTextAlignment)textAlignment
{
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
	NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
	style.lineSpacing = spacing;
	style.alignment = textAlignment;
	[attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
	return attributedString;
}

#pragma mark - Trim -
- (NSString*)buy_trim
{
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
