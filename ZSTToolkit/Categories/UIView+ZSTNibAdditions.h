//
//  UIView+ZSTNibAdditions.h
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 01/06/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZSTNibAdditions)

/**
 Loads the nib from the main bundle with receiver's class name.
 
 @warning One of the top objects in the nib should be kind of receiver class.
 @see viewWithNibName:bundle:
 
 @return Instance of the view of loaded from the nib with receiver class.
 */
+ (nullable instancetype)viewWithNibOfClass;

/**
 Loads the nib from the main bundle with given nib name.
 
 @warning One of the top objects in the nib should be kind of receiver class.
 @see viewWithNibName:bundle:
 
 @param nibNameOrNil The nib name to load the view from. nil to load nib named of receiver class.
 
 @return Instance of the view of loaded from the nib with receiver class.
 */
+ (nullable instancetype)viewWithNibName:(nullable NSString *)nibNameOrNil;

/**
 Loads the nib from the bundle with given nib name.
 
 @param nibNameOrNil   The nib name to load the view from. nil to load nib named of receiver class.
 @param nibBundleOrNil The bundle to load the nib from. nil to load from main bundle.
 
 @return Instance of the view of loaded from the nib with receiver class.
 */
+ (nullable instancetype)viewWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil;

@end

NS_ASSUME_NONNULL_END
