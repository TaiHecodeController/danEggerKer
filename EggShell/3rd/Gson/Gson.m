//
//  Gson.m
//  Gson
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "Gson.h"
#import "GAdapter.h"

@implementation GsonException

@end

@implementation Gson

+(id)fromJson:(NSString*)json Cls:(Class)cls
{
    id obj = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if( ! [obj isKindOfClass:[NSDictionary class]] ){
        return nil;
    }
    return [self fromObj:obj Cls:cls];
}

+(id)fromObj:(id)json Cls:(Class)cls
{
    if( cls == nil ){
        cls = [NSObject class];
    }
    
    if( [json isKindOfClass:[NSArray class]] && class_conformsToProtocol(cls, @protocol(Expose)))
    {
        ItemDscrp ids;
        ids.itemCls = cls;
        
        GAdapter * Ad;
        Ad = [GFactory makeAdapter:[NSArray class] Property:&ids];

        return [Ad load:json];
    }
    else
    {
        GAdapter * Ad = [GFactory makeAdapter:cls Property:nil];
        return [Ad load:json];
    }
}

@end
