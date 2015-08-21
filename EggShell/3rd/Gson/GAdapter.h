//
//  GAdapter.h
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class GAdapter;

struct _ItemDscrp
{
    Class cls;
    objc_property_t * prop;
    Class itemCls;
};

typedef struct _ItemDscrp ItemDscrp;

@interface GFactory : NSObject

-(GAdapter *) make:(Class)cls Property:(ItemDscrp *)prop;
+(GAdapter *) makeAdapter:(Class)cls Property:(ItemDscrp *)prop;

@end

@interface GAdapter : NSObject

-(id)load:(id)data;

@end
