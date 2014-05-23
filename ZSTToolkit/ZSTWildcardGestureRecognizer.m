//
//  ZSTWildcardGestureRecognizer.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "ZSTWildcardGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface ZSTWildcardGestureRecognizer ()

@property (copy, nonatomic) ZSTTouchesEventBlock touchesBeganCallback;
@property (copy, nonatomic) ZSTTouchesEventBlock touchesMovedCallback;
@property (copy, nonatomic) ZSTTouchesEventBlock touchesEndedCallback;
@property (copy, nonatomic) ZSTTouchesEventBlock touchesCancelledCallback;

@property (copy, nonatomic) ZSTShouldReceiveTouchInViewBlock shouldReceiveTouchInViewCallback;

@end

@implementation ZSTWildcardGestureRecognizer

+ (instancetype)recognizer
{
  return [[self alloc] init];
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.cancelsTouchesInView = NO;
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesBegan:touches withEvent:event];
  
  if (self.shouldReceiveTouchInViewCallback) {
    UITouch *touch = [touches anyObject];
    UIView *view = self.view;
    CGPoint touchLocation = [touch locationInView:view];
    UIView *innerMostView = [view hitTest:touchLocation withEvent:nil];
    BOOL shouldReceiveTouch = self.shouldReceiveTouchInViewCallback(touch, innerMostView);
    if (!shouldReceiveTouch) {
      self.state = UIGestureRecognizerStateEnded;
      return;
    }
  }
  
  if (self.touchesBeganCallback) {
    self.touchesBeganCallback(touches, event);
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesMoved:touches withEvent:event];
  
  if (self.touchesMovedCallback) {
    self.touchesMovedCallback(touches, event);
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesEnded:touches withEvent:event];
  
  if (self.touchesEndedCallback) {
    self.touchesEndedCallback(touches, event);
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [super touchesCancelled:touches withEvent:event];
  
  if (self.touchesCancelledCallback) {
    self.touchesCancelledCallback(touches, event);
  }
}

@end
