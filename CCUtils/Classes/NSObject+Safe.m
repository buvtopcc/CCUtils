//
//  NSObject+Safe.m
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/6/8.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "NSObject+Safe.h"
#import <objc/message.h>

@implementation NSObject (Safe)

- (void)safePerformSelector:(SEL)selector withObject:(id)object {
    if (([self respondsToSelector:selector])) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:object];
#pragma clang diagnostic pop
    }
}

- (void)safePerformSelector:(SEL)selector {
    if (([self respondsToSelector:selector])) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector];
#pragma clang diagnostic pop
    }
}

+ (void)swizzleForUnrecognizedSelector
{
    [self swizzInstanceMethod:@selector(methodSignatureForSelector_swizzle:) newSelector:@selector(methodSignatureForSelector:)];
    [self swizzInstanceMethod:@selector(forwardingTargetForSelector_swizzle:) newSelector:@selector(forwardingTargetForSelector:)];
    [self swizzInstanceMethod:@selector(forwardInvocation_swizzle:) newSelector:@selector(forwardInvocation:)];
}

#pragma mark crashguard for unrecognizedSelector
void* unrecognizedSelectorKey = &unrecognizedSelectorKey;
void* originalClassKey = &originalClassKey;
- (id)forwardingTargetForSelector_swizzle:(SEL)aSelector
{
    id obj = [self forwardingTargetForSelector_swizzle:aSelector];
    
    objc_setAssociatedObject(self, unrecognizedSelectorKey, NSStringFromSelector(aSelector), OBJC_ASSOCIATION_RETAIN);
    
    return obj;
}

- (NSMethodSignature *)methodSignatureForSelector_swizzle:(SEL)aSelector
{
    NSMethodSignature* method = [self methodSignatureForSelector_swizzle:aSelector];
    
    id val = objc_getAssociatedObject(self, unrecognizedSelectorKey);
    if( !method )
    {
        Method selfMethod = class_getInstanceMethod([self class],@selector(forwardInvocation:));
        Method thisMethod = class_getInstanceMethod([NSObject class], @selector(forwardInvocation:));
        BOOL afterForward = [val isKindOfClass:[NSString class]] && [(NSString*)val isEqualToString:NSStringFromSelector(aSelector)];
        if( afterForward && selfMethod == thisMethod)
        {
            method = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        }
    }
    if( val )
    {
        objc_setAssociatedObject(self, unrecognizedSelectorKey, nil, OBJC_ASSOCIATION_RETAIN);
    }
    return method;
}

- (void)forwardInvocation_swizzle:(NSInvocation *)anInvocation
{
    NSString* abnormalMsg = nil;
    NSString* selector = NSStringFromSelector(anInvocation.selector);
    Class cls = objc_getAssociatedObject(self, originalClassKey);
    if( cls )
    {
        abnormalMsg = [NSString stringWithFormat:@"bad access to [%@ %@] at obj:%@",NSStringFromClass(cls),selector,self];
    }
    else
    {
        abnormalMsg = [NSString stringWithFormat:@"not recognized selector:%@ sent to %@",selector,self];
    }
    
    NSLog(@"%@", abnormalMsg);
}

@end
