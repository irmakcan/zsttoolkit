//
//  NSException+ZSTAbstractClassAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const ZSTAbstractClassMethodException;

@interface NSException (ZSTAbstractClassAdditions)

+ (NSException *)zst_abstractMethodExceptionWithClass:(Class)klas method:(SEL)method;

@end
