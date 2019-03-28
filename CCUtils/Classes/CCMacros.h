//
//  CCMacros.h
//  CCTest
//
//  Created by pengchangcheng on 2019/3/28.
//  Copyright © 2019 彭长城. All rights reserved.
//

#ifndef CCMacros_h
#define CCMacros_h

#define randomFloat0_1 ((arc4random() % 255) / 255.0)
#define RandomColor [UIColor colorWithRed:randomFloat0_1 green:randomFloat0_1 \
blue:randomFloat0_1 alpha:randomFloat0_1]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define statusBarH [UIApplication sharedApplication].statusBarFrame.size.height
#define nvBarH self.navigationController.navigationBar.frame.size.height
#define statusAndNvBarH statusBarH + nvBarH

#define stringFromFunc(func) NSStringFromSelector(@selector(func))
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define ListPushNew(vc) [[ListProducer sharedListProducer].weakController.navigationController pushViewController:vc animated:YES];
#define SafeRunBlock(b) (b ? b() : nil);

#define StartTimeStatics \
CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
// ...
#define EndTimeStatics(tag) \
CFAbsoluteTime end = CFAbsoluteTimeGetCurrent(); \
NSLog(@"%s cost time is:%f", tag, end - start);


#pragma mark - View
// 添加子视图到view或者controller
#define selfAddSubView(sv) \
if ([self isKindOfClass:[UIView class]]) { \
[(UIView *)self addSubview:sv];\
} else if ([self isKindOfClass:[UIViewController class]]){\
[[(UIViewController *)self view] addSubview:sv];\
}

#pragma mark - Warings
#define avoidClangWarings(Stuff, op) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored %s", op) \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#pragma mark - Log

// 测试开关
#define CCTest 1

// 自定义日志TAG
// 可以在XCode的Console中Filter里面输入kTagMyLog来过滤只显示 MyLog方法打印的日志
// 可以在XCode的Console中Filter里面输入kTagMyBusiness来过滤这次需求相关的日志，如SYGB（首页改版），tag可以依据需求改动

#define kTagMyLog @"MyLog"
#define kTagMyBusiness @"SYGB"
#define _Log(tag, s) do { \
NSString * t = [NSString stringWithFormat:@"[%@][%@]%sLine:%d: %@",\
tag,\
[[NSThread currentThread] isMainThread] ? @"Main" : @"NoMain",\
__PRETTY_FUNCTION__,\
__LINE__,\
s]; \
NSLog(@"%@", t); \
} while(0)


#if CCTest == 1
/* --- */
#define LogObj(obj) NSLog(@"object:<%p, %@>", obj, obj);
#define LogSplitLine NSLog(@"-----------------------------------------------------");
#define LogCurrentThread NSLog(@"%@", [NSThread currentThread]);
#define LogClassNameAlsoAddr(obj) \
do { \
if (class_isMetaClass(obj)) { \
NSLog(@"%@ %p *meta*", obj, obj); \
} else { \
NSLog(@"%@ %p", obj, obj); \
}; \
} while(0);
#define CCLogLine NSLog(@"%s", __func__);
#define CCLog(format, ...) NSLog((@"[函数名:%s]" "[行号:%d]  " format), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define MyLog(format, ...) _Log(kTagMyLog, ([NSString stringWithFormat:(format), ##__VA_ARGS__]));
#define MyBusLog(format, ...) _Log(kTagMyBusiness, ([NSString stringWithFormat:(format), ##__VA_ARGS__]));
/* --- */
#else
#define LogObj(obj)
#define LogSplitLine
#define LogCurrentThread
#define LogClassNameAlsoAddr(obj)
#define CCLogLine
#define CCLog(format, ...)
#define MyLog(format, ...)
#define MyBusLog(format, ...)
/* --- */
#endif

#pragma mark - TODO Macro
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))

#endif /* CCMacros_h */
