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
          NSInteger returnValue = [dictWithObject integerForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(integerForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject integerForKey:key];
        });
      });
      
      describe(@"integerForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          NSInteger defaultValue = 77;
          NSInteger result = [emptyDict integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to integerValue", ^{
          NSInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          NSInteger result = [dictWithObject integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the integerValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSInteger returnValue = 44;
          
          [mockObject stub:@selector(integerValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          NSInteger result = [dictWithObject integerForKey:key defaultValue:-1];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
        
        it(@"should return the default value if NSString is not converted to a valid integer", ^{
          NSInteger defaultValue = 33;
          NSInteger result = [dictWithObject integerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return NSIntegerMin if NSString value is less than NSIntegerMin", ^{
          dictWithObject = @{key: [[NSNumber numberWithLongLong:LLONG_MIN] stringValue]};
          NSInteger result = [dictWithObject integerForKey:key defaultValue:33];
          [[theValue(result) should] equal:theValue(NSIntegerMin)];
        });
        
        it(@"should return NSIntegerMax if NSString value is larger than NSIntegerMax", ^{
          dictWithObject = @{key: [[NSNumber numberWithLongLong:LLONG_MAX] stringValue]};
          NSInteger result = [dictWithObject integerForKey:key defaultValue:33];
          [[theValue(result) should] equal:theValue(NSIntegerMax)];
        });
      });
    });
    
    describe(@"NSUInteger", ^{
      describe(@"unsignedIntegerForKey:", ^{
        it(@"should call unsignedIntegerForKey:defaultValue: with defaultValue set to 0", ^{
          NSUInteger returnValue = [dictWithObject unsignedIntegerForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(unsignedIntegerForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject unsignedIntegerForKey:key];
        });
      });
      
      describe(@"unsignedIntegerForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          NSUInteger defaultValue = 77;
          NSUInteger result = [emptyDict unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to unsignedIntegerValue", ^{
          NSUInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          NSUInteger result = [dictWithObject unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the unsignedIntegerValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSUInteger returnValue = 44;
          
          [mockObject stub:@selector(unsignedIntegerValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          NSUInteger result = [dictWithObject unsignedIntegerForKey:key defaultValue:NSUIntegerMax];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
        
        it(@"should convert NSString value to NSUInteger", ^{
          NSString *value = [NSString stringWithFormat:@"%lu", NSUIntegerMax];
          dictWithObject = @{key: value};
          
          NSUInteger result = [dictWithObject unsignedIntegerForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(NSUIntegerMax)];
        });
        
        it(@"should return default value if NSString cannot completely converted to NSUInteger", ^{
          NSString *value = @"1234,567,890";
          dictWithObject = @{key: value};
          NSUInteger defaultValue = 555;
          
          NSUInteger result = [dictWithObject unsignedIntegerForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return NSUIntegerMax NSString value is larger", ^{
          NSString *value = [NSString stringWithFormat:@"%qu", (unsigned long long)NSUIntegerMax];
          dictWithObject = @{key: value};
          
          NSUInteger result = [dictWithObject unsignedIntegerForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(NSUIntegerMax)];
        });
      });
    });
    
    describe(@"BOOL", ^{
      describe(@"boolForKey:", ^{
        it(@"should call boolForKey:defaultValue: with defaultValue set to NO", ^{
          BOOL returnValue = [dictWithObject boolForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(boolForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(NO)];
          [dictWithObject boolForKey:key];
        });
      });
      
      describe(@"boolForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          BOOL defaultValue = YES;
          BOOL result = [emptyDict boolForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the default value if the object is not responds to boolValue", ^{
          BOOL defaultValue = YES;
          dictWithObject = @{key: [KWMock mock]};
          BOOL result = [dictWithObject boolForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the boolValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          BOOL returnValue = YES;
          
          [mockObject stub:@selector(boolValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          BOOL result = [dictWithObject boolForKey:key defaultValue:NO];
          [[theValue(result) should] equal:theValue(returnValue)];
        });
      });
    });
    
  });
  
  context(@"C primitive helpers", ^{
    
    describe(@"float", ^{
      describe(@"floatForKey:", ^{
        it(@"should call floatForKey:defaultValue: with defaultValue set to 0.f", ^{
          float returnValue = [dictWithObject floatForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(floatForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject floatForKey:key];
        });
      });
      
      describe(@"floatForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          float defaultValue = 77.f;
          float result = [emptyDict floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to floatValue", ^{
          float defaultValue = 33.f;
          dictWithObject = @{key: [KWMock mock]};
          float result = [dictWithObject floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });
        
        it(@"should return the floatValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          float returnValue = 44.f;
          
          [mockObject stub:@selector(floatValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          float result = [dictWithObject floatForKey:key defaultValue:-1.f];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should return the default value if NSString is not converted to a valid float", ^{
          float defaultValue = 33.f;
          float result = [dictWithObject floatForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return 0.f if NSString value has more precision than FLT_MIN (Underflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:DBL_MIN] stringValue]};
          float result = [dictWithObject floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(0.f)];
        });

        it(@"should return HUGE_VAL if NSString value is larger than FLT_MAX (Overflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:DBL_MAX] stringValue]};
          float result = [dictWithObject floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(HUGE_VAL)];
        });
        
        it(@"should return -HUGE_VAL if NSString value is less than -FLT_MAX (Overflow)", ^{
          dictWithObject = @{key: [[NSNumber numberWithDouble:-DBL_MAX] stringValue]};
          float result = [dictWithObject floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(-HUGE_VAL)];
        });
        
        it(@"should return correct float value of dot seperated NSString", ^{
          float value = 123.25f;
          dictWithObject = @{key: [[NSNumber numberWithFloat:value] stringValue]};
          float result = [dictWithObject floatForKey:key defaultValue:33.f];
          [[theValue(result) should] equal:theValue(value)];
        });
      });
    });

    describe(@"double", ^{
      describe(@"doubleForKey:", ^{
        it(@"should call doubleForKey:defaultValue: with defaultValue set to 0.0", ^{
          double returnValue = [dictWithObject doubleForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(doubleForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject doubleForKey:key];
        });
      });
      
      describe(@"doubleForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          double defaultValue = 77.0;
          double result = [emptyDict doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to doubleValue", ^{
          double defaultValue = 33.0;
          dictWithObject = @{key: [KWMock mock]};
          double result = [dictWithObject doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the doubleValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          double returnValue = 44.0;
          
          [mockObject stub:@selector(doubleValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          double result = [dictWithObject doubleForKey:key defaultValue:-1.0];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should return the default value if NSString is not converted to a valid double", ^{
          double defaultValue = 33.0;
          double result = [dictWithObject doubleForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return 0.0 if NSString value has more precision than DBL_MIN (Underflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", LDBL_MIN]};
          double result = [dictWithObject doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(0.0)];
        });

        it(@"should return HUGE_VAL if NSString value is larger than DBL_MAX (Overflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", LDBL_MAX]};
          double result = [dictWithObject doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(HUGE_VAL)];
        });

        it(@"should return -HUGE_VAL if NSString value is less than -DBL_MAX (Overflow)", ^{
          dictWithObject = @{key: [NSString stringWithFormat:@"%Lg", -LDBL_MAX]};
          double result = [dictWithObject doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(-HUGE_VAL)];
        });

        it(@"should return correct double value of dot seperated NSString", ^{
          double value = 123.25;
          dictWithObject = @{key: [[NSNumber numberWithDouble:value] stringValue]};
          double result = [dictWithObject doubleForKey:key defaultValue:33.0];
          [[theValue(result) should] equal:theValue(value)];
        });
      });
    });

    describe(@"unsigned long long", ^{
      describe(@"unsignedLongLongForKey:", ^{
        it(@"should call unsignedLongLongForKey:defaultValue: with defaultValue set to 0", ^{
          unsigned long long returnValue = [dictWithObject unsignedLongLongForKey:key defaultValue:0];
          [[dictWithObject should] receive:@selector(unsignedLongLongForKey:defaultValue:)
                                 andReturn:theValue(returnValue)
                             withArguments:key, theValue(0)];
          [dictWithObject unsignedLongLongForKey:key];
        });
      });
      
      describe(@"unsignedLongLongForKey:defaultValue:", ^{
        it(@"should return default value when there is no key", ^{
          unsigned long long defaultValue = 77;
          unsigned long long result = [emptyDict unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the default value if the object is not responds to unsignedLongLongValue", ^{
          NSUInteger defaultValue = 33;
          dictWithObject = @{key: [KWMock mock]};
          unsigned long long result = [dictWithObject unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return the unsignedLongLongValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSUInteger returnValue = 44;
          
          [mockObject stub:@selector(unsignedLongLongValue) andReturn:theValue(returnValue)];
          dictWithObject = @{key: mockObject};
          
          unsigned long long result = [dictWithObject unsignedLongLongForKey:key defaultValue:ULONG_LONG_MAX];
          [[theValue(result) should] equal:theValue(returnValue)];
        });

        it(@"should convert NSString value to unsigned long long", ^{
          NSString *value = [[NSNumber numberWithUnsignedLongLong:ULONG_LONG_MAX] stringValue];
          dictWithObject = @{key: value};
          
          unsigned long long result = [dictWithObject unsignedLongLongForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(ULONG_LONG_MAX)];
        });

        it(@"should return default value if NSString cannot completely converted to unsigned long long", ^{
          NSString *value = @"1234,567,890";
          dictWithObject = @{key: value};
          NSUInteger defaultValue = 555;
          
          unsigned long long result = [dictWithObject unsignedLongLongForKey:key defaultValue:defaultValue];
          [[theValue(result) should] equal:theValue(defaultValue)];
        });

        it(@"should return ULONG_LONG_MAX if NSString value is larger", ^{
          NSString *value = [[NSNumber numberWithUnsignedLongLong:ULONG_LONG_MAX] stringValue];
          dictWithObject = @{key: value};
          
          unsigned long long result = [dictWithObject unsignedLongLongForKey:key defaultValue:555];
          [[theValue(result) should] equal:theValue(ULONG_LONG_MAX)];
        });
      });
    });
  });
  
  context(@"Object helpers", ^{
    
    describe(@"string helpers", ^{
      describe(@"stringForKey:", ^{
        it(@"should call stringForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject stringForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(stringForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject stringForKey:key];
        });
      });
      
      describe(@"stringForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          NSString *defaultString = @"defaultObj";
          id result = [emptyDict stringForKey:key defaultValue:defaultString];
          [[result should] equal:defaultString];
        });
        
        it(@"should return the default value if the object is not a string or responds to stringValue", ^{
          NSString *defaultString = @"defaultObj";
          dictWithObject = @{key: [KWMock mock]};
          id result = [dictWithObject stringForKey:key defaultValue:defaultString];
          [[result should] equal:defaultString];
        });
        
        it(@"should return the object if it is a string", ^{
          NSString *string = @"string";
          dictWithObject = @{key: string};
          
          id result = [dictWithObject stringForKey:key defaultValue:nil];
          [[result should] equal:string];
        });
        
        it(@"should return the stringValue of the object if it responds to it", ^{
          id mockObject = [KWMock mockForClass:[NSNumber class]];
          NSString *mockString = @"mockString";
          
          [mockObject stub:@selector(stringValue) andReturn:mockString];
          dictWithObject = @{key: mockObject};
          
          id result = [dictWithObject stringForKey:key defaultValue:nil];
          [[result should] equal:mockString];
        });
      });
    });
    
    describe(@"array helpers", ^{
      describe(@"arrayForKey:", ^{
        it(@"should call arrayForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject arrayForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(arrayForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject arrayForKey:key];
        });
      });
      
      describe(@"arrayForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          id defaultObject = @[];
          id result = [emptyDict arrayForKey:key defaultValue:defaultObject];
          [[result should] equal:defaultObject];
        });
        
        it(@"should return the default value if the value is not an array", ^{
          id defaultObject = @[];
          dictWithObject = @{key: @"nonArrayObject"};
          id result = [dictWithObject arrayForKey:key defaultValue:defaultObject];
          [[result should] equal:defaultObject];
        });
        
        it(@"should return the object if it is an array", ^{
          NSArray *array = @[];
          dictWithObject = @{key: array};
          
          id result = [dictWithObject arrayForKey:key defaultValue:nil];
          [[result should] equal:array];
        });
      });
    });
    
    describe(@"dictionary helpers", ^{
      describe(@"dictionaryForKey:", ^{
        it(@"should call dictionaryForKey:defaultValue: with defaultValue set to nil", ^{
          id returnValue = [dictWithObject dictionaryForKey:key defaultValue:nil];
          [[dictWithObject should] receive:@selector(dictionaryForKey:defaultValue:)
                                 andReturn:returnValue
                             withArguments:key, nil];
          [dictWithObject dictionaryForKey:key];
        });
      });
      
      describe(@"dictionaryForKey:defaultValue:", ^{
        it(@"should return the default value if there is no key", ^{
          NSDictionary *defaultDictionary = @{};
          id result = [emptyDict dictionaryForKey:key defaultValue:defaultDictionary];
          [[result should] equal:defaultDictionary];
        });
        
        it(@"should return the default value if the value is not a dictionary", ^{
          NSDictionary *defaultDictionary = @{};
          dictWithObject = @{key: @"nonDictionartObject"};
          id result = [dictWithObject dictionaryForKey:key defaultValue:defaultDictionary];
          [[result should] equal:defaultDictionary];
        });
        
        it(@"should return the object if it is a dictionary", ^{
          NSDictionary *dict = @{};
          dictWithObject = @{key: dict};
          
          id result = [dictWithObject dictionaryForKey:key defaultValue:nil];
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
            [emptyDict jsonObjectForKey:key ofClass:[KWMock class]];
          }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                                                            NSStringFromClass([KWMock class]),
                                                                            NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]];
        });

        it(@"should return nil if the key does not exist", ^{
          id result = [emptyDict jsonObjectForKey:key ofClass:mockJsonClass];
          [[result should] beNil];
        });

        it(@"should return nil if the object is not a dictionary object", ^{
          dictWithObject = @{key: @"nonDictionaryObject"};
          id result = [dictWithObject jsonObjectForKey:key ofClass:mockJsonClass];
          [[result should] beNil];
        });

        it(@"should return instance of the given class if the object is a dictionary", ^{
          dictWithObject = @{key: @{}};
          id result = [dictWithObject jsonObjectForKey:key ofClass:mockJsonClass];
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
            [emptyDict jsonObjectArrayForKey:key ofClass:[KWMock class]];
          }) should] raiseWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"Class %@ does not conform to %@",
                                                                            NSStringFromClass([KWMock class]),
                                                                            NSStringFromProtocol(@protocol(ZSTJSONObjectInitializationProtocol))]];
        });
        
        it(@"should return empty array if the key does not exist", ^{
          NSArray *objects = [emptyDict jsonObjectArrayForKey:key ofClass:mockJsonClass];
          [[objects should] beKindOfClass:[NSArray class]];
          [[theValue(objects.count) should] beZero];
        });

        it(@"should return empty array if the value is not a dictionary object", ^{
          dictWithObject = @{key: @"nonDictionaryObject"};
          NSArray *objects = [dictWithObject jsonObjectArrayForKey:key ofClass:mockJsonClass];
          [[objects should] beKindOfClass:[NSArray class]];
          [[theValue(objects.count) should] beZero];
        });

        it(@"should return non empty array of the given class if the object is a dictionary", ^{
          dictWithObject = @{key: @[@{}, @{}]};
          NSArray *objects = [dictWithObject jsonObjectArrayForKey:key ofClass:mockJsonClass];
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
        id result = [dictWithObject objectForKey:key defaultObject:@"anotherObject"];
        [[result should] equal:@"anObject"];
      });
      
      it(@"should return the defaultValue if there is no key", ^{
        id anotherObject = @"anotherObject";
        id result = [emptyDict objectForKey:key defaultObject:anotherObject];
        [[result should] equal:anotherObject];
      });
    });
    
    describe(@"hasKey:", ^{
      it(@"should return YES when there is a key", ^{
        BOOL result = [dictWithObject hasKey:key];
        [[theValue(result) should] beTrue];
      });
      
      it(@"should return NO when there is no associated key", ^{
        BOOL result = [emptyDict hasKey:key];
        [[theValue(result) should] beFalse];
      });
    });
    
  });
});

SPEC_END
