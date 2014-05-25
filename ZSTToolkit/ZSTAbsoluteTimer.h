//
//  ZSTAbsoluteTimer.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZSTAbsoluteTimerCompletion)();
typedef void (^ZSTAbsoluteTimerUpdateCallback)(NSTimeInterval remainingTime);

/**
 A timer which checks the reference ending date with an update interval and ends when a reference date is passed.
 Update callback is called when application enters foreground, and if ending date is passed completion is called as well.
 */
@interface ZSTAbsoluteTimer : NSObject

/**
 Designated initializer. Creates and returns a new ZSTAbsoluteTimer object starts the timer right away.
 
 @note Callback blocks retains the target if strong references used. Use weak references
 to invalidate the timer in the dealloc method of holder class.
 
 @param date           NSDate instance to check the current date is passed.
 @param updateInterval The number of seconds between firings of the timer.
 @param updateCallback A callback to be called for each fire of the timer.
 @param completion     A callback to be called when the ending date is passed.
 
 @return A new ZSTAbsoluteTimer object, configured according to the specified parameters.
 */
- (instancetype)initWithEndingDate:(NSDate *)date
                    updateInterval:(NSTimeInterval)updateInterval
                    updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                        completion:(ZSTAbsoluteTimerCompletion)completion;

/**
 Calls the designated initializer with default update interval of 1.0 seconds.
 
 @see -initWithEndingDate:updateInterval:updateCallback:completion:
 
 @param date           NSDate instance to check the current date is passed.
 @param updateCallback A callback to be called for each fire of the timer.
 @param completion     A callback to be called when the ending date is passed.
 
 @return A new ZSTAbsoluteTimer object, configured according to the specified parameters.
 */
- (instancetype)initWithEndingDate:(NSDate *)date
                    updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                        completion:(ZSTAbsoluteTimerCompletion)completion;

/**
 Calls the designated initializer with converting the time interval to date.

 @see -initWithEndingDate:updateInterval:updateCallback:completion:
 
 @param timeInterval   The number of seconds relative to the date of creation.
 @param updateInterval The number of seconds between firings of the timer.
 @param updateCallback A callback to be called for each fire of the timer.
 @param completion     A callback to be called when the ending date is passed.
 
 @return A new ZSTAbsoluteTimer object, configured according to the specified parameters.
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                      updateInterval:(NSTimeInterval)updateInterval
                      updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                          completion:(ZSTAbsoluteTimerCompletion)completion;

/**
 Calls the designated initializer with converting the time interval to date and default update interval of 1.0 seconds.
 
 @see -initWithEndingDate:updateInterval:updateCallback:completion:
 
 @param timeInterval   The number of seconds relative to the date of creation.
 @param updateCallback A callback to be called for each fire of the timer.
 @param completion     A callback to be called when the ending date is passed.
 
 @return A new ZSTAbsoluteTimer object, configured according to the specified parameters.
 */
- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                      updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                          completion:(ZSTAbsoluteTimerCompletion)completion;

/**
 Invalidates the timer and releases the callback blocks.
 */
- (void)invalidate;

@end
