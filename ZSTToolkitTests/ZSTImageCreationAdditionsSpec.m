//
//  ZSTImageCreationAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 28/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UIImage+ZSTCreationAdditions.h"

@interface UIImage (ZSTSpzsf)

- (UIColor *)zst_pixelColorAtX:(NSInteger)x andY:(NSInteger)y;

@end

@implementation UIImage (ZSTSpzsf)

- (UIColor *)zst_pixelColorAtX:(NSInteger)x andY:(NSInteger)y
{
  // First get the image into your data buffer
  CGImageRef imageRef = [self CGImage];
  NSUInteger width = CGImageGetWidth(imageRef);
  NSUInteger height = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * width;
  NSUInteger bitsPerComponent = 8;
  CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                               bitsPerComponent, bytesPerRow, colorSpace,
                                               kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGColorSpaceRelease(colorSpace);
  
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  CGContextRelease(context);
  
  unsigned long byteIndex = (bytesPerRow * y) + x * bytesPerPixel;
  
  CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
  CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
  CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
  CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
  
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
  return color;
}

@end

SPEC_BEGIN(ZSTImageCreationAdditionsSpec)

describe(@"ZSTImageCreationAdditions", ^{
  describe(@"+imageWithColor:", ^{
    __block UIImage *image;
    __block UIColor *color;
    beforeEach(^{
      color = [UIColor redColor];
      image = [UIImage zst_imageWithColor:color];
    });
    
    it(@"should return 1x1 sized image", ^{
      BOOL equalSize = CGSizeEqualToSize(image.size, CGSizeMake(1.f, 1.f));
      [[theValue(equalSize) should] beYes];
    });

    it(@"should have correct color", ^{
      UIColor *pixelColor = [image zst_pixelColorAtX:0 andY:0];
      [[pixelColor should] equal:[UIColor redColor]];
    });
  });
});

SPEC_END
