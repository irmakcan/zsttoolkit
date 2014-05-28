//
//  UIImage+ZSTCreationAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 28/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "UIImage+ZSTCreationAdditions.h"

@implementation UIImage (ZSTCreationAdditions)

+ (UIImage *)zst_imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

@end
