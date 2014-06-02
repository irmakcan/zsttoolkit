//
//  UIView+ZSTNibAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 01/06/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "UIView+ZSTNibAdditions.h"

@implementation UIView (ZSTNibAdditions)

+ (instancetype)viewWithNibOfClass
{
  return [self viewWithNibName:nil];
}

+ (instancetype)viewWithNibName:(NSString *)nibNameOrNil
{
  return [self viewWithNibName:nibNameOrNil bundle:nil];
}

+ (instancetype)viewWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  NSBundle *bundle = nibBundleOrNil;
  if (!bundle) {
    bundle = [NSBundle mainBundle];
  }

  NSString *nibName = nibNameOrNil;
  if (!nibName) {
    nibName = NSStringFromClass([self class]);
  }
  
  UIView *trueInstance = nil;
  NSArray *views = [bundle loadNibNamed:nibName owner:nil options:nil];
  for (UIView *view in views) {
    if ([view isKindOfClass:[self class]]) {
      trueInstance = view;
      break;
    }
  }
  return trueInstance;
}

@end
