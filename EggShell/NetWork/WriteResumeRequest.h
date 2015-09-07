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
//简历列表
+(AFRequestState *)getResumeListWithSucc:(void(^)(NSArray * DataArray))succ WithUserId:(NSString *)userId resp:(Class)resp;
//上传用户所填信息
+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param;
//上传工作经历
+(AFRequestState *)uploadWorkExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;

/*简历预览**/
+(AFRequestState*)biographyPreviewWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param withfail:(void (^)(int errCode, NSError * err))fail;

//上传教育经历
+(AFRequestState *)uploadEducationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//上传培训经历
+(AFRequestState *)uploadTrainWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//上传专业技能
+(AFRequestState *)uploadProfessionalSkillWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//上传项目经验
+(AFRequestState *)uploadProjectExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//上传证书
+(AFRequestState *)uploadCertificateWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//自我评价
+(AFRequestState *)uploadSelfEvaluationWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//删除简历
+(AFRequestState *)deleteResumeWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
//搜索职位筛选列表
+(AFRequestState *)getSearchJobMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ;


@end
