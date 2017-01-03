//
//  NSMutableDictionaryKeyValueExtensionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSMutableDictionary+ZSTKeyValueExtensions.h"


SPEC_BEGIN(ZSTMutableDictionaryKeyValueExtensionsSpec)

describe(@"NSMutableDictionary", ^{
  __block NSMutableDictionary *dict;
  __block NSString *key;
  beforeEach(^{
    dict = [NSMutableDictionary dictionary];
    key = @"aKey";
  });
  
  describe(@"setObjectIfNotNil:forKey:", ^{
    it(@"should not call setObject:forKey if the object is nil", ^{
      id object = nil;
      [[dict shouldNot] receive:@selector(setObject:forKey:)];
      [dict zst_setObjectIfNotNil:object forKey:key];
    });
    
    it(@"should call setObject:forKey if the object is not nil", ^{
      id object = [KWMock mock];
      [[dict should] receive:@selector(setObject:forKey:)];
      [dict zst_setObjectIfNotNil:object forKey:key];
    });
  });
});

SPEC_END
