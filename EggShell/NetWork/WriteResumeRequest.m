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
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_manager",base_Url] param:@{@"uid":[df objectForKey:@"uid"]} succ:succ resp:resp];
    
}

//搜索职位筛选列表
+(AFRequestState *)getSearchJobMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/except_select",base_Url] param:nil succ:succ];
//    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Position/except_select" param:nil succ:succ];
}

//简历筛选
+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except_select",base_Url] param:nil succ:succ];
}


+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except",base_Url] param:param succ:succ];
}



+(AFRequestState *)uploadWorkExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_work",base_Url] param:param succ:succ];
}


/*简历预览**/
+(AFRequestState*)biographyPreviewWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param withfail:(void (^)(int errCode, NSError * err))fail
{
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_preview",base_Url] param:param succ:succ fail:nil];
}

+(AFRequestState *)uploadEducationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_edu",base_Url] param:param succ:succ];
}

+(AFRequestState *)uploadTrainWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_training",base_Url] param:param succ:succ];
}

+(AFRequestState *)uploadProfessionalSkillWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_skill",base_Url] param:param succ:succ];
}

+(AFRequestState *)uploadProjectExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_project",base_Url] param:param succ:succ];
}

+(AFRequestState *)uploadCertificateWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_cert",base_Url] param:param succ:succ];
}

+(AFRequestState *)uploadSelfEvaluationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_other",base_Url] param:param succ:succ];
}

+(AFRequestState *)deleteResumeWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_del",base_Url] param:param succ:succ];
}

@end
