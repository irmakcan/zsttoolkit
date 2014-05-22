//
//  NSDictionary+ZSTKeyValueExtensions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ZSTKeyValueExtensions)

// ObjC primitive helpers

- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue;
- (NSInteger)integerForKey:(NSString *)key;

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue;
- (NSUInteger)unsignedIntegerForKey:(id)key;

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue;
- (BOOL)boolForKey:(id)key;

// Primitive helpers

- (int)intForKey:(id)key defaultValue:(int)defaultValue;
- (int)intForKey:(id)key;

- (float)floatForKey:(id)key defaultValue:(float)defaultValue;
- (float)floatForKey:(id)key;

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue;
- (double)doubleForKey:(id)key;

- (unsigned int)unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue;
- (unsigned int)unsignedIntForKey:(id)key;

- (unsigned long long int)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue;
- (unsigned long long int)unsignedLongLongForKey:(id)key;

// Object helpers

//- (id)jsonObjectForKey:(id)key ofClass:(Class)class;

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue;
- (NSString *)stringForKey:(id)key;

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue;
- (NSArray *)arrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;
- (NSDictionary *)dictionaryForKey:(id)key;

// Basic helpers

- (BOOL)hasKey:(id)key;
- (id)objectForKey:(id)key defaultObject:(id)defaultObject;

@end
