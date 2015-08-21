//
//  BaseModel.m
//  QYER
//
//  Created by Frank on 14-4-3.
//  Copyright (c) 2014年 an qing. All rights reserved.
//

#import "BaseModel.h"
#import <objc/message.h>
#import <objc/runtime.h>


@implementation BaseModel


#pragma mark
#pragma mark super

- (id)initWithDictionary:(NSDictionary *)item
{
    self = [super init];
    if (self) {
            if (item) {
            
                [self configDataValue:^(NSString *property) {
                    if (![item[property] isKindOfClass:[NSNull class]] && item[property]) {
                        [self setValue:item[property] forKey:property];
                    }
                }];
            }
        }
    return self;
}

- (NSString*)description
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    [str appendFormat:@"\n ========= %@ ========= \n", NSStringFromClass(self.class)];
    
    [self configDataValue:^(NSString *property) {
        [str appendFormat:@" \n %@ : %@ \n", property, [self valueForKey:property]];
    }];
    
    [str appendString:@"\n ========= End ========= \n"];
    
    return str;
}

#pragma mark
#pragma mark private
/**
 *  遍历当前类，获取每个属性和属性的值
 *
 *  @param block
 */
- (void)configDataValue:(ConfigBlock)block
{
    unsigned int outCount, i;
    //得到属性的数量 runtime属性
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        //属性名字
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        block(propName);
    }
    free(properties);
}

/**
 *  转换成字典类型
 *
 *  @return 字典
 */
- (NSMutableDictionary*)toDictionary
{
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [self configDataValue:^(NSString *property) {
        if ([self valueForKey:property]) {
            [item setObject:[self valueForKey:property] forKey:property];
        }
    }];
    return item;
}

#pragma mark
#pragma mark NSCoding delegate

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self configDataValue:^(NSString *property) {
            if ([aDecoder decodeObjectForKey:property]) {
                [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
            }
        }];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self configDataValue:^(NSString *property) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }];
}


@end
