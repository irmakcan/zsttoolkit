//
//  ZSTNavigationControllerAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 24/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UINavigationController+ZSTAdditions.h"


SPEC_BEGIN(ZSTNavigationControllerAdditionsSpec)

describe(@"ZSTNavigationControllerAdditions", ^{
  describe(@"removeControllerFromNavigationStack:", ^{
    __block UINavigationController *navigationController;
    __block UIViewController *firstViewController;
    __block UIViewController *secondViewController;
    __block UIViewController *thirdViewController;
    
    beforeEach(^{
      firstViewController = [[UIViewController alloc] init];
      secondViewController = [[UIViewController alloc] init];
      thirdViewController = [[UIViewController alloc] init];
      navigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
      [navigationController pushViewController:secondViewController animated:NO];
      [navigationController pushViewController:thirdViewController animated:NO];
    });
    
    it(@"should remove the controller from navigation stack", ^{
      UIViewController *viewControllerToRemove = secondViewController;
      [[navigationController.viewControllers should] contain:viewControllerToRemove];
      
      [navigationController zst_removeControllerFromNavigationStack:viewControllerToRemove];
      
      [[navigationController.viewControllers shouldNot] contain:viewControllerToRemove];
    });
    
    it(@"should not change navigation stack if controller to remove is not in the navigation stack", ^{
      [[theBlock(^{
        UIViewController *otherViewController = [[UIViewController alloc] init];
        [navigationController zst_removeControllerFromNavigationStack:otherViewController];
      }) shouldNot] change:^NSInteger{ return navigationController.viewControllers.count; }];
    });
  });
});

SPEC_END
