//
//  OpenClassVideoListRequest.h
//  EggShell
//
//  Created by 太和 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface OpenClassVideoListRequest : AFAppRequest

+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp;
@end
