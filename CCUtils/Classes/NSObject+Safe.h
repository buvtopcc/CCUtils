//
//  NSObject+Safe.h
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/6/8.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Safe)

- (void)safePerformSelector:(SEL)selector withObject:(id)object;
- (void)safePerformSelector:(SEL)selector;
+ (void)swizzleForUnrecognizedSelector;

@end
