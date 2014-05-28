//
//  UIImage+ZSTCreationAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 28/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZSTCreationAdditions)

/**
 Returns 1x1 px sized image for the specified color.
 
 @param color The color for the image.
 
 @return 1x1 px image object for the specified color.
 */
+ (UIImage *)zst_imageWithColor:(UIColor *)color;

@end
