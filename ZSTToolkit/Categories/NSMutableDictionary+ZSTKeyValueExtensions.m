//
//  NSMutableDictionary+ZSTKeyValueExtensions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSMutableDictionary+ZSTKeyValueExtensions.h"

@implementation NSMutableDictionary (ZSTKeyValueExtensions)

- (void)setObjectIfNotNil:(id)object forKey:(id<NSCopying>)key
{
  if (object) {
    [self setObject:object forKey:key];
  }
}

@end
