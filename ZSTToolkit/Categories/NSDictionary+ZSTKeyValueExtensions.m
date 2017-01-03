//
//  NSDictionary+ZSTKeyValueExtensions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "NSDictionary+ZSTKeyValueExtensions.h"
#import "ZSTJSONObjectInitializationProtocol.h"

@implementation NSDictionary (ZSTKeyValueExtensions)

#pragma mark - ObjC primitive helpers
- (NSInteger)zst_integerForKey:(id)key defaultValue:(NSInteger)defaultValue
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

- (NSInteger)zst_integerForKey:(id)key
{
  return [self zst_integerForKey:key defaultValue:0];
}

- (NSUInteger)zst_unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
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

- (NSUInteger)zst_unsignedIntegerForKey:(id)key
{
  return [self zst_unsignedIntegerForKey:key defaultValue:0];
}

- (BOOL)zst_boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
  id value = [self objectForKey:key];
  if ([value respondsToSelector:@selector(boolValue)]) {
    return [value boolValue];
  }
  return defaultValue;
}

- (BOOL)zst_boolForKey:(id)key
{
  return [self zst_boolForKey:key defaultValue:NO];
}

#pragma mark - Primitive helpers

- (float)zst_floatForKey:(id)key defaultValue:(float)defaultValue
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

- (float)zst_floatForKey:(id)key
{
  return [self zst_floatForKey:key defaultValue:0.0f];
}

- (double)zst_doubleForKey:(id)key defaultValue:(double)defaultValue
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

- (double)zst_doubleForKey:(id)key
{
  return [self zst_doubleForKey:key defaultValue:0.0];
}

- (unsigned long long int)zst_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long int)defaultValue
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

- (unsigned long long int)zst_unsignedLongLongForKey:(id)key
{
  return [self zst_unsignedLongLongForKey:key defaultValue:0ULL];
}

#pragma mark - Object helpers

- (NSString *)zst_stringForKey:(id)key defaultValue:(NSString *)defaultValue
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

- (NSString *)zst_stringForKey:(id)key
{
  return [self zst_stringForKey:key defaultValue:nil];
}

- (NSArray *)zst_arrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
  id array = [self objectForKey:key];
	if ([array isKindOfClass:[NSArray class]]) {
		return array;
  }
  return defaultValue;
}

- (NSArray *)zst_arrayForKey:(id)key
{
	return [self zst_arrayForKey:key defaultValue:nil];
}

- (NSDictionary *)zst_dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
  id dict = [self objectForKey:key];
	if ([dict isKindOfClass:[NSDictionary class]]) {
		return dict;
  }
  return defaultValue;
}

- (NSDictionary *)zst_dictionaryForKey:(id)key
{
	return [self zst_dictionaryForKey:key defaultValue:nil];
}

- (id)zst_jsonObjectForKey:(id)key ofClass:(Class)klas
{
  if (![klas conformsToProtocol:@protocol(ZSTJSONObjectInitializationProtocol)]) {
    @throw([NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                           NSStringFromClass(klas),
                                           NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]
                                 userInfo:nil]);
  }
  
  NSDictionary *json = [self zst_dictionaryForKey:key];
	if (json) {
    return [[klas alloc] initWithJSONDictionary:json];
  }
  return nil;
}

- (NSArray *)zst_jsonObjectArrayForKey:(id)key ofClass:(Class)klas
{
  if (![klas conformsToProtocol:@protocol(ZSTJSONObjectInitializationProtocol)]) {
    @throw([NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                           NSStringFromClass(klas),
                                           NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]
                                 userInfo:nil]);
  }
  
  NSMutableArray *objects = [NSMutableArray array];
  NSArray *jsonArray = [self zst_arrayForKey:key];
  for (NSDictionary *json in jsonArray) {
    [objects addObject:[[klas alloc] initWithJSONDictionary:json]];
  }
  return [objects copy];
}

#pragma mark - Basic helpers

- (id)zst_objectForKey:(id)key defaultObject:(id)defaultObject
{
  id object = [self objectForKey:key];
  if (object) {
    return object;
  }
  return defaultObject;
}

- (BOOL)zst_hasKey:(id)key
{
	return ([self objectForKey:key] != nil);
}

@end
