//
//  NSDictionary+NSObject.m
//  AlibabaV5
//
//  Created by Lunar on 2017/9/12.
//  Copyright © 2017年 Alibaba-inc. All rights reserved.
//

#import "NSDictionary+NSObject.h"
#import <objc/runtime.h>

@implementation NSDictionary (NSObject)

+ (NSDictionary *)dictionaryWithPropertiesOfObject:(id)object {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if ([object valueForKey:key]) {
            [dict setObject:[object valueForKey:key] forKey:key];
        }
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
