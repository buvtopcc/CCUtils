//
//  NSObject+Coding.m
//  Utility
//

#import "NSObject+Coding.h"
#import <objc/runtime.h>

@implementation NSObject (Coding)

- (void)yy_decodeWithCoder:(NSCoder *)decoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    if (ivars) {
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *keyName = [[NSString alloc] initWithUTF8String:ivarName];
            id value = [decoder decodeObjectForKey:keyName];
            [self setValue:value forKeyPath:keyName];
        }
    }
    free(ivars);
}

- (void)yy_encodeWithCoder:(NSCoder *)coder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    if (ivars) {
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *keyName = [[NSString alloc] initWithUTF8String:ivarName];
            id value = [self valueForKeyPath:keyName];
            [coder encodeObject:value forKey:keyName];
        }
    }
    free(ivars);
}

@end





