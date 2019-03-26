//
//  NSObject+Swizz.m
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/6/8.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "NSObject+Swizz.h"
#import <objc/message.h>

@implementation NSObject (Swizz)

- (void)swizzInstanceMethod:(SEL)oriSel newSelector:(SEL)newSel {
    [NSObject swizzInstanceMethod:[self class] oriSelector:oriSel newSelector:newSel];
}

- (void)swizzClassMethod:(SEL)oriSel newSelector:(SEL)newSel {
   [NSObject swizzClassMethod:[self class] oriSelector:oriSel newSelector:newSel];
}

+ (void)swizzInstanceMethod:(Class)cls oriSelector:(SEL)oriSel newSelector:(SEL)newSel {
    Method oriM = class_getInstanceMethod(cls, oriSel);
    Method newM = class_getInstanceMethod(cls, newSel);
    if (class_addMethod(cls, oriSel, method_getImplementation(newM), method_getTypeEncoding(newM))) {
        // oriM方法不存在
        class_replaceMethod(cls, newSel, method_getImplementation(oriM), method_getTypeEncoding(oriM));
    } else {
        method_exchangeImplementations(oriM, newM);
    }
}

+ (void)swizzClassMethod:(Class)cls oriSelector:(SEL)oriSel newSelector:(SEL)newSel {
    Class metaCls = object_getClass(cls);
    Method oriM = class_getClassMethod(cls, oriSel);
    Method newM = class_getClassMethod(cls, newSel);
    if (class_addMethod(metaCls, oriSel, method_getImplementation(newM), method_getTypeEncoding(newM))) {
        class_replaceMethod(metaCls, newSel, method_getImplementation(oriM), method_getTypeEncoding(oriM));
    } else {
        method_exchangeImplementations(oriM, newM);
    }
}

@end
