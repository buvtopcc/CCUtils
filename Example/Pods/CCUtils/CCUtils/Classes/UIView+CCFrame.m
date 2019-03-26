//
//  UIView+CCFrame.m
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/5/21.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "UIView+CCFrame.h"

@implementation UIView (CCFrame)

- (void)setCc_width:(CGFloat)cc_width
{
    CGRect frame = self.frame;
    frame.size.width = cc_width;
    self.frame = frame;
}

- (void)setCc_height:(CGFloat)cc_height
{
    CGRect frame = self.frame;
    frame.size.height = cc_height;
    self.frame = frame;
}

- (CGFloat)cc_width
{
    return self.frame.size.width;
}

- (CGFloat)cc_height
{
    return self.frame.size.height;
}

- (CGFloat)cc_left
{
    return self.frame.origin.x;
}

- (void)setCc_left:(CGFloat)cc_left
{
    CGRect frame = self.frame;
    frame.origin.x = cc_left;
    self.frame = frame;
}

- (CGFloat)cc_top
{
    return self.frame.origin.y;
}

- (void)setCc_top:(CGFloat)cc_top
{
    CGRect frame = self.frame;
    frame.origin.y = cc_top;
    self.frame = frame;
}

- (CGSize)cc_size
{
    return self.frame.size;
}

- (void)setCc_size:(CGSize)cc_size
{
    CGRect frame = self.frame;
    frame.size = cc_size;
    self.frame = frame;
}

- (CGPoint)cc_origin
{
    return self.frame.origin;
}

- (void)setCc_origin:(CGPoint)cc_origin
{
    CGRect frame = self.frame;
    frame.origin = cc_origin;
    self.frame = frame;
}

- (CGFloat)cc_bottom
{
    return self.frame.size.height + self.frame.origin.y;
}

- (void)setCc_bottom:(CGFloat)cc_bottom
{
    CGRect frame = self.frame;
    frame.origin.y = cc_bottom - self.cc_height;
    self.frame = frame;
}

- (CGFloat)cc_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setCc_right:(CGFloat)cc_right
{
    CGRect frame = self.frame;
    frame.origin.x = cc_right - self.cc_width;
    self.frame = frame;
}

- (CGPoint)cc_center
{
    return self.center;
}

- (void)setCc_center:(CGPoint)cc_center
{
    self.center = cc_center;
}

- (CGFloat)cc_centerX
{
    return self.center.x;
}

- (void)setCc_centerX:(CGFloat)cc_centerX
{
    CGPoint center = self.center;
    center.x = cc_centerX;
    self.center = center;
}

- (CGFloat)cc_centerY
{
    return self.center.y;
}

- (void)setCc_centerY:(CGFloat)cc_centerY
{
    CGPoint center = self.center;
    center.y = cc_centerY;
    self.center = center;
}

- (CGRect)boundsOffsetX:(CGFloat)offsetX
{
    CGRect frame = self.bounds;
    frame.origin.x += offsetX;
    return frame;
}

- (CGRect)boundsOffsetY:(CGFloat)offsetY
{
    CGRect frame = self.bounds;
    frame.origin.y += offsetY;
    return  frame;
}

@end
