//
//  NSException+ZSTAbstractClassAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSException+ZSTAbstractClassAdditions.h"

NSString * const ZSTAbstractClassMethodException = @"ZSTAbstractClassMethodException";

@implementation NSException (ZSTAbstractClassAdditions)

+ (NSException *)zst_abstractMethodExceptionWithClass:(Class)klas method:(SEL)method
{
  return [NSException exceptionWithName:ZSTAbstractClassMethodException
                                 reason:[NSString stringWithFormat:@"%@ should be implemented in subclass %@", NSStringFromSelector(method), NSStringFromClass(klas)]
                               userInfo:nil];
}

@end
