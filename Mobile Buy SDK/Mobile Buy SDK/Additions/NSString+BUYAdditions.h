//
//  NSString+BUYAdditions.h
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

@import UIKit;

@interface NSString (BUYAdditions)

/**
 * Return the current set of acronyms used when generating camel-case names;
 */
+ (NSArray *)buy_acronymStrings;

/**
 * override built-in acronyms (which only contain "URL")
 */
+ (void)buy_setAcronymStrings:(NSArray *)strings;

/**
 * Covert a snake-case string into a camel-case string
 * Automatically UPPER-cases any tokens found in the current set of acronyms.
 * @return a camel-case string
 */
- (NSString *)buy_camelCaseString;

/**
 * Convert a camel-case string into a snake-case string
 * @return a snake-case string
 */
- (NSString *)buy_snakeCaseString;

/**
 * Return a string tokenized according to a camel-case pattern.
 */
- (NSArray *)buy_camelCaseTokens;

/**
 * Return an array of string matches in the receiver for the given regular expression.
 */
- (NSArray *)buy_matchesForRegularExpression:(NSRegularExpression *)regex;

/**
 * A convenience to return all matches in the receiver for the given regex pattern.
 */
- (NSArray *)buy_matchesForPattern:(NSString *)pattern;

/**
 * As `-buy_matchesForRegularExpression`, but return only the first match.
 */
- (NSString *)buy_firstMatchForRegularExpression:(NSRegularExpression *)regex;

/**
 * As `-buy_matchesForPattern`, but return only the first match.
 */
- (NSString *)buy_firstMatchForPattern:(NSString *)pattern;

/**
 * Return a new string which reverses the UTF-8 characters of the receiver.
 */
- (NSString *)buy_reversedString;

/**
 * @return the directory part of the file name, with no ending slash.
 */
@property (nonatomic, readonly) NSString *directory;

/**
 * @return the file name without the extensions.
 */
@property (nonatomic, readonly) NSString *baseFileName;

/**
 * @return a new string with updated directory path.
 */
- (NSString *)buy_stringByReplacingDirectory:(NSString *)newDirectory;

/**
 * @return a new string replacing the base part of the name, preserving existing directory and extension.
 */
- (NSString *)buy_stringByReplacingBaseFileName:(NSString *)newName;

/**
 * @return a new string with suffix appended to base file name, preserving existing directory and extension.
 */

- (NSString *)buy_stringByAppendingBaseFileNameSuffix:(NSString *)suffix;

/**
 * @return a new string with HTML tags stripped from the receiver.
 */

- (NSString *)buy_stringByStrippingHTML;

/**
 * @return a new attributed string with the specified attributes
 */

- (NSAttributedString *)buy_attributedStringWithLineSpacing:(CGFloat)spacing textAlignment:(NSTextAlignment)textAlignment;

/**
 *  Equivalent to `[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]`
 *
 *  @return NSString without white space and newline characters
 */
- (NSString*)buy_trim;

@end
