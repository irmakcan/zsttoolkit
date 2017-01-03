//
//  NSDictionary+ZSTKeyValueExtensions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZSTKeyValueExtensions)

#pragma mark - ObjC Primitive Helpers

- (NSInteger)zst_integerForKey:(id)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)zst_integerForKey:(id)key;

- (NSUInteger)zst_unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)zst_unsignedIntegerForKey:(id)key;

- (BOOL)zst_boolForKey:(id)key defaultValue:(BOOL)defaultValue;
- (BOOL)zst_boolForKey:(id)key;

#pragma mark - Primitive Helpers

- (float)zst_floatForKey:(id)key defaultValue:(float)defaultValue;
- (float)zst_floatForKey:(id)key;

- (double)zst_doubleForKey:(id)key defaultValue:(double)defaultValue;
- (double)zst_doubleForKey:(id)key;

- (unsigned long long int)zst_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)zst_unsignedLongLongForKey:(id)key;

#pragma mark - Object Helpers

- (NSString *)zst_stringForKey:(id)key defaultValue:(nullable NSString *)defaultValue;
- (NSString *)zst_stringForKey:(id)key;

- (NSArray *)zst_arrayForKey:(id)key defaultValue:(nullable NSArray *)defaultValue;
- (NSArray *)zst_arrayForKey:(id)key;

- (NSDictionary *)zst_dictionaryForKey:(id)key defaultValue:(nullable NSDictionary *)defaultValue;
- (NSDictionary *)zst_dictionaryForKey:(id)key;

- (nullable id)zst_jsonObjectForKey:(id)key ofClass:(Class)klas;
- (NSArray *)zst_jsonObjectArrayForKey:(id)key ofClass:(Class)klas;

#pragma mark - Basic Helpers

- (BOOL)zst_hasKey:(id)key;
- (id)zst_objectForKey:(id)key defaultObject:(nullable id)defaultObject;

@end

NS_ASSUME_NONNULL_END
