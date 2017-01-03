//
//  ZSTWildcardGestureRecognizerSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ZSTWildcardGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

SPEC_BEGIN(ZSTWildcardGestureRecognizerSpec)

describe(@"ZSTWildcardGestureRecognizer", ^{
  __block ZSTWildcardGestureRecognizer *gestureRecognizer;
  beforeEach(^{
    gestureRecognizer = [ZSTWildcardGestureRecognizer recognizer];
  });
  
  describe(@"touchesBeganCallback", ^{
    it(@"should call touchesBeganCallback", ^{
      __block BOOL touchesBeganCalled = NO;
      [gestureRecognizer setTouchesBeganCallback:^(NSSet *touches, UIEvent *event) {
        touchesBeganCalled = YES;
      }];
      
      [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
      [[theValue(touchesBeganCalled) should] beYes];
    });
  });
  
  describe(@"touchesMovedCallback", ^{
    it(@"should call touchesMovedCallback", ^{
      __block BOOL touchesMovedCalled = NO;
      [gestureRecognizer setTouchesMovedCallback:^(NSSet *touches, UIEvent *event) {
        touchesMovedCalled = YES;
      }];
      
      [gestureRecognizer touchesMoved:[NSSet set] withEvent:[[UIEvent alloc] init]];
      [[theValue(touchesMovedCalled) should] beYes];
    });
  });
  
  describe(@"touchesEndedCallback", ^{
    it(@"should call touchesEndedCallback", ^{
      __block BOOL touchesEndedCalled = NO;
      [gestureRecognizer setTouchesEndedCallback:^(NSSet *touches, UIEvent *event) {
        touchesEndedCalled = YES;
      }];

      [gestureRecognizer touchesEnded:[NSSet set] withEvent:[[UIEvent alloc] init]];
      [[theValue(touchesEndedCalled) should] beYes];
    });
  });
  
  describe(@"touchesCancelledCallback", ^{
    it(@"should call touchesCancelledCallback", ^{
      __block BOOL touchesCancelledCalled = NO;
      [gestureRecognizer setTouchesCancelledCallback:^(NSSet *touches, UIEvent *event) {
        touchesCancelledCalled = YES;
      }];
      
      [gestureRecognizer touchesCancelled:[NSSet set] withEvent:[[UIEvent alloc] init]];
      [[theValue(touchesCancelledCalled) should] beYes];
    });
  });
  
  describe(@"shouldReceiveTouchInViewCallback", ^{
    it(@"should call shouldReceiveTouchInViewCallback", ^{
      __block BOOL shouldReceiveTouchInViewCalled = NO;
      [gestureRecognizer setShouldReceiveTouchInViewCallback:^BOOL(UITouch *touch, UIView *view) {
        shouldReceiveTouchInViewCalled = YES;
        return YES;
      }];
      
      [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
      [[theValue(shouldReceiveTouchInViewCalled) should] beYes];
    });
    
    describe(@"Should Receive Touch", ^{
      beforeEach(^{
        [gestureRecognizer setShouldReceiveTouchInViewCallback:^BOOL(UITouch *touch, UIView *view) {
          return YES;
        }];
      });
      
      it(@"should not change state", ^{
        UIGestureRecognizerState state = gestureRecognizer.state;
        [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
        [[theValue(gestureRecognizer.state) should] equal:theValue(state)];
      });
      
      it(@"should call touchesBeganCallback", ^{
        __block BOOL touchesBeganCalled = NO;
        [gestureRecognizer setTouchesBeganCallback:^(NSSet *touches, UIEvent *event) {
          touchesBeganCalled = YES;
        }];
        
        [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
        [[theValue(touchesBeganCalled) should] beYes];
      });
    });
    
    describe(@"Should Not Receive Touch", ^{
      beforeEach(^{
        [gestureRecognizer setShouldReceiveTouchInViewCallback:^BOOL(UITouch *touch, UIView *view) {
          return NO;
        }];
      });

      it(@"should set gesture state to UIGestureRecognizerStateEnded", ^{
        [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
        [[theValue(gestureRecognizer.state) should] equal:theValue(UIGestureRecognizerStateEnded)];
      });
      
      it(@"should not call touchesBeganCallback", ^{
        __block BOOL touchesBeganCalled = NO;
        [gestureRecognizer setTouchesBeganCallback:^(NSSet *touches, UIEvent *event) {
          touchesBeganCalled = YES;
        }];
        
        [gestureRecognizer touchesBegan:[NSSet set] withEvent:[[UIEvent alloc] init]];
        [[theValue(touchesBeganCalled) should] beNo];
      });

    });
  });
});

SPEC_END
