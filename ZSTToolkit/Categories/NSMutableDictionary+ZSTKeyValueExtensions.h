//
//  NSMutableDictionary+ZSTKeyValueExtensions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ZSTKeyValueExtensions)

- (void)setObjectIfNotNil:(id)object forKey:(id<NSCopying>)key;

@end
