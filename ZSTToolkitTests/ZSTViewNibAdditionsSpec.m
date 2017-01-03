//
//  ZSTViewNibAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 01/06/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UIView+ZSTNibAdditions.h"
#import "ZSTNibTestView.h"
#import "ZSTNibTestOtherView.h"

SPEC_BEGIN(ZSTViewNibAdditionsSpec)

describe(@"ZSTViewNibAdditions", ^{
  describe(@"viewWithNibOfClass", ^{
    it(@"should return view with calling class", ^{
      UIView *view = [ZSTNibTestView zst_viewWithNibOfClass];
      [[view should] beKindOfClass:[ZSTNibTestView class]];
    });
  });
  
  describe(@"viewWithNibName:", ^{
    it(@"should return the view in a nib", ^{
      UIView *view = [ZSTNibTestOtherView zst_viewWithNibName:@"ZSTNibTestView"];
      [[view should] beKindOfClass:[ZSTNibTestOtherView class]];
    });
  });
  
  describe(@"viewWithNibName:bundle:", ^{
    it(@"should call loadNibNamed:owner:options: on bundle", ^{
      NSBundle *bundle = [NSBundle mainBundle];
      [[bundle should] receive:@selector(loadNibNamed:owner:options:) withArguments:@"nibName", nil, nil];
      [UIView zst_viewWithNibName:@"nibName" bundle:bundle];
    });
  });
});

SPEC_END
