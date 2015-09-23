//
//  WriteResumeRequest.m
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeRequest.h"

@implementation WriteResumeRequest
//简历列表
+(AFRequestState *)getResumeListWithSucc:(void(^)(NSArray * DataArray))succ WithUserId:(NSString *)userId resp:(Class)resp;
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_manager",base_Url] param:@{@"uid":[df objectForKey:@"uid"],@"token":tokenStr} succ:succ resp:resp];
}

//搜索职位筛选列表
+(AFRequestState *)getSearchJobMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/except_select",base_Url] param:nil succ:succ];
}

//简历选择信息列表
+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except_select",base_Url] param:nil succ:succ];
}

//上传用户所填信息
+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except",base_Url] param:param succ:succ];
    
}
//上传工作经历
+(AFRequestState *)uploadWorkExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_work",base_Url] param:param succ:succ];

}

/*简历预览**/
+(AFRequestState*)biographyPreviewWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param withfail:(void (^)(int errCode, NSError * err))fail
{
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_preview",base_Url] param:param succ:succ fail:nil];
}
//上传教育经历
+(AFRequestState *)uploadEducationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_edu",base_Url] param:param succ:succ];
}
//上传培训经历
+(AFRequestState *)uploadTrainWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_training",base_Url] param:param succ:succ];
}
//上传专业技能
+(AFRequestState *)uploadProfessionalSkillWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_skill",base_Url] param:param succ:succ];
}
//上传项目经验
+(AFRequestState *)uploadProjectExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_project",base_Url] param:param succ:succ];
}
//上传证书
+(AFRequestState *)uploadCertificateWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_cert",base_Url] param:param succ:succ];
}
//自我评价
+(AFRequestState *)uploadSelfEvaluationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_other",base_Url] param:param succ:succ];
}

//删除简历
+(AFRequestState *)deleteResumeWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_del",base_Url] param:param succ:succ];
}
/*写简历工作经历阅览**/
+(AFRequestState*)resumeWritingPreviewWithSucc:(void(^)(NSDictionary * dataDic))succ resumeWritingPreviewParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/work_list",base_Url] param:param succ:succ];
}
/*写简历教育经历阅览**/
+(AFRequestState*)rducationExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ educationExperienceReadingParam:(NSDictionary *)param
{
     return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/edu_list",base_Url] param:param succ:succ];
}
/*写简历培训经历阅览**/
+(AFRequestState*)trainingExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ trainingExperienceReadingParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/training_list",base_Url] param:param succ:succ];
}
/*写简历专业技能阅览**/
+(AFRequestState*)readingSkillWithSucc:(void(^)(NSDictionary * dataDic))succ readingSkillgParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/skill_list",base_Url] param:param succ:succ];
}

/*写简历项目经验阅览**/
+(AFRequestState*)projectExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ projectExperienceReadingParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/project_list",base_Url] param:param succ:succ];
}

/*写简历证书阅览**/
+(AFRequestState*)certificatesReadingWithSucc:(void(^)(NSDictionary * dataDic))succ certificatesReadingParam:(NSDictionary *)param
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/cert_list",base_Url] param:param succ:succ];
}



//使用简历
+(AFRequestState *)user_resumeWithSucc:(void(^)(NSDictionary *dataDic))succ withParam:(NSDictionary *)param
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/resume_use",base_Url] param:param succ:succ];
}

@end
