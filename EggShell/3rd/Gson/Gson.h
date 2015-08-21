//
//  Gson.h
//  Gson
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Expose.h"

@interface GsonException : NSException

@end


@interface Gson : NSObject

+(id)fromJson:(NSString*)json Cls:(Class)cls;
+(id)fromObj:(NSDictionary*)json Cls:(Class)cls;

@end

#define array_item_def(name) +(Class)array_##name##_type;
#define array_item_impl(name, type) +(Class)array_##name##_type{return [type class];}
