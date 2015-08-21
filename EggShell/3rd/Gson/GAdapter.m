//
//  GAdapter.m
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "GAdapter.h"
#import "GVarAdapter.h"
#import "GArrayAdapter.h"
#import "GObjAdapter.h"

@interface GFactorySet : NSObject

@property NSMutableDictionary * AdapterCache;
@property NSMutableArray * FactoryArray;

+(GFactorySet *)inst;
-(id)init;

@end

@implementation GFactorySet

+(GFactorySet *)inst
{
    static GFactorySet * sInst;
    
    if( sInst == nil ){
        sInst = [GFactorySet new];
    }
    
    return sInst;
}

-(id)init
{
    self = [super init];
    
    _AdapterCache = [NSMutableDictionary new];
    _FactoryArray = [NSMutableArray new];

    [_FactoryArray addObject:[GArrayFactory new]];
    [_FactoryArray addObject:[GVarFactory new]];
    [_FactoryArray addObject:[GObjFactory new]];
    
    return self;
}

@end

@implementation GFactory
+(GAdapter *) makeAdapter:(Class)cls;
{
    return [self makeAdapter:cls Property:nil];
}

+(GAdapter *) makeAdapter:(Class)cls Property:(ItemDscrp *)prop;
{
    GAdapter * Ad = (GAdapter *)([GFactorySet inst].AdapterCache[cls]);
    
    if( Ad != nil ){
        return Ad;
    }
    
    for( GFactory * fac in [GFactorySet inst].FactoryArray )
    {
        Ad = [fac make:cls Property:prop];
        
        if( Ad != nil )
        {
            if( cls != [NSArray class] && cls != [NSMutableArray class]){
                [GFactorySet inst].AdapterCache[(id)cls] = Ad;
            }
            
            return Ad;
        }
    }
    
    return Ad;
}

-(GAdapter *) make:(Class)cls Property:(ItemDscrp *)prop
{
    return nil;
}

@end

@implementation GAdapter
-(id)load:(id)data
{
    return nil;
}
@end
