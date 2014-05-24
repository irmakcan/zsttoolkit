//
//  UINavigationController+ZSTAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "UINavigationController+ZSTAdditions.h"

@implementation UINavigationController (ZSTAdditions)

- (void)zst_removeControllerFromNavigationStack:(UIViewController *)controller
{
  NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
  [viewControllers removeObject:controller];
  self.viewControllers = viewControllers;
}

@end
