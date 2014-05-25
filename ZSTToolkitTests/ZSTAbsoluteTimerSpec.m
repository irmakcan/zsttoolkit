//
//  ZSTAbsoluteTimerSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ZSTAbsoluteTimer.h"


SPEC_BEGIN(ZSTAbsoluteTimerSpec)

describe(@"ZSTAbsoluteTimer", ^{
  __block ZSTAbsoluteTimer *timer;
  beforeEach(^{
    timer = nil;
  });
  
  describe(@"Designated Initializer: initWithEndingDate:updateInterval:updateCallback:completion:", ^{
    it(@"should create an instance of ZSTAbsoluteTimer and calls callbacks with correct number of times", ^{
      __block BOOL completionCalled = NO;
      __block NSInteger numberOfUpdateCalls = 0;
      NSTimeInterval endingTime = 0.5;
      NSTimeInterval updateInterval = 0.1;
      NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:endingTime];

      timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateInterval:updateInterval updateCallback:^(NSTimeInterval remainingTime) {
        numberOfUpdateCalls++;
      } completion:^{
        completionCalled = YES;
      }];
      
      [[timer shouldNot] beNil];
      
      NSInteger numberOfTimesShouldBeCalled = endingTime/updateInterval;
      [[expectFutureValue(theValue(numberOfUpdateCalls)) shouldEventually] equal:theValue(numberOfTimesShouldBeCalled)];
      [[expectFutureValue(theValue(completionCalled)) shouldEventually] beYes];
    });
    
    describe(@"UIApplicationWillEnterForegroundNotification", ^{
      it(@"should call update callback when the notification received", ^{
        __block BOOL updateCalled = NO;
        NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:0.5];
        timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateInterval:0.1 updateCallback:^(NSTimeInterval remainingTime) {
          updateCalled = YES;
        } completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
        [[theValue(updateCalled) should] beYes];
      });
      
      it(@"should not call completion if ending date is not passed when the notification received", ^{
        __block BOOL completionCalled = NO;
        NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:0.5];
        timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateInterval:0.1 updateCallback:nil completion:^{
          completionCalled = YES;
        }];

        [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
        [[theValue(completionCalled) should] beNo];
      });
      
      it(@"should call completion if ending date is passed when the notification received", ^{
        __block BOOL completionCalled = NO;
        NSTimeInterval endingTime = 0.5;
        NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:endingTime];
        timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateInterval:2.0 updateCallback:nil completion:^{
          completionCalled = YES;
        }];
        
        // Wait to post notification
        [NSThread sleepForTimeInterval:endingTime + 0.1];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationWillEnterForegroundNotification object:nil];
        [[theValue(completionCalled) should] beYes];
      });
    });
  });
  
  describe(@"Ohter initializers", ^{
    describe(@"initWithEndingDate:updateCallback:completion:", ^{
      it(@"should create an instance of ZSTAbsoluteTimer with default updateInterval (1 second)", ^{
        __block BOOL completionCalled = NO;
        __block NSInteger numberOfUpdateCalls = 0;
        NSTimeInterval endingTime = 0.9;
        NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:endingTime];
        
        timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateCallback:^(NSTimeInterval remainingTime) {
          numberOfUpdateCalls++;
        } completion:^{
          completionCalled = YES;
        }];
        
        [[timer shouldNot] beNil];
        
        [[expectFutureValue(theValue(numberOfUpdateCalls)) shouldEventuallyBeforeTimingOutAfter(1.1)] equal:theValue(1)];
        [[expectFutureValue(theValue(completionCalled)) shouldEventuallyBeforeTimingOutAfter(1.1)] beYes];
      });
    });
    
    describe(@"initWithTimeInterval:updateInterval:updateCallback:completion:", ^{
      it(@"should create an instance of ZSTAbsoluteTimer and calls callbacks with correct number of times", ^{
        __block BOOL completionCalled = NO;
        __block NSInteger numberOfUpdateCalls = 0;
        NSTimeInterval endingTime = 0.5;
        NSTimeInterval updateInterval = 0.1;
        
        timer = [[ZSTAbsoluteTimer alloc] initWithTimeInterval:endingTime updateInterval:updateInterval updateCallback:^(NSTimeInterval remainingTime) {
          numberOfUpdateCalls++;
        } completion:^{
          completionCalled = YES;
        }];
        
        [[timer shouldNot] beNil];
        
        NSInteger numberOfTimesShouldBeCalled = endingTime/updateInterval;
        [[expectFutureValue(theValue(numberOfUpdateCalls)) shouldEventually] equal:theValue(numberOfTimesShouldBeCalled)];
        [[expectFutureValue(theValue(completionCalled)) shouldEventually] beYes];
      });
    });
    
    describe(@"initWithTimeInterval:updateCallback:completion:", ^{
      it(@"should create an instance of ZSTAbsoluteTimer with default updateInterval (1 second)", ^{
        __block BOOL completionCalled = NO;
        __block NSInteger numberOfUpdateCalls = 0;
        NSTimeInterval endingTime = 0.9;
        
        timer = [[ZSTAbsoluteTimer alloc] initWithTimeInterval:endingTime updateCallback:^(NSTimeInterval remainingTime) {
          numberOfUpdateCalls++;
        } completion:^{
          completionCalled = YES;
        }];
        
        [[timer shouldNot] beNil];
        
        [[expectFutureValue(theValue(numberOfUpdateCalls)) shouldEventuallyBeforeTimingOutAfter(1.1)] equal:theValue(1)];
        [[expectFutureValue(theValue(completionCalled)) shouldEventuallyBeforeTimingOutAfter(1.1)] beYes];
      });
    });
  });
  
  describe(@"invalidateTimer", ^{
    it(@"should not call update callback or completion after invalidated", ^{
      __block BOOL completionCalled = NO;
      __block BOOL updateCalled = NO;
      NSTimeInterval endingTime = 0.5;
      NSTimeInterval updateInterval = 0.1;
      NSDate *endingDate = [[NSDate date] dateByAddingTimeInterval:endingTime];
      
      timer = [[ZSTAbsoluteTimer alloc] initWithEndingDate:endingDate updateInterval:updateInterval updateCallback:^(NSTimeInterval remainingTime) {
        updateCalled = YES;
      } completion:^{
        completionCalled = YES;
      }];
      
      [timer invalidate];
      
      [[expectFutureValue(theValue(updateCalled)) shouldEventually] beNo];
      [[expectFutureValue(theValue(completionCalled)) shouldEventually] beNo];
    });
  });
});

SPEC_END
