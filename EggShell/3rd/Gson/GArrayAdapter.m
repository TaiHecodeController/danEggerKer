//
//  GArrayAdapter.m
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "Gson.h"
#import "GArrayAdapter.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation GArrayFactory

-(GAdapter *) make:(Class)cls Property:(ItemDscrp *)prop
{
    if( prop == nil ){
        return nil;
    }
    
    if( cls != [NSArray class] && cls != [NSMutableArray class] ){
        return nil;
    }

    Class itemCls = prop->itemCls;
    
    if( itemCls == nil )
    {
        const char * name = property_getName(*prop->prop);
        NSString * sel_name = [NSString stringWithFormat:@"array_%s_type", name];

        SEL s = NSSelectorFromString(sel_name);
        Method m = class_getClassMethod(prop->cls, s);

        if( m == nil ){
            return nil;
        }
        
        itemCls = objc_msgSend((id)(prop->cls), s, nil);
    }
    
    GArrayAdapter * Ad = [GArrayAdapter new];
    Ad.ItemAdapter = [GFactory makeAdapter:itemCls Property:nil];
    
    if( Ad.ItemAdapter == nil){
        return nil;
    }
    
    return Ad;
}

@end

@implementation GArrayAdapter

-(id)load:(id)data
{
    if([data isKindOfClass:[NSNull class]]){
        return nil;
    }
 
    if( ! [data isKindOfClass:[NSArray class]] )
    {
        NSString * reason = [NSString stringWithFormat:@"%@, 数据类型错误", [[data class] description]];
        
        @throw [[GsonException alloc] initWithName:@"解析错误" reason:reason userInfo:nil];
    }
    
    NSArray * array = data;
    NSMutableArray * value = [NSMutableArray new];
    
    for(id item in array)
    {
        id item_data = [_ItemAdapter load:item];
        
        if( item != nil ){
            [value addObject:item_data];
        }
    }
    
    return value;
}

@end
