//
//  GObjAdapter.m
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "Gson.h"
#import "GObjAdapter.h"
#import <objc/runtime.h>
#import "Expose.h"

@interface EmptyExpose : NSObject<Expose>
@end

@implementation EmptyExpose
@end

@implementation GObjFactory

+(GObjAdapter *)inst:(GObjAdapter *) obj
{
    static GObjAdapter * inst = nil;
    if( inst == nil ){
        inst = obj;
    }

    return inst;
}

-(id)init
{
    self = [super self];
    
    
    return self;
}

-(GAdapter *) make:(Class)cls Property:(ItemDscrp *)prop
{
    if ( ! class_conformsToProtocol(cls, @protocol(Expose))) {
        return nil;
    }

    static unsigned int defaultPropCount;
    
    if( defaultPropCount == 0 ){
        objc_property_t * p = class_copyPropertyList([EmptyExpose class], &defaultPropCount);
        free(p);
    }
    
    unsigned int outCount;
    objc_property_t * list = class_copyPropertyList(cls, &outCount);
    
    if( outCount < defaultPropCount ){
        return nil;
    }
    
    GObjAdapter * ad = [GObjAdapter new];
    ad.ObjCls = cls;
    
    ItemDscrp item;
    item.cls = cls;
    item.itemCls = nil;
    
    for( int i = 0; i < outCount - defaultPropCount; i++ )
    {
        const char * name = property_getName(list[i]);
        const char * attr = property_getAttributes(list[i]);
        
        NSString * strAttr = [NSString stringWithUTF8String:attr];
        
        NSRange range = [strAttr rangeOfString:@","];
        
        if( range.location <= 1 ){
            continue;
        }
        
        NSString * type = [strAttr substringWithRange:NSMakeRange(1, range.location - 1)];
        
        GAdapter * itemAd = nil;
        item.prop = list + i;
        
        if( [type hasPrefix:@"@"] ){
            if( [type isEqualToString:@"T@"]){
                itemAd = [GFactory makeAdapter:[NSObject class] Property:&item];
            }
            else{
                NSString * itemCls = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                
                itemAd = [GFactory makeAdapter:NSClassFromString(itemCls) Property:&item];
            }
        }
        else{
            itemAd = [GFactory makeAdapter:[NSNumber class] Property:&item];
        }

        if( itemAd != nil ){
            ad.MemberDic[[NSString stringWithUTF8String:name]] = itemAd;
        }
    }
    
    free(list);
    
    Class superCls = class_getSuperclass(ad.ObjCls);
    GAdapter * superAd = nil;
    
    while(superCls != [NSObject class]){
        if( class_conformsToProtocol(superCls, @protocol(Expose)) ){
            superAd = [GFactory makeAdapter:superCls Property:prop];
            
            if( superAd != nil && [superAd isMemberOfClass:[GObjAdapter class]]){
                ad.SuperAdapter = (GObjAdapter *)superAd;
                break;
            }
        }
        
        superCls = class_getSuperclass(superCls);
    }

    ad.callDidLoad = class_respondsToSelector(ad.ObjCls, @selector(didLoad));
    
    return ad;
}

@end

#pragma mark object adapter

@interface GObjAdapter()
-(id)loadObjFromDic:(NSDictionary *)dic Obj:(id)obj;

@end

@implementation GObjAdapter

-(id)init
{
    self = [super init];
    
    _MemberDic = [NSMutableDictionary new];
    
    return self;
}

-(id)load:(id)data
{
    if([data isKindOfClass:[NSNull class]]){
        return nil;
    }
    
    if( ! [data isKindOfClass:[NSDictionary class]] )
    {
        NSString * reason = [NSString stringWithFormat:@"%@, 数据类型错误", [[data class] description]];

        @throw [[GsonException alloc] initWithName:@"解析错误" reason:reason userInfo:nil];
    }
    
    NSObject * Obj = [_ObjCls new];
    [self loadObjFromDic:data Obj:Obj];
    
    if( _callDidLoad ){
        [Obj performSelector:@selector(didLoad)];
    }
    
    return Obj;
}

-(id)loadObjFromDic:(NSDictionary *)dic Obj:(id)obj
{
    for (NSString * name in _MemberDic)
    {
        GAdapter * ad = _MemberDic[name];
        
        id item = dic[name];
        if( item == nil ){
            continue;
        }
        
        @try{
            [obj setValue:[ad load:item] forKey:name];
        }
        @catch(GsonException * excp){
            NSString * reason = [NSString stringWithFormat:@"字段%@ : %@", name, excp.reason];
            
            @throw [[GsonException alloc] initWithName:@"解析错误" reason:reason userInfo:nil];
        }
    }

    if( _SuperAdapter != nil ){
        [_SuperAdapter loadObjFromDic:dic Obj:obj];
    }
    
    return obj;
}

@end
