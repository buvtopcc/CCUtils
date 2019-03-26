//
//  UIDevice+Util.h
//  pccTestOC0518
//
//  Created by pengchangcheng on 2018/8/1.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIDeviceType) {
    UIDeviceTypeOlderThan5 = 0,
    UIDeviceTypeNewerThan5s = 1,
    UIDeviceTypeLowPerforms = 2,
    UIDeviceTypeNewerThan8 = 3,
    UIDeviceTypeSimulator = 99
};

@interface UIDevice (Util)

+ (BOOL)checkDeviceFor:(UIDeviceType)type;
+ (BOOL)isPoorDevice;
+ (BOOL)isOlderThan5;
+ (BOOL)isIPhoneX;
+ (BOOL)isIPhone7Plus;
+ (BOOL)isEntirelyScreenDevice; // 是否全面屏设备，包括 iPhone X，推荐使用此方法

@end
