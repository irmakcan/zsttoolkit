//
//  NSMutableAttributedString+ZSTAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZSTAdditions)

- (void)zst_appendString:(NSString *)string withAttributes:(nullable NSDictionary<NSString *, id> *)attributes;

@end

NS_ASSUME_NONNULL_END
