#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JSONSerialize.h"
#import "NSObject+Coding.h"
#import "NSObject+Safe.h"
#import "NSObject+Swizz.h"
#import "UIDevice+Util.h"
#import "UIView+CCFrame.h"

FOUNDATION_EXPORT double CCUtilsVersionNumber;
FOUNDATION_EXPORT const unsigned char CCUtilsVersionString[];

