//
//  ZSTRGBSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ZSTRGB.h"

static const CGFloat ZSTRed = 101;
static const CGFloat ZSTGreen = 127;
static const CGFloat ZSTBlue = 143.f;
static const CGFloat ZSTAlpha = 0.7f;

SPEC_BEGIN(ZSTRGBSpec)

describe(@"ZSTRGB", ^{
  describe(@"ZSTRGB", ^{
    __block UIColor *color;
    
    beforeEach(^{
      color = ZSTRGB(ZSTRed, ZSTGreen, ZSTBlue);
    });
    
    it(@"should have correct RGBA values", ^{
      CGFloat red = 0.f;
      CGFloat green = 0.f;
      CGFloat blue = 0.f;
      CGFloat alpha = 0.f;
      [color getRed:&red green:&green blue:&blue alpha:&alpha];
      [[theValue(red) should] equal:theValue(ZSTRed/255.f)];
      [[theValue(blue) should] equal:theValue(ZSTBlue/255.f)];
      [[theValue(green) should] equal:theValue(ZSTGreen/255.f)];
      [[theValue(alpha) should] equal:theValue(1.f)];
    });
  });
  
  describe(@"ZSTRGBA", ^{
    __block UIColor *color;
    
    beforeEach(^{
      color = ZSTRGBA(ZSTRed, ZSTGreen, ZSTBlue, ZSTAlpha);
    });
    
    it(@"should have correct RGBA values", ^{
      CGFloat red = 0.f;
      CGFloat green = 0.f;
      CGFloat blue = 0.f;
      CGFloat alpha = 0.f;
      [color getRed:&red green:&green blue:&blue alpha:&alpha];
      [[theValue(red) should] equal:theValue(ZSTRed/255.f)];
      [[theValue(blue) should] equal:theValue(ZSTBlue/255.f)];
      [[theValue(green) should] equal:theValue(ZSTGreen/255.f)];
      [[theValue(alpha) should] equal:theValue(ZSTAlpha)];
    });
  });
});

SPEC_END
