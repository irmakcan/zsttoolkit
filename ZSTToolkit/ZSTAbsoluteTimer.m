//
//  ZSTAbsoluteTimer.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "ZSTAbsoluteTimer.h"
#import <UIKit/UIKit.h>

static const NSTimeInterval ZSTAbsoluteTimerDefaultUpdateInterval = 1.0;

@interface ZSTAbsoluteTimer ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSDate *endingDate;
@property (nonatomic, copy) ZSTAbsoluteTimerCompletion completion;
@property (nonatomic, copy) ZSTAbsoluteTimerUpdateCallback updateCallback;

@end

@implementation ZSTAbsoluteTimer

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  [self p_invalidateTimer];
}

#pragma mark - Initializers with NSTimeInterval

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                      updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                          completion:(ZSTAbsoluteTimerCompletion)completion
{
  self = [self initWithTimeInterval:timeInterval updateInterval:ZSTAbsoluteTimerDefaultUpdateInterval updateCallback:updateCallback completion:completion];
  return self;
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                      updateInterval:(NSTimeInterval)updateInterval
                      updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                          completion:(ZSTAbsoluteTimerCompletion)completion
{
  NSDate *now = [NSDate date];
  NSDate *endingDate = [now dateByAddingTimeInterval:timeInterval];
  
  self = [self initWithEndingDate:endingDate updateInterval:updateInterval updateCallback:updateCallback completion:completion];
  return self;
}

#pragma mark - Initializers with ending date

- (instancetype)initWithEndingDate:(NSDate *)date
                    updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                        completion:(ZSTAbsoluteTimerCompletion)completion
{
  self = [self initWithEndingDate:date updateInterval:ZSTAbsoluteTimerDefaultUpdateInterval updateCallback:updateCallback completion:completion];
  return self;
}

- (instancetype)initWithEndingDate:(NSDate *)date
                    updateInterval:(NSTimeInterval)updateInterval
                    updateCallback:(ZSTAbsoluteTimerUpdateCallback)updateCallback
                        completion:(ZSTAbsoluteTimerCompletion)completion
{
  self = [super init];
  if (self) {
    _endingDate = date;
    _updateCallback = updateCallback;
    _completion = completion;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:updateInterval
                                              target:self
                                            selector:@selector(p_timerUpdated:)
                                            userInfo:nil
                                             repeats:YES];
  }
  return self;
}

- (void)invalidate
{
  [self p_releaseBlocks];
  [self p_invalidateTimer];
}

#pragma mark - Private Methods

- (BOOL)p_isEndingDatePassed
{
  NSDate *now = [NSDate date];
  BOOL endingDatePassed = [now compare:self.endingDate] == NSOrderedDescending;
  return endingDatePassed;
}

- (void)p_callCompletion
{
  if (self.completion) {
    self.completion();
  }
}

- (void)p_callUpdateCalback
{
  if (self.updateCallback) {
    NSDate *date1 = self.endingDate;
    NSDate *date2 = [NSDate date];
    NSTimeInterval intervalBetweenDates = [date1 timeIntervalSinceDate:date2];
    self.updateCallback(intervalBetweenDates);
  }
}

- (void)p_invalidateTimer
{
  [self.timer invalidate];
  self.timer = nil;
}

- (void)p_releaseBlocks
{
  self.updateCallback = nil;
  self.completion = nil;
}

- (void)p_timerUpdated:(NSTimer *)timer
{
  [self p_callUpdateCalback];
  if ([self p_isEndingDatePassed]) {
    [self p_callCompletion];
    [self p_releaseBlocks];
    [self p_invalidateTimer];
  }
}

- (void)p_applicationWillEnterForeground:(NSNotification *)notification
{
  [self p_callUpdateCalback];
  if ([self p_isEndingDatePassed]) {
    [self p_callCompletion];
    [self p_releaseBlocks];
    [self p_invalidateTimer];
  }
}

@end
