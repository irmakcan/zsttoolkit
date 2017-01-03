//
//  NSMutableDictionary+ZSTKeyValueExtensions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (ZSTKeyValueExtensions)

- (void)zst_setObjectIfNotNil:(nullable id)object forKey:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
