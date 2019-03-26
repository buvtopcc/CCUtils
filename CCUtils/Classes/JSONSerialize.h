//
//  JSONSerialize.h
//  pccTestOC0402
//
//  Created by pengchangcheng on 2018/5/3.
//  Copyright © 2018 pengchangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYJSONSerialize)

- (NSString *)yy2_JSONString;

@end

@interface NSDictionary (YYJSONSerialize)

- (NSString *)yy2_JSONString;

@end

@interface NSString (YYJSONSerialize)

- (id)yy2_objectFromJSONString;
- (NSData *)yy2_dataFromJSONString;
- (NSArray *)yy2_arrayFromJSONString;
- (NSDictionary *)yy2_dictionaryFromJSONString;

@end
