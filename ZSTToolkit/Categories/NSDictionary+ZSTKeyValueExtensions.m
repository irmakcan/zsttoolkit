//
//  NSDictionary+ZSTKeyValueExtensions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSDictionary+ZSTKeyValueExtensions.h"

@implementation NSDictionary (ZSTKeyValueExtensions)

#pragma mark - ObjC primitive helpers
- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(integerValue)]) {
        return [value integerValue];
    }
    return defaultValue;
}

- (NSInteger)integerForKey:(NSString *)key
{
    return [self integerForKey:key defaultValue:0];
}

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
{
	id value = [self objectForKey:key];
	if ([value respondsToSelector:@selector(unsignedIntegerValue)]) {
		return [value unsignedIntegerValue];
	}
    return defaultValue;
}

- (NSUInteger)unsignedIntegerForKey:(id)key
{
    return [self unsignedIntegerForKey:key defaultValue:0];
}

- (BOOL)boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(boolValue)]) {
        return [value boolValue];
    }
    return defaultValue;
}

- (BOOL)boolForKey:(id)key
{
    return [self boolForKey:key defaultValue:NO];
}

#pragma mark - Primitive helpers
- (int)intForKey:(id)key defaultValue:(int)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(intValue)]) {
        return [value intValue];
    }
    return defaultValue;
    
}

- (int)intForKey:(id)key
{
    return [self intForKey:key defaultValue:0];
}

- (float)floatForKey:(id)key defaultValue:(float)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(floatValue)]) {
        return [value floatValue];
    }
    return defaultValue;
}

- (float)floatForKey:(id)key
{
    return [self floatForKey:key defaultValue:0.0f];
}

- (double)doubleForKey:(id)key defaultValue:(double)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(doubleValue)]) {
        return [value doubleValue];
    }
    return defaultValue;
}

- (double)doubleForKey:(id)key
{
    return [self doubleForKey:key defaultValue:0.0];
}

- (unsigned int)unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(unsignedIntValue)]) {
        return [value unsignedIntValue];
    }
    return defaultValue;
    
}

- (unsigned int)unsignedIntForKey:(id)key
{
    return [self unsignedIntForKey:key defaultValue:0];
}

- (unsigned long long int)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue
{
    id value = [self objectForKey:key];
    if ([value respondsToSelector:@selector(unsignedLongLongValue)]) {
        return [value unsignedLongLongValue];
    }
    return defaultValue;
}

- (unsigned long long int)unsignedLongLongForKey:(id)key
{
    return [self unsignedLongLongForKey:key defaultValue:0ULL];
}

#pragma mark - Object helpers

- (NSString *)stringForKey:(id)key defaultValue:(NSString *)defaultValue
{
    id string = [self objectForKey:key];
    if ([string isKindOfClass:[NSString class]]) {
        return string;
    }
    if ([string respondsToSelector:@selector(stringValue)]) {
        return [string stringValue];
    }
    return defaultValue;
}

- (NSString *)stringForKey:(id)key
{
    return [self stringForKey:key defaultValue:nil];
}

- (NSArray *)arrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    id array = [self objectForKey:key];
	if ([array isKindOfClass:[NSArray class]]) {
		return array;
    }
    return defaultValue;
}

- (NSArray *)arrayForKey:(id)key
{
	return [self arrayForKey:key defaultValue:nil];
}

- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    id dict = [self objectForKey:key];
	if ([dict isKindOfClass:[NSDictionary class]]) {
		return dict;
    }
    return defaultValue;
}

- (NSDictionary *)dictionaryForKey:(id)key
{
	return [self dictionaryForKey:key defaultValue:nil];
}

//- (id)jsonObjectForKey:(id)key ofClass:(Class)class
//{
//    if (![class conformsToProtocol:@protocol(KMBJSONObjectInitializationProtocol)]) {
//        @throw([NSException exceptionWithName:NSInternalInconsistencyException
//                                       reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
//                                               NSStringFromClass(class),
//                                               NSStringFromProtocol(@protocol(KMBJSONObjectInitializationProtocol))]
//                                     userInfo:nil]);
//    }
//    
//    id dictionary = [self objectForKey:key];
//	if ([dictionary isKindOfClass:[NSDictionary class]]) {
//        return [[[class class] alloc] initWithJSONDictionary:dictionary];
//    }
//    return nil;
//}

#pragma mark - Basic helpers

- (id)objectForKey:(id)key defaultObject:(id)defaultObject
{
    id object = [self objectForKey:key];
    if (object) {
        return object;
    }
    return defaultObject;
}

- (BOOL)hasKey:(id)key
{
	return ([self objectForKey:key] != nil);
}

@end
