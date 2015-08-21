//
//  GObjAdapter.h
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "GAdapter.h"

@interface GObjFactory : GFactory
@end

@interface GObjAdapter : GAdapter

@property Class ObjCls;
@property NSMutableDictionary * MemberDic;
@property GObjAdapter * SuperAdapter;
@property BOOL callDidLoad;
@end