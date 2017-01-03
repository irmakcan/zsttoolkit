//
//  NSAttributedString+ZSTCreationAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (ZSTCreationAdditions)

/**
 Creates a new AttributedString from given text to attributes mappings by appending them in order.
 
 Mapping Example:
 @code @[
  @{"Hello, " : @{NSFontAttributeName: font},
  @{"World!"  : @{NSFontAttributeName: boldFont}}
 ] @endcode
 
 @param textToAttributesMappings An array which includes texts and attributes needed to generate attributed string.
 
 @return An NSAttributedString object consisting of the strings with attributes appended with each other.
 */
+ (NSAttributedString *)zst_attributedStringFromTextToAttributesMappings:(NSArray<NSDictionary<NSString *, NSDictionary<NSString *, id> *> *> *)textToAttributesMappings;

@end

NS_ASSUME_NONNULL_END
