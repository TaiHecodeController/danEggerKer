//
//  WriteResumeRequest.m
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeRequest.h"

@implementation WriteResumeRequest
+(AFRequestState *)getWriteResumeStaticDataWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:@"http://localhost/interface/Except/except" param:nil succ:succ];
    
}

+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:@"http://localhost/eggker/interface/Except/except" param:param succ:succ];
}

+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/except_select" param:nil succ:succ];
}
@end
