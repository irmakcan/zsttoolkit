//
//  ZSTRGB.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZSTRGB(r, g, b) [UIColor colorWithRed:((CGFloat)r)/255.f green:((CGFloat)g)/255.f blue:((CGFloat)b)/255.f alpha:1.f]
#define ZSTRGBA(r, g, b, a) [UIColor colorWithRed:((CGFloat)r)/255.f green:((CGFloat)g)/255.f blue:((CGFloat)b)/255.f alpha:(a)]
