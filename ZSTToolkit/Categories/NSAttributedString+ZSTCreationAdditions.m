//
//  NSAttributedString+ZSTCreationAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSAttributedString+ZSTCreationAdditions.h"
#import "NSMutableAttributedString+ZSTAdditions.h"

@implementation NSAttributedString (ZSTCreationAdditions)

+ (NSAttributedString *)zst_attributedStringFromTextToAttributesMappings:(NSArray *)textToAttributesMappings
{
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];

  for (NSDictionary *textToAttributesMapping in textToAttributesMappings) {
    if (![textToAttributesMapping isKindOfClass:[NSDictionary class]]) {
      @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                     reason:[NSString stringWithFormat:@"Mappings should be dictionary, got %@", NSStringFromClass([textToAttributesMapping class])]
                                   userInfo:nil];
    }
    [textToAttributesMapping enumerateKeysAndObjectsUsingBlock:^(NSString *text, NSDictionary *attributes, BOOL *stop) {
      if (![text isKindOfClass:[NSString class]]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Mappings key should be string, got %@", NSStringFromClass([text class])]
                                     userInfo:nil];
      }
      if (![attributes isKindOfClass:[NSDictionary class]]) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Mappings attributes should be kind of dictionary, got %@", NSStringFromClass([attributes class])]
                                     userInfo:nil];
      }
      [attributedString zst_appendString:text withAttributes:attributes];
    }];
  }

  return attributedString;
}

@end
