//
//  JSONSerialize.h
//  BaseApiSDK
//
//  Created by pengchangcheng on 2018/9/12.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYJSONSerialize)

- (NSString *)yy_JSONString;
- (NSData *)yy_JSONData;

@end

@interface NSData (YYJSONSerialize)

- (id)yy_objectFromJSONData;
- (NSString *)yy_JSONString;
- (NSArray *)yy_arrayFromData;
- (NSDictionary *)yy_dictionaryFromData;

@end

@interface NSDictionary (YYJSONSerialize)

- (NSString *)yy_JSONString;
- (NSData *)yy_JSONData;
- (NSData *)yy_JSONDataWithOptions:(NSJSONWritingOptions)options;
- (NSData *)yy_JSONDataWithOptions:(NSJSONWritingOptions)options error:(NSError **)error;

@end

@interface NSString (YYJSONSerialize)

- (id)yy_objectFromJSONString;
- (id)yy_objectFromJSONStringWithOptions:(NSJSONReadingOptions)options;
- (NSData *)yy_dataFromJSONString;
- (NSArray *)yy_arrayFromJSONString;
- (NSDictionary *)yy_dictionaryFromJSONString;

@end

@interface NSObject (YYJSONSerialize)

- (NSString *)yy_AutoJSONString;

@end
