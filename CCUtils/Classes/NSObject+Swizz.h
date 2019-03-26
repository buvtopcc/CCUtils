//
//  NSObject+Swizz.h
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/6/8.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizz)

- (void)swizzInstanceMethod:(SEL)oriSel newSelector:(SEL)newSel;
- (void)swizzClassMethod:(SEL)oriSel newSelector:(SEL)newSel;
+ (void)swizzInstanceMethod:(Class)cls oriSelector:(SEL)oriSel newSelector:(SEL)newSel;
+ (void)swizzClassMethod:(Class)cls oriSelector:(SEL)oriSel newSelector:(SEL)newSel;

@end
