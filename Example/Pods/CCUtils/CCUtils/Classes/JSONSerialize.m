//
//  JSONSerialize.m
//  pccTestOC0402
//
//  Created by pengchangcheng on 2018/5/3.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import "JSONSerialize.h"

@interface NSData (YYJSONSerialize)

- (NSString *)yy2_JSONString;

@end

@implementation NSData (YYJSONSerialize)

- (NSString *)yy2_JSONString
{
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (YYJSONSerialize)

- (NSData *)yy2_dataFromJSONString
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)yy2_objectFromJSONString
{
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:[self yy2_dataFromJSONString] options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return nil;
    }
    return object;
}

- (NSArray *)yy2_arrayFromJSONString
{
    id jsonObject = [self yy2_objectFromJSONString];
    if (jsonObject && [jsonObject isKindOfClass:[NSArray class]]) {
        return jsonObject;
    }
    return nil;
}

- (NSDictionary *)yy2_dictionaryFromJSONString
{
    id jsonObject = [self yy2_objectFromJSONString];
    if (jsonObject && [jsonObject isKindOfClass:[NSDictionary class]]) {
        return jsonObject;
    }
    return nil;
}



@end

@implementation NSDictionary (YYJSONSerialize)

- (NSString *)yy2_JSONString
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        return nil;
    }
    return [data yy2_JSONString];
}

@end

@implementation NSArray (YYJSONSerialize)

- (NSString *)yy2_JSONString
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    if (error) {
        return nil;
    }
    return [data yy2_JSONString];
}

@end
