//
//  NSDictionary+ZSTKeyValueExtensions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSDictionary+ZSTKeyValueExtensions.h"
#import "ZSTJSONObjectInitializationProtocol.h"

@interface NSDictionary (ZSTKeyValueExtensionsPrivate)

- (NSString *)stringForKey:(id)key defaultValue:(nullable NSString *)defaultValue;
- (NSArray *)arrayForKey:(id)key defaultValue:(nullable NSArray *)defaultValue;
- (NSDictionary *)dictionaryForKey:(id)key defaultValue:(nullable NSDictionary *)defaultValue;

@end

@implementation NSDictionary (ZSTKeyValueExtensions)

#pragma mark - ObjC primitive helpers
- (NSInteger)integerForKey:(id)key defaultValue:(NSInteger)defaultValue
{
  id value = [self objectForKey:key];
  if ([value isKindOfClass:[NSString class]]) {
    NSInteger scanResult;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL success = [scanner scanInteger:&scanResult];
    
    if (success && [scanner isAtEnd]) {
      return scanResult;
    }
  } else if ([value respondsToSelector:@selector(integerValue)]) {
    return [value integerValue];
  }
  return defaultValue;
}

- (NSInteger)integerForKey:(id)key
{
  return [self integerForKey:key defaultValue:0];
}

- (NSUInteger)unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
{
	id value = [self objectForKey:key];
  
  if ([value isKindOfClass:[NSString class]]) {
    unsigned long long scanResult;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL success = [scanner scanUnsignedLongLong:&scanResult];
    
    if (success && [scanner isAtEnd]) {
      NSUInteger result;
      if (scanResult > NSUIntegerMax) {
        result = NSUIntegerMax;
      } else {
        result = (NSUInteger)scanResult;
      }
      return result;
    }
  } else if ([value respondsToSelector:@selector(unsignedIntegerValue)]) {
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

- (float)floatForKey:(id)key defaultValue:(float)defaultValue
{
  id value = [self objectForKey:key];
  if ([value isKindOfClass:[NSString class]]) {
    float scanResult;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL success = [scanner scanFloat:&scanResult];
    
    if (success && [scanner isAtEnd]) {
      return scanResult;
    }
  } else if ([value respondsToSelector:@selector(floatValue)]) {
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
  if ([value isKindOfClass:[NSString class]]) {
    double scanResult;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL success = [scanner scanDouble:&scanResult];
    
    if (success && [scanner isAtEnd]) {
      return scanResult;
    }
  } else if ([value respondsToSelector:@selector(doubleValue)]) {
    return [value doubleValue];
  }
  return defaultValue;
}

- (double)doubleForKey:(id)key
{
  return [self doubleForKey:key defaultValue:0.0];
}

- (unsigned long long int)unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue
{
  id value = [self objectForKey:key];
  
  if ([value isKindOfClass:[NSString class]]) {
    unsigned long long scanResult;
    NSScanner *scanner = [NSScanner scannerWithString:value];
    BOOL success = [scanner scanUnsignedLongLong:&scanResult];
    
    if (success && [scanner isAtEnd]) {
      return scanResult;
    }
  } else if ([value respondsToSelector:@selector(unsignedLongLongValue)]) {
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

- (id)jsonObjectForKey:(id)key ofClass:(Class)klas
{
  if (![klas conformsToProtocol:@protocol(ZSTJSONObjectInitializationProtocol)]) {
    @throw([NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                           NSStringFromClass(klas),
                                           NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]
                                 userInfo:nil]);
  }
  
  NSDictionary *json = [self dictionaryForKey:key];
	if (json) {
    return [[klas alloc] initWithJSONDictionary:json];
  }
  return nil;
}

- (NSArray *)jsonObjectArrayForKey:(id)key ofClass:(Class)klas
{
  if (![klas conformsToProtocol:@protocol(ZSTJSONObjectInitializationProtocol)]) {
    @throw([NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                           NSStringFromClass(klas),
                                           NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]
                                 userInfo:nil]);
  }
  
  NSMutableArray *objects = [NSMutableArray array];
  NSArray *jsonArray = [self arrayForKey:key];
  for (NSDictionary *json in jsonArray) {
    [objects addObject:[[klas alloc] initWithJSONDictionary:json]];
  }
  return [objects copy];
}

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
