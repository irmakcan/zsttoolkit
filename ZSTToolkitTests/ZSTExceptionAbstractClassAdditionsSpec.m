//
//  ZSTExceptionAbstractClassAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSException+ZSTAbstractClassAdditions.h"


SPEC_BEGIN(ZSTExceptionAbstractClassAdditionsSpec)

describe(@"ZSTExceptionAbstractClassAdditions", ^{
  describe(@"zst_abstractMethodExceptionWithClass:method:", ^{
    __block NSException *exception;
    __block Class abstractClass;
    __block SEL abstractMethod;
    beforeEach(^{
      abstractClass = [NSObject class];
      abstractMethod = @selector(setColor:); // Random method
      exception = [NSException zst_abstractMethodExceptionWithClass:abstractClass method:abstractMethod];
    });
    
    it(@"should have custom name", ^{
      [[exception.name should] equal:@"ZSTAbstractClassMethodException"];
    });
    
    it(@"should have custom reason", ^{
      NSString *reason = [NSString stringWithFormat:@"%@ should be implemented in subclass %@", NSStringFromSelector(abstractMethod), NSStringFromClass(abstractClass)];
      [[exception.reason should] equal:reason];
    });
  });
});

SPEC_END
