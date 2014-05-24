//
//  NSMutableAttributedString+ZSTAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSMutableAttributedString+ZSTAdditions.h"

@implementation NSMutableAttributedString (ZSTAdditions)

- (void)zst_appendString:(NSString *)string withAttributes:(NSDictionary *)attributes
{
  NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
  [self appendAttributedString:attributedString];
}

@end
