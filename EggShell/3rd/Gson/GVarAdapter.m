//
//  GVarAdapter.m
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "Gson.h"
#import "GVarAdapter.h"
#import <objc/runtime.h>

@implementation GVarFactory

bool class_isKindofClass(Class cls, Class superCls)
{
    while(cls != [NSObject class] && cls != nil){
        if( cls == superCls ){
            return true;
        }
        
        cls = class_getSuperclass(cls);
    }
    
    return false;
}

-(GAdapter *) make:(Class)cls Property:(ItemDscrp *)prop
{
    GVarAdapter * Ad = [GVarAdapter new];

    if( cls == [NSObject class]){
        Ad.Cls = [NSObject class];
        return Ad;
    }
    
    if( cls == [NSString class] || cls == [NSMutableString class]){
        Ad.Cls = [NSString class];
        return Ad;
    }
    
    if( cls == [NSArray class] || cls == [NSMutableArray class]){
        Ad.Cls = [NSArray class];
        return Ad;
    }

    if( cls == [NSDictionary class] || cls == [NSMutableDictionary class]){
        Ad.Cls = [NSDictionary class];
        return Ad;
    }
    
    if( cls == [NSNumber class] ){
        Ad.Cls = [NSNumber class];
        return Ad;
    }
    
    return nil;
}

@end

@implementation GVarAdapter

-(id)load:(id)data
{
    if([data isKindOfClass:[NSNull class]]){
        return nil;
    }
    
    if( [data isKindOfClass:_Cls ] ){
        return data;
    }
    
    if( [data isKindOfClass:[NSNumber class]] && _Cls == [NSString class])
    {
        return [(NSNumber *)data stringValue];
    }
    if( [data isKindOfClass:[NSString class]] && _Cls == [NSNumber class])
    {
        return [NSNumber numberWithDouble:[(NSString *)data doubleValue]];
    }

    NSString * reason = [NSString stringWithFormat:@"%@, 数据类型错误", [[data class] description]];
    
    @throw [[GsonException alloc] initWithName:@"解析错误" reason:reason userInfo:nil];
}

@end
