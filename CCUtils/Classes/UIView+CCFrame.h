//
//  UIView+CCFrame.h
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/5/21.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CCFrame)

@property (nonatomic, assign) CGFloat cc_width;
@property (nonatomic, assign) CGFloat cc_height;
@property (nonatomic, assign) CGFloat cc_left;
@property (nonatomic, assign) CGFloat cc_top;
@property (nonatomic, assign) CGFloat cc_bottom;
@property (nonatomic, assign) CGFloat cc_right;
@property (nonatomic, assign) CGFloat cc_centerX;
@property (nonatomic, assign) CGFloat cc_centerY;
@property (nonatomic, assign) CGPoint cc_center;
@property (nonatomic, assign) CGPoint cc_origin;
@property (nonatomic, assign) CGSize cc_size;


- (CGRect)boundsOffsetX:(CGFloat)offsetX;
- (CGRect)boundsOffsetY:(CGFloat)offsetY;


@end
