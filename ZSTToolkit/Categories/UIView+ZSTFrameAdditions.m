//
//  UIView+ZSTFrameAdditions.m
//  ZSTToolkit
//
//  Created by Irmak Can Ozsut on 23/05/14.
//  Copyright (c) 2014 Irmak Can Ozsut. All rights reserved.
//

#import "UIView+ZSTFrameAdditions.h"

@implementation UIView (ZSTFrameAdditions)

#pragma mark - Position Helpers

- (CGFloat)x
{
	return self.left;
}

- (void)setX:(CGFloat)x
{
  [self setLeft:x];
}

- (CGFloat)y
{
	return self.top;
}

- (void)setY:(CGFloat)y
{
	[self setTop:y];
}

- (CGFloat)left
{
	return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)x
{
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}

- (CGFloat)top
{
	return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}

- (CGFloat)right
{
  return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right
{
	CGRect frame = self.frame;
	frame.origin.x = right - CGRectGetWidth(frame);
	self.frame = frame;
}

- (CGFloat)bottom
{
	return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
	CGRect frame = self.frame;
	frame.origin.y = bottom - CGRectGetHeight(frame);
	self.frame = frame;
}

- (CGPoint)position
{
	return self.frame.origin;
}

- (void)setPosition:(CGPoint)position
{
	CGRect frame = self.frame;
	frame.origin = position;
	[self setFrame:frame];
}

#pragma mark - Size Helpers

- (CGFloat)width
{
	return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
	CGRect frame = self.frame;
	frame.size.width = width;
	[self setFrame:frame];
}

- (CGFloat)height
{
	return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	[self setFrame:frame];
}

- (CGSize)size
{
	return self.frame.size;
}

- (void)setSize:(CGSize)size
{
	CGRect frame = self.frame;
	frame.size = size;
	[self setFrame:frame];
}

@end
