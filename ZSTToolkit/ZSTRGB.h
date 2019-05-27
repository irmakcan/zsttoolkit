//
//  ZSTRGB.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NS_INLINE UIColor * ZSTRGB(CGFloat r, CGFloat g, CGFloat b) {
  return [UIColor colorWithRed:((CGFloat)r)/255.f green:((CGFloat)g)/255.f blue:((CGFloat)b)/255.f alpha:1.f];
}

NS_INLINE UIColor * ZSTRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
  return [UIColor colorWithRed:((CGFloat)r)/255.f green:((CGFloat)g)/255.f blue:((CGFloat)b)/255.f alpha:(a)];
}

NS_ASSUME_NONNULL_END
