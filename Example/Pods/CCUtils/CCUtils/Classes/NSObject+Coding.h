//
//  NSObject+Coding.h
//  Utility
//
//

#import <Foundation/Foundation.h>

/**
 * 快速实现NSCoding协议中，编码和解码的方法
 */
@interface NSObject (Coding)

/**
 * 通过Runtime解码
 *
 * @param decoder NSCoder对象
 */
- (void)yy_decodeWithCoder:(NSCoder *)decoder;

/**
 * 通过Runtime编码
 *
 * @param coder NSCoder对象
 */
- (void)yy_encodeWithCoder:(NSCoder *)coder;

@end

/**
 归档的实现
 */
#define YYCodingImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self yy_decodeWithCoder:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self yy_encodeWithCoder:encoder]; \
}

#define YYExtensionCodingImplementation YYCodingImplementation
