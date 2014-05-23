//
//  ZSTViewFrameAdditionsSpec.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright 2014 Irmak Can Ozsut. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "UIView+ZSTFrameAdditions.h"

static const CGRect ZSTSpecViewFrame = {{10.f, 10.f}, {100, 100}};

SPEC_BEGIN(ZSTViewFrameAdditionsSpec)

describe(@"ZSTViewFrameAdditions", ^{
  __block UIView *view;
  
  beforeEach(^{
    view = [[UIView alloc] initWithFrame:ZSTSpecViewFrame];
  });
  
  context(@"Position", ^{
    describe(@"x", ^{
      it(@"should call left on view", ^{
        [[view should] receive:@selector(left)];
        [view x];
      });
    });
    
    describe(@"setX:", ^{
      it(@"should call setLeft: on view", ^{
        CGFloat newX = 600.f;
        [[view should] receive:@selector(setLeft:) withArguments:theValue(newX)];
        view.x = newX;
      });
    });
    
    describe(@"y", ^{
      it(@"should call top on view", ^{
        [[view should] receive:@selector(top)];
        [view y];
      });
    });
    
    describe(@"setY:", ^{
      it(@"should call setTop: on view", ^{
        CGFloat newY = 600.f;
        [[view should] receive:@selector(setTop:) withArguments:theValue(newY)];
        view.y = newY;
      });
    });
    
    describe(@"left", ^{
      it(@"should return x origin of the view", ^{
        [[theValue(view.left) should] equal:theValue(ZSTSpecViewFrame.origin.x)];
      });
    });
    
    describe(@"setLeft:", ^{
      it(@"should set x origin of the view", ^{
        CGFloat newX = 600.f;
        view.left = newX;
        [[theValue(CGRectGetMinX(view.frame)) should] equal:theValue(newX)];
      });
    });
    
    describe(@"top", ^{
      it(@"should return y origin of the view", ^{
        [[theValue(view.top) should] equal:theValue(ZSTSpecViewFrame.origin.y)];
      });
    });
    
    describe(@"setTop:", ^{
      it(@"should set y origin of the view", ^{
        CGFloat newY = 600.f;
        view.top = newY;
        [[theValue(CGRectGetMinY(view.frame)) should] equal:theValue(newY)];
      });
    });
    
    describe(@"right", ^{
      it(@"should return right of the view", ^{
        [[theValue(view.right) should] equal:theValue(ZSTSpecViewFrame.origin.x + ZSTSpecViewFrame.size.width)];
      });
    });
    
    describe(@"setRight:", ^{
      it(@"should not change frame size", ^{
        CGSize oldViewSize = view.frame.size;
        view.right = 600.f;
        CGSize newViewSize = view.frame.size;
        [[theValue(oldViewSize) should] equal:theValue(newViewSize)];
      });
      
      it(@"should set right of the view", ^{
        CGFloat newRight = 600.f;
        view.right = newRight;
        [[theValue(CGRectGetMaxX(view.frame)) should] equal:theValue(newRight)];
      });
    });
    
    describe(@"bottom", ^{
      it(@"should return bottom of the view", ^{
        [[theValue(view.bottom) should] equal:theValue(ZSTSpecViewFrame.origin.y + ZSTSpecViewFrame.size.height)];
      });
    });
    
    describe(@"setBottom:", ^{
      it(@"should not change frame size", ^{
        CGSize oldViewSize = view.frame.size;
        view.bottom = 600.f;
        CGSize newViewSize = view.frame.size;
        [[theValue(oldViewSize) should] equal:theValue(newViewSize)];
      });
      
      it(@"should set bottom of the view", ^{
        CGFloat newBottom = 600.f;
        view.bottom = newBottom;
        [[theValue(CGRectGetMaxY(view.frame)) should] equal:theValue(newBottom)];
      });
    });
    
    describe(@"position", ^{
      it(@"should return origin of the view", ^{
        [[theValue(view.position) should] equal:theValue(ZSTSpecViewFrame.origin)];
      });
    });
    
    describe(@"setPosition:", ^{
      it(@"should not change frame size", ^{
        CGSize oldViewSize = view.frame.size;
        view.position = CGPointMake(420.f, 420.f);
        CGSize newViewSize = view.frame.size;
        [[theValue(oldViewSize) should] equal:theValue(newViewSize)];
      });
      
      it(@"should set position of the view", ^{
        CGPoint newPosition = CGPointMake(520.f, 520.f);
        view.position = newPosition;
        [[theValue(view.frame.origin) should] equal:theValue(newPosition)];
      });
    });
  });
  
  context(@"Size", ^{
    describe(@"width", ^{
      it(@"should return width of the view", ^{
        [[theValue(view.width) should] equal:theValue(ZSTSpecViewFrame.size.width)];
      });
    });
    
    describe(@"setWidth:", ^{
      it(@"should not change view position", ^{
        CGPoint viewPositionOld = view.frame.origin;
        view.width = 420.f;
        CGPoint viewPositionNew = view.frame.origin;
        [[theValue(viewPositionOld) should] equal:theValue(viewPositionNew)];
      });
      
      it(@"should set width of the view", ^{
        CGFloat newWidth = 600.f;
        view.width = newWidth;
        [[theValue(CGRectGetWidth(view.frame)) should] equal:theValue(newWidth)];
      });
    });
    
    describe(@"height", ^{
      it(@"should return height of the view", ^{
        [[theValue(view.height) should] equal:theValue(ZSTSpecViewFrame.size.height)];
      });
    });
    
    describe(@"setHeight:", ^{
      it(@"should not change view position", ^{
        CGPoint viewPositionOld = view.frame.origin;
        view.height = 420.f;
        CGPoint viewPositionNew = view.frame.origin;
        [[theValue(viewPositionOld) should] equal:theValue(viewPositionNew)];
      });
      
      it(@"should set height of the view", ^{
        CGFloat newHeight = 600.f;
        view.height = newHeight;
        [[theValue(CGRectGetHeight(view.frame)) should] equal:theValue(newHeight)];
      });
    });
    
    describe(@"size", ^{
      it(@"should return size of the view", ^{
        [[theValue(view.size) should] equal:theValue(ZSTSpecViewFrame.size)];
      });
    });

    describe(@"setSize:", ^{
      it(@"should not change view position", ^{
        CGPoint viewPositionOld = view.frame.origin;
        view.size = CGSizeMake(420.f, 420.f);
        CGPoint viewPositionNew = view.frame.origin;
        [[theValue(viewPositionOld) should] equal:theValue(viewPositionNew)];
      });

      it(@"should set the size of the view", ^{
        CGSize newSize = CGSizeMake(600.f, 600.f);
        view.size = newSize;
        [[theValue(view.frame.size) should] equal:theValue(newSize)];
      });
    });
  });
});

SPEC_END
