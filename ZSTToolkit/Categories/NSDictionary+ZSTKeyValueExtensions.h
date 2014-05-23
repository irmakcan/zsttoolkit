//
//  NSDictionary+ZSTKeyValueExtensions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZSTKeyValueExtensions)

#pragma mark - ObjC Primitive Helpers

- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)integerForKey:(id)key;

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)unsignedIntegerForKey:(id)key;

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(id)key;

#pragma mark - Primitive Helpers

- (float)floatForKey:(id)key defaultValue:(float)defaultValue;
- (float)floatForKey:(id)key;

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue;
- (double)doubleForKey:(id)key;

- (unsigned long long int)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)unsignedLongLongForKey:(id)key;

#pragma mark - Object Helpers

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(id)key;

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)arrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)dictionaryForKey:(id)key;

- (id)jsonObjectForKey:(id)key ofClass:(Class)klas;
- (NSArray *)jsonObjectArrayForKey:(id)key ofClass:(Class)klas;

#pragma mark - Basic Helpers

- (BOOL)hasKey:(id)key;
- (id)objectForKey:(id)key defaultObject:(id)defaultObject;

@end
