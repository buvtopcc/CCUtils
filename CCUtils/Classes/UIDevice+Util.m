//
//  UIDevice+Util.m
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/8/1.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "UIDevice+Util.h"
#include <sys/sysctl.h>

@implementation UIDevice (Util)

+ (BOOL)isPoorDevice {
    return [UIDevice checkDeviceFor:UIDeviceTypeLowPerforms];
}

+ (BOOL)isOlderThan5 {
    return [UIDevice checkDeviceFor:UIDeviceTypeOlderThan5];
}

+ (BOOL)isIPhoneX {
    static dispatch_once_t once;
    static BOOL iPhoneX;
    dispatch_once(&once, ^{
        CGFloat min = MIN(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        CGFloat max = MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
        if (min == 375.f && max == 812.f) {
            iPhoneX = YES;
        } else {
            iPhoneX = NO;
        }
    });
    return iPhoneX;
}

+ (BOOL)isEntirelyScreenDevice {
    return [UIDevice isIPhoneX];
}

+ (BOOL)checkDeviceFor:(UIDeviceType)type {
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *modelIdentifier = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([modelIdentifier isEqualToString:@"i386"] || [modelIdentifier isEqualToString:@"x86_64"]) {
        return [UIDevice checkSimulatorFor:type];
    } else if ([modelIdentifier rangeOfString:@"iPhone"].location != NSNotFound) {
        return [UIDevice checkiPhoneFor:type modelIdentifier:modelIdentifier];
    } else if ([modelIdentifier rangeOfString:@"iPod"].location != NSNotFound ||
               [modelIdentifier rangeOfString:@"iPad"].location != NSNotFound) {
        return [UIDevice checkiPadFor:type];
    } else {
        return NO;
    }
}

+ (BOOL)isIPhone7Plus {
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"]) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isWidthMoreThan320 {
    return [UIScreen mainScreen].bounds.size.width > 320;
}

+ (BOOL)checkSimulatorFor:(UIDeviceType)type {
    switch (type) {
        case UIDeviceTypeSimulator:
            return YES;
        case UIDeviceTypeNewerThan5s:
            if (![self isWidthMoreThan320]) {
                return YES;
            }
            return NO;
        case UIDeviceTypeOlderThan5:
            if (![self isWidthMoreThan320]) {
                return YES;
            }
            return NO;
        case UIDeviceTypeLowPerforms:
            return NO;
        default:
            return YES;
    }
}

+ (BOOL)checkiPadFor:(UIDeviceType)type {
    switch (type) {
        case UIDeviceTypeSimulator:
            return NO;
        case UIDeviceTypeNewerThan5s:
            return NO;
        case UIDeviceTypeOlderThan5:
            return YES;
        case UIDeviceTypeLowPerforms:
            return NO;
        default:
            return YES;
    }
}

// 各机型字符串可见：https://github.com/erichoracek/UIDevice-Hardware/blob/master/UIDevice-Hardware.m
+ (BOOL)checkiPhoneFor:(UIDeviceType)type modelIdentifier:(NSString *)modelIdentifier {
    switch (type) {
        case UIDeviceTypeNewerThan5s: {
            return !([modelIdentifier isEqualToString:@"iPhone1,1"]    // @"iPhone_1G";
                     || [modelIdentifier isEqualToString:@"iPhone1,2"] // @"iPhone_3G";
                     || [modelIdentifier isEqualToString:@"iPhone2,1"] // @"iPhone_3GS";
                     || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                     || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                     || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                     || [modelIdentifier isEqualToString:@"iPhone4,1"] // @"iPhone_4s";
                     || [modelIdentifier isEqualToString:@"iPhone5,1"] // @"iPhone_5";
                     || [modelIdentifier isEqualToString:@"iPhone5,2"] // @"iPhone_5";
                     || [modelIdentifier isEqualToString:@"iPhone5,3"] // @"iPhone_5c";
                     || [modelIdentifier isEqualToString:@"iPhone5,4"] // @"iPhone_5c";
                     || [modelIdentifier isEqualToString:@"iPhone6,1"] // @"iPhone_5s";
                     || [modelIdentifier isEqualToString:@"iPhone6,2"] // @"iPhone_5s";
                     );
        }
        case UIDeviceTypeOlderThan5: {
            return ([modelIdentifier isEqualToString:@"iPhone1,1"]    // @"iPhone_1G";
                    || [modelIdentifier isEqualToString:@"iPhone1,2"] // @"iPhone_3G";
                    || [modelIdentifier isEqualToString:@"iPhone2,1"] // @"iPhone_3GS";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone4,1"] // @"iPhone_4s";
                    );
        }
        case UIDeviceTypeLowPerforms: {
            return ([modelIdentifier isEqualToString:@"iPhone1,1"]    // @"iPhone_1G";
                    || [modelIdentifier isEqualToString:@"iPhone1,2"] // @"iPhone_3G";
                    || [modelIdentifier isEqualToString:@"iPhone2,1"] // @"iPhone_3GS";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone3,1"] // @"iPhone_4";
                    || [modelIdentifier isEqualToString:@"iPhone4,1"] // @"iPhone_4s";
                    || [modelIdentifier isEqualToString:@"iPhone5,1"] // @"iPhone_5";
                    || [modelIdentifier isEqualToString:@"iPhone5,2"] // @"iPhone_5";
                    || [modelIdentifier isEqualToString:@"iPhone5,3"] // @"iPhone_5c";
                    || [modelIdentifier isEqualToString:@"iPhone5,4"] // @"iPhone_5c";
                    );
        }
        case UIDeviceTypeNewerThan8: {
            /*
             获取 iPhone 后的数字，如果是 10 及以上的，则代表是 iPhone 8 及以上的 iPhone
             iPhone10,1  iPhone 8
             iPhone10,2  iPhone 8 Plus
             iPhone10,3  iPhone X
             iPhone10,4  iPhone 8
             iPhone10,5  iPhone 8 Plus
             iPhone10,6  iPhone X
             */
            static NSInteger kIPhone8ModelNum = 10;
            static NSString *kIPhoneStr = @"iPhone";
            NSUInteger kIPhoneStrLength = kIPhoneStr.length;
            
            NSString *modelStr = [modelIdentifier componentsSeparatedByString:@","].firstObject;
            if ([modelStr hasPrefix:kIPhoneStr]) {
                NSInteger modelNum = [modelStr substringFromIndex:kIPhoneStrLength].integerValue;
                return modelNum >= kIPhone8ModelNum;
            }
            return NO;
        }
            
        default:
            return NO;
    }
}

@end
