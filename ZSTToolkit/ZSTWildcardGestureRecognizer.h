//
//  ZSTWildcardGestureRecognizer.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The block to be called when a touch event occur.
 
 @param touches A set of UITouch instances.
 @param event   A UIEvent object representing the event to which the touches belong.
 */
typedef void (^ZSTTouchesEventBlock)(NSSet *touches, UIEvent *event);

/**
 The block to be used to determine if a gesture recognizer should receive touch.
 
 @param touch A UITouch object from the touchesBegan callback.
 @param view  The innermost view that received the touch.
 
 @return YES (the default) to allow the gesture recognizer to receive touch and NO to prevent touches.
 */
typedef BOOL (^ZSTShouldReceiveTouchInViewBlock)(UITouch *touch, UIView *view);

@interface ZSTWildcardGestureRecognizer : UIGestureRecognizer

+ (instancetype)recognizer;
- (instancetype)init;

- (void)setTouchesBeganCallback:(nullable ZSTTouchesEventBlock)touchesBeganCallback;
- (void)setTouchesMovedCallback:(nullable ZSTTouchesEventBlock)touchesMovedCallback;
- (void)setTouchesEndedCallback:(nullable ZSTTouchesEventBlock)touchesEndedCallback;
- (void)setTouchesCancelledCallback:(nullable ZSTTouchesEventBlock)touchesCancelledCallback;

/**
 Sets ZSTShouldReceiveTouchInViewBlock to determine if the gesture recognizer should receive touch.
 Example usage: Check the view is descendant of another view to determine if gesture callbacks should be called.
 
 @see ZSTTouchesEventBlock
 
 @param shouldReceiveTouchInViewCallback The block to be used to determine if a gesture recognizer should receive touch.
 */
- (void)setShouldReceiveTouchInViewCallback:(nullable ZSTShouldReceiveTouchInViewBlock)shouldReceiveTouchInViewCallback;

@end

NS_ASSUME_NONNULL_END
