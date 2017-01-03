//
//  UINavigationController+ZSTAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (ZSTAdditions)

- (void)zst_removeControllerFromNavigationStack:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
