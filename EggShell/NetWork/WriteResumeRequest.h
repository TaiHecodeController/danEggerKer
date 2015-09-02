//
//  WriteResumeRequest.h
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface WriteResumeRequest : AFAppRequest
//简历选择信息列表
+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ;

@end
