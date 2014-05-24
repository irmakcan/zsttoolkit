//
//  ZSTMutableAttributedStringAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSMutableAttributedString+ZSTAdditions.h"


SPEC_BEGIN(ZSTMutableAttributedStringAdditionsSpec)

describe(@"ZSTMutableAttributedStringAdditions", ^{
  describe(@"appendString:withAttributes", ^{
    __block NSMutableAttributedString *attributedString;
    
    beforeEach(^{
      attributedString = [[NSMutableAttributedString alloc] init];
    });
    
    it(@"should append string", ^{
      NSString *string = @"aString";
      NSDictionary *attributes = @{};
      
      [attributedString zst_appendString:string withAttributes:attributes];
      
      BOOL isAppended = [attributedString.string hasSuffix:string];
      [[theValue(isAppended) should] beTrue];
    });
    
    it(@"should have right attributes for appended string", ^{
      NSString *string = @"aString";
      UIFont *font = [UIFont fontWithName:@"ArialMT" size:17];
      NSDictionary *attributes = @{NSFontAttributeName: font};
      
      [attributedString zst_appendString:string withAttributes:attributes];
      NSDictionary *charAttributes = [attributedString attributesAtIndex:attributedString.length-1 effectiveRange:nil];
      
      [[charAttributes[NSFontAttributeName] should] equal:font];
    });
  });
});

SPEC_END
