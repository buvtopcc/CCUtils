//
//  JSONSerialize.m
//  BaseApiSDK
//
//  Created by pengchangcheng on 2018/9/12.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "JSONSerialize.h"

@implementation NSData (YYJSONSerialize)

inline static void _Log(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    NSLog(@"[JSONSerialize] %@", msg);
    va_end(args);
}

- (NSString *)yy_JSONString
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

- (id)yy_objectFromJSONData {
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSString *sError = [error description];
        NSString *string = [self yy_JSONString];
        _Log(@"yy_objectFromJSONData error:%@ string:%@", sError, string);
        return nil;
    }
    return object;
}

- (NSArray *)yy_arrayFromData {
    id jsonObject = [self yy_objectFromJSONData];
    if (jsonObject && [jsonObject isKindOfClass:[NSArray class]]) {
        return jsonObject;
    }
    return nil;
}

- (NSDictionary *)yy_dictionaryFromData {
    id jsonObject = [self yy_objectFromJSONData];
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        return jsonObject;
    }
    return nil;
}

@end

@implementation NSString (YYJSONSerialize)

- (NSData *)yy_dataFromJSONString
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)yy_objectFromJSONString
{
    return [self yy_objectFromJSONStringWithOptions:NSJSONReadingAllowFragments];
}

- (id)yy_objectFromJSONStringWithOptions:(NSJSONReadingOptions)options {
    NSError *error = nil;
    NSData *jsonData = [self yy_dataFromJSONString];
    if (!jsonData) {
        return nil;
    }
    
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:options error:&error];
    if (error) {
        NSString *errorDesc = [error description];
        NSString *string = [self description];
        _Log(@"yy_objectFromJSONString error:%@ string:%@", errorDesc, string);
        return nil;
    }
    
    return object;
}

- (NSArray *)yy_arrayFromJSONString
{
    id jsonObject = [self yy_objectFromJSONString];
    if (jsonObject && [jsonObject isKindOfClass:[NSArray class]]) {
        return jsonObject;
    }
    return nil;
}

- (NSDictionary *)yy_dictionaryFromJSONString
{
    id jsonObject = [self yy_objectFromJSONString];
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        return jsonObject;
    }
    return nil;
}

@end

@implementation NSDictionary (YYJSONSerialize)

- (NSString *)yy_JSONString
{
    return [[self yy_JSONData] yy_JSONString];
}

- (NSData *)yy_JSONData {
    return [self yy_JSONDataWithOptions:0];
}

- (NSData *)yy_JSONDataWithOptions:(NSJSONWritingOptions)options {
    NSError *error = nil;
    return [self yy_JSONDataWithOptions:options error:&error];
}

- (NSData *)yy_JSONDataWithOptions:(NSJSONWritingOptions)options error:(NSError **)error {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:options error:error];
    if (*error) {
        NSString *sError = [*error description];
        NSString *string = [self description];
        _Log(@"yy_JSONData[NSDictionary] error:%@ string:%@", sError, string);
        return nil;
    }
    return data;
}

@end

@implementation NSArray (YYJSONSerialize)

- (NSString *)yy_JSONString
{
    return [[self yy_JSONData] yy_JSONString];
}

- (NSData *)yy_JSONData {
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        NSString *sError = [error description];
        NSString *string = [self description];
        _Log(@"yy_JSONData[NSArray] error:%@ string:%@", sError, string);
        return nil;
    }
    return data;
}

@end

@implementation NSObject (YYJSONSerialize)

- (NSString *)yy_AutoJSONString {
    if ([self isKindOfClass:[NSArray class]]) {
        return [(NSArray *)self yy_JSONString];
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)self yy_JSONString];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [(NSData *)self yy_JSONString];
    } else if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    }
    NSString *description = [self description];
    _Log(@"不支持autoJSONString的对象 %@", description);
    return nil;
}

@end
