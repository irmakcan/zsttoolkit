//
//  ZSTAttributedStringCreationAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSAttributedString+ZSTCreationAdditions.h"


SPEC_BEGIN(ZSTAttributedStringCreationAdditionsSpec)

describe(@"ZSTAttributedStringCreationAdditions", ^{
  
//  it(@"should return empty attributed string if mappings array is nil", ^{
//    NSAttributedString *attributedString = [NSAttributedString zst_attributedStringFromTextToAttributesMappings:nil];
//    [[attributedString shouldNot] beNil];
//  });

  it(@"should return empty attributed string if mappings array is empty", ^{
    NSAttributedString *attributedString = [NSAttributedString zst_attributedStringFromTextToAttributesMappings:@[]];
    [[attributedString shouldNot] beNil];
  });
  
  it(@"should return correct attributed string for mappings", ^{
    UIFont *helloFont = [UIFont systemFontOfSize:15];
    UIFont *worldFont = [UIFont boldSystemFontOfSize:17];
    
    NSArray *mappings = @[
                          @{@"Hello, ": @{NSFontAttributeName: helloFont}},
                          @{@"World!": @{NSFontAttributeName: worldFont}},
                          ];
    NSAttributedString *attributedString = [NSAttributedString zst_attributedStringFromTextToAttributesMappings:mappings];
    
    NSDictionary *helloCharAttributes = [attributedString attributesAtIndex:0 effectiveRange:nil];
    NSDictionary *worldCharAttributes = [attributedString attributesAtIndex:attributedString.length-1 effectiveRange:nil];
    
    [[helloCharAttributes[NSFontAttributeName] should] equal:helloFont];
    [[worldCharAttributes[NSFontAttributeName] should] equal:worldFont];
  });
  
  describe(@"Exceptions", ^{
    __block NSMutableArray *mappings;
    beforeEach(^{
      mappings = [@[ @{@"Hello, ": @{NSFontAttributeName: [UIFont systemFontOfSize:12]}} ] mutableCopy];
    });
    
    it(@"should throw exception if mappings are not a kind of dictionary class", ^{
      NSArray *invalidObject = @[@"World"];
      [mappings addObject:invalidObject]; // Invalid object
      [[theBlock(^{
        [NSAttributedString zst_attributedStringFromTextToAttributesMappings:mappings];
      }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Mappings should be dictionary, got %@", NSStringFromClass([invalidObject class])]];
    });
    
    it(@"should throw exception if mappings key is not a kind of string class", ^{
      NSNumber *key = @(124);
      [mappings addObject:@{key: @{NSFontAttributeName: [UIFont systemFontOfSize:12]}}]; // Invalid key
      [[theBlock(^{
        [NSAttributedString zst_attributedStringFromTextToAttributesMappings:mappings];
      }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Mappings key should be string, got %@", NSStringFromClass([key class])]];
    });
    
    it(@"should throw exception if mappings value is not a kind of dictionary class", ^{
      NSArray *attributes = @[];
      [mappings addObject:@{@"World!": attributes}]; // Invalid attributes
      [[theBlock(^{
        [NSAttributedString zst_attributedStringFromTextToAttributesMappings:mappings];
      }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Mappings attributes should be kind of dictionary, got %@", NSStringFromClass([attributes class])]];
    });
  });
});

SPEC_END
