//
//  ZSTWildCardGestureTestViewController.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "ZSTWildCardGestureTestViewController.h"
#import "ZSTWildcardGestureRecognizer.h"

@interface ZSTWildCardGestureTestViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *buttonContainerView;
@property (strong, nonatomic) IBOutlet UIButton *redButton;

@end

@implementation ZSTWildCardGestureTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  ZSTWildcardGestureRecognizer *recognizer = [ZSTWildcardGestureRecognizer recognizer];
  [recognizer setTouchesBeganCallback:^(NSSet *touches, UIEvent *event) {
    NSLog(@"Touches Began");
  }];
  [recognizer setTouchesMovedCallback:^(NSSet *touches, UIEvent *event) {
    NSLog(@"Touches Moved");
  }];
  [recognizer setShouldReceiveTouchInViewCallback:^BOOL(UITouch *touch, UIView *view) {
    if ([view isDescendantOfView:self.redButton]) {
      return NO;
    }
    return YES;
  }];
  [self.buttonContainerView addGestureRecognizer:recognizer];
}

@end
