//
//  ZSTDictionaryKeyValueExtensionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 22/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi.h>
#import "NSDictionary+ZSTKeyValueExtensions.h"
#import "ZSTJSONObjectInitializationProtocol.h"

@interface ZSTTestJSONObject : NSObject <ZSTJSONObjectInitializationProtocol>

@end

@implementation ZSTTestJSONObject

- (id)initWithJSONDictionary:(NSDictionary *)json
{
  self = [super init];
  return self;
}

@end

SPEC_BEGIN(ZSTDictionaryKeyValueExtensionsSpec)

describe(@"NSDictionary", ^{
  __block NSString *key;
  __block id object;
  __block NSDictionary *dictWithObject;
  __block NSDictionary *emptyDict;
  
  beforeEach(^{
    key = @"aKey";
    object = @"anObject";
    dictWithObject = @{key: object};
    emptyDict = @{};
  });
  
  context(@"ObjC primitive helpers", ^{
    
    describe(@"NSInteger", ^{
      describe(@"integerForKey:", ^{
        it(@"should call integerForKey:defaultValue: with defaultValue set to 0", ^{
          NSInteger returnValue = [dictWithObject zst_integerForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_integerForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject zst_integerForKey:key];
        });
      });
      
      describe(@"integerForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          NSInteger defaultValue = 77;
          NSInteger result = [emptyDict zst_integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to integerValue", ^{
          NSInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          NSInteger result = [dictWithObject zst_integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the integerValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSInteger returnValue = 44;
          
          [mockObject stub:@selector(integerValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          NSInteger result = [dictWithObject zst_integerForKey:key defaultValue:-1];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
        
        it(@"should return the default value if NSString is not converted to a valid integer", ^{
          NSInteger defaultValue = 33;
          NSInteger result = [dictWithObject zst_integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return NSIntegerMin if NSString value is less than NSIntegerMin", ^{
          dictWithObject = @{key: [[NSNumber numberWithLongLong:LLONG_MIN] stringValue]};
          NSInteger result = [dictWithObject zst_integerForKey:key defaultValue:33];
          [[theValue(result) should] equal:theValue(NSIntegerMin)];
        });
        
        it(@"should return NSIntegerMax if NSString value is larger than NSIntegerMax", ^{
          dictWithObject = @{key: [[NSNumber numberWithLongLong:LLONG_MAX] stringValue]};
          NSInteger result = [dictWithObject zst_integerForKey:key defaultValue:33];
          [[theValue(result) should] equal:theValue(NSIntegerMax)];
        });
      });
    });
    
    describe(@"NSUInteger", ^{
      describe(@"unsignedIntegerForKey:", ^{
        it(@"should call unsignedIntegerForKey:defaultValue: with defaultValue set to 0", ^{
          NSUInteger returnValue = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_unsignedIntegerForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject zst_unsignedIntegerForKey:key];
        });
      });
      
      describe(@"unsignedIntegerForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          NSUInteger defaultValue = 77;
          NSUInteger result = [emptyDict zst_unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to unsignedIntegerValue", ^{
          NSUInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          NSUInteger result = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the unsignedIntegerValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSUInteger returnValue = 44;
          
          [mockObject stub:@selector(unsignedIntegerValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          NSUInteger result = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:NSUIntegerMax];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
        
        it(@"should convert NSString value to NSUInteger", ^{
          NSString *value = [NSString stringWithFormat:@"%lu", NSUIntegerMax];
          dictWithObject = @{key: value};
          
          NSUInteger result = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(NSUIntegerMax)];
        });
        
        it(@"should return default value if NSString cannot completely converted to NSUInteger", ^{
          NSString *value = @"1234,567,890";
          dictWithObject = @{key: value};
          NSUInteger defaultValue = 555;
          
          NSUInteger result = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return NSUIntegerMax if NSString value is larger", ^{
          NSString *value = @"18446744073709551618";
          dictWithObject = @{key: value};
          
          NSUInteger result = [dictWithObject zst_unsignedIntegerForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(NSUIntegerMax)];
        });
      });
    });
    
    describe(@"BOOL", ^{
      describe(@"boolForKey:", ^{
        it(@"should call boolForKey:defaultValue: with defaultValue set to NO", ^{
          BOOL returnValue = [dictWithObject zst_boolForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_boolForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(NO)];
          [dictWithObject zst_boolForKey:key];
        });
      });
      
      describe(@"boolForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          BOOL defaultValue = YES;
          BOOL result = [emptyDict zst_boolForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to boolValue", ^{
          BOOL defaultValue = YES;
          dictWithObject = @{key: [KWMock mock]};
          BOOL result = [dictWithObject zst_boolForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the boolValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          BOOL returnValue = YES;
          
          [mockObject stub:@selector(boolValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          BOOL result = [dictWithObject zst_boolForKey:key defaultValue:NO];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
      });
    });
    
  });
  
  context(@"C primitive helpers", ^{
    
    describe(@"float", ^{
      describe(@"floatForKey:", ^{
        it(@"should call floatForKey:defaultValue: with defaultValue set to 0.f", ^{
          float returnValue = [dictWithObject zst_floatForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_floatForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject zst_floatForKey:key];
        });
      });
      
      describe(@"floatForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          float defaultValue = 77.f;
          float result = [emptyDict zst_floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to floatValue", ^{
          float defaultValue = 33.f;
          dictWithObject = @{key: [KWMock mock]};
          float result = [dictWithObject zst_floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the floatValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          float returnValue = 44.f;
          
          [mockObject stub:@selector(floatValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          float result = [dictWithObject zst_floatForKey:key defaultValue:-1.f];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should return the default value if NSString is not converted to a valid float", ^{
          float defaultValue = 33.f;
          float result = [dictWithObject zst_floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return 0.f if NSString value has more precision than FLT_MIN (Underflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:DBL_MIN] stringValue]};
          float result = [dictWithObject zst_floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(0.f)];
        });

        it(@"should return HUGE_VAL if NSString value is larger than FLT_MAX (Overflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:DBL_MAX] stringValue]};
          float result = [dictWithObject zst_floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(HUGE_VAL)];
        });
        
        it(@"should return -HUGE_VAL if NSString value is less than -FLT_MAX (Overflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:-DBL_MAX] stringValue]};
          float result = [dictWithObject zst_floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(-HUGE_VAL)];
        });
        
        it(@"should return correct float value of dot seperated NSString", ^{
          float value = 123.25f;
          dictWithObject = @{key: [[NSNumber numberWithFloat:value] stringValue]};
          float result = [dictWithObject zst_floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(value)];
        });
      });
    });

    describe(@"double", ^{
      describe(@"doubleForKey:", ^{
        it(@"should call doubleForKey:defaultValue: with defaultValue set to 0.0", ^{
          double returnValue = [dictWithObject zst_doubleForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_doubleForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject zst_doubleForKey:key];
        });
      });
      
      describe(@"doubleForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          double defaultValue = 77.0;
          double result = [emptyDict zst_doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to doubleValue", ^{
          double defaultValue = 33.0;
          dictWithObject = @{key: [KWMock mock]};
          double result = [dictWithObject zst_doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the doubleValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          double returnValue = 44.0;
          
          [mockObject stub:@selector(doubleValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          double result = [dictWithObject zst_doubleForKey:key defaultValue:-1.0];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should return the default value if NSString is not converted to a valid double", ^{
          double defaultValue = 33.0;
          double result = [dictWithObject zst_doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return 0.0 if NSString value has more precision than DBL_MIN (Underflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", LDBL_MIN]};
          double result = [dictWithObject zst_doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(0.0)];
        });

        it(@"should return HUGE_VAL if NSString value is larger than DBL_MAX (Overflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", LDBL_MAX]};
          double result = [dictWithObject zst_doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(HUGE_VAL)];
        });

        it(@"should return -HUGE_VAL if NSString value is less than -DBL_MAX (Overflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", -LDBL_MAX]};
          double result = [dictWithObject zst_doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(-HUGE_VAL)];
        });

        it(@"should return correct double value of dot seperated NSString", ^{
          double value = 123.25;
          dictWithObject = @{key: [[NSNumber numberWithDouble:value] stringValue]};
          double result = [dictWithObject zst_doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(value)];
        });
      });
    });

    describe(@"unsigned long long", ^{
      describe(@"unsignedLongLongForKey:", ^{
        it(@"should call unsignedLongLongForKey:defaultValue: with defaultValue set to 0", ^{
          unsigned long long returnValue = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(zst_unsignedLongLongForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject zst_unsignedLongLongForKey:key];
        });
      });
      
      describe(@"unsignedLongLongForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          unsigned long long defaultValue = 77;
          unsigned long long result = [emptyDict zst_unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to unsignedLongLongValue", ^{
          NSUInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          unsigned long long result = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the unsignedLongLongValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSUInteger returnValue = 44;
          
          [mockObject stub:@selector(unsignedLongLongValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          unsigned long long result = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:ULONG_LONG_MAX];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should convert NSString value to unsigned long long", ^{
          NSString *value = [[NSNumber numberWithUnsignedLongLong:ULONG_LONG_MAX] stringValue];
          dictWithObject = @{key: value};
          
          unsigned long long result = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(ULONG_LONG_MAX)];
        });

        it(@"should return default value if NSString cannot completely converted to unsigned long long", ^{
          NSString *value = @"1234,567,890";
          dictWithObject = @{key: value};
          NSUInteger defaultValue = 555;
          
          unsigned long long result = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return ULONG_LONG_MAX if NSString value is larger", ^{
          NSString *value = [[NSNumber numberWithUnsignedLongLong:ULONG_LONG_MAX] stringValue];
          dictWithObject = @{key: value};
          
          unsigned long long result = [dictWithObject zst_unsignedLongLongForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(ULONG_LONG_MAX)];
        });
      });
    });
  });
  
  context(@"Object helpers", ^{
    
    describe(@"string helpers", ^{
      describe(@"stringForKey:", ^{
        it(@"should call stringForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject zst_stringForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(zst_stringForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject zst_stringForKey:key];
        });
      });
      
      describe(@"stringForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          NSString *defaultString = @"defaultObj";
          id result = [emptyDict zst_stringForKey:key defaultValue:defaultString];
          [[result should] equal:defaultString];
        });
        
        it(@"should return the default value if the object is not a string or responds to stringValue", ^{
          NSString *defaultString = @"defaultObj";
          dictWithObject = @{key: [KWMock mock]};
          id result = [dictWithObject zst_stringForKey:key defaultValue:defaultString];
          [[result should] equal:defaultString];
        });
        
        it(@"should return the object if it is a string", ^{
          NSString *string = @"string";
          dictWithObject = @{key: string};
          
          id result = [dictWithObject zst_stringForKey:key defaultValue:nil];
          [[result should] equal:string];
        });
        
        it(@"should return the stringValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSString *mockString = @"mockString";
          
          [mockObject stub:@selector(stringValue) andReturn:mockString];
          dictWithObject = @{key: mockObject};
          
          id result = [dictWithObject zst_stringForKey:key defaultValue:nil];
          [[result should] equal:mockString];
        });
      });
    });
    
    describe(@"array helpers", ^{
      describe(@"arrayForKey:", ^{
        it(@"should call arrayForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject zst_arrayForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(zst_arrayForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject zst_arrayForKey:key];
        });
      });
      
      describe(@"arrayForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          id defaultObject = @[];
          id result = [emptyDict zst_arrayForKey:key defaultValue:defaultObject];
          [[result should] equal:defaultObject];
        });
        
        it(@"should return the default value if the value is not an array", ^{
          id defaultObject = @[];
          dictWithObject = @{key: @"nonArrayObject"};
          id result = [dictWithObject zst_arrayForKey:key defaultValue:defaultObject];
          [[result should] equal:defaultObject];
        });
        
        it(@"should return the object if it is an array", ^{
          NSArray *array = @[];
          dictWithObject = @{key: array};
          
          id result = [dictWithObject zst_arrayForKey:key defaultValue:nil];
          [[result should] equal:array];
        });
      });
    });
    
    describe(@"dictionary helpers", ^{
      describe(@"dictionaryForKey:", ^{
        it(@"should call dictionaryForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject zst_dictionaryForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(zst_dictionaryForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject zst_dictionaryForKey:key];
        });
      });
      
      describe(@"dictionaryForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          NSDictionary *defaultDictionary = @{};
          id result = [emptyDict zst_dictionaryForKey:key defaultValue:defaultDictionary];
          [[result should] equal:defaultDictionary];
        });
        
        it(@"should return the default value if the value is not a dictionary", ^{
          NSDictionary *defaultDictionary = @{};
          dictWithObject = @{key: @"nonDictionartObject"};
          id result = [dictWithObject zst_dictionaryForKey:key defaultValue:defaultDictionary];
          [[result should] equal:defaultDictionary];
        });
        
        it(@"should return the object if it is a dictionary", ^{
          NSDictionary *dict = @{};
          dictWithObject = @{key: dict};
          
          id result = [dictWithObject zst_dictionaryForKey:key defaultValue:nil];
          [[result should] equal:dict];
        });
      });
    });
    
    describe(@"JSON object helpers", ^{
      describe(@"jsonObjectForKey:ofClass:", ^{
        __block Class mockJsonClass;
        beforeEach(^{
          mockJsonClass = [ZSTTestJSONObject class];
        });
        
        it(@"should throw an exception if class not conforms to ZSTJSONObjectInitializationProtocol", ^{
          [[theBlock(^{
            [emptyDict zst_jsonObjectForKey:key ofClass:[KWMock class]];
          }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                                                            NSStringFromClass([KWMock class]),
                                                                            NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]];
        });

        it(@"should return nil if the key does not exist", ^{
          id result = [emptyDict zst_jsonObjectForKey:key ofClass:mockJsonClass];
          [[result should] beNil];
        });

        it(@"should return nil if the object is not a dictionary object", ^{
          dictWithObject = @{key: @"nonDictionaryObject"};
          id result = [dictWithObject zst_jsonObjectForKey:key ofClass:mockJsonClass];
          [[result should] beNil];
        });

        it(@"should return instance of the given class if the object is a dictionary", ^{
          dictWithObject = @{key: @{}};
          id result = [dictWithObject zst_jsonObjectForKey:key ofClass:mockJsonClass];
          [[result should] beKindOfClass:mockJsonClass];
        });
      });
      
      describe(@"jsonObjectArrayForKey:ofClass:", ^{
        __block Class mockJsonClass;
        beforeEach(^{
          mockJsonClass = [ZSTTestJSONObject class];
        });
        
        it(@"should throw an exception if class not conforms to ZSTJSONObjectInitializationProtocol", ^{
          [[theBlock(^{
            [emptyDict zst_jsonObjectArrayForKey:key ofClass:[KWMock class]];
          }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                                                            NSStringFromClass([KWMock class]),
                                                                            NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]];
        });
        
        it(@"should return empty array if the key does not exist", ^{
          NSArray *objects = [emptyDict zst_jsonObjectArrayForKey:key ofClass:mockJsonClass];
          [[objects should] beKindOfClass:[NSArray class]];
          [[theValue(objects.count) should] beZero];
        });

        it(@"should return empty array if the value is not a dictionary object", ^{
          dictWithObject = @{key: @"nonDictionaryObject"};
          NSArray *objects = [dictWithObject zst_jsonObjectArrayForKey:key ofClass:mockJsonClass];
          [[objects should] beKindOfClass:[NSArray class]];
          [[theValue(objects.count) should] beZero];
        });

        it(@"should return non empty array of the given class if the object is a dictionary", ^{
          dictWithObject = @{key: @[@{}, @{}]};
          NSArray *objects = [dictWithObject zst_jsonObjectArrayForKey:key ofClass:mockJsonClass];
          [[objects should] beKindOfClass:[NSArray class]];
          [[theValue(objects.count) shouldNot] beZero];
          
          [[[objects firstObject] should] beKindOfClass:mockJsonClass];
        });
      });
    });
  });
  
  context(@"Other helpers", ^{
    
    describe(@"objectForKey:defaultObject:", ^{
      it(@"should return the object if the key exists", ^{
        id result = [dictWithObject zst_objectForKey:key defaultObject:@"anotherObject"];
        [[result should] equal:@"anObject"];
      });
      
      it(@"should return the defaultValue if there is no key", ^{
        id anotherObject = @"anotherObject";
        id result = [emptyDict zst_objectForKey:key defaultObject:anotherObject];
        [[result should] equal:anotherObject];
      });
    });
    
    describe(@"hasKey:", ^{
      it(@"should return YES when there is a key", ^{
        BOOL result = [dictWithObject zst_hasKey:key];
        [[theValue(result) should] beTrue];
      });
      
      it(@"should return NO when there is no associated key", ^{
        BOOL result = [emptyDict zst_hasKey:key];
        [[theValue(result) should] beFalse];
      });
    });
    
  });
});

SPEC_END
