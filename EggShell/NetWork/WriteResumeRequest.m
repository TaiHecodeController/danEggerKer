//
//  WriteResumeRequest.m
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeRequest.h"

@implementation WriteResumeRequest
+(AFRequestState *)getResumeListWithSucc:(void(^)(NSArray * DataArray))succ WithUserId:(NSString *)userId resp:(Class)resp;
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/resume_manager" param:@{@"uid":userId} succ:succ resp:resp];
    
}

+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/except" param:param succ:succ];
}

+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/except_select" param:nil succ:succ];
}

+(AFRequestState *)uploadWorkExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/resume_work" param:param succ:succ];
}

/*简历预览**/
+(AFRequestState*)biographyPreviewWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param withfail:(void (^)(int errCode, NSError * err))fail
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Except/resume_preview" param:param succ:succ fail:nil];

}
@end
