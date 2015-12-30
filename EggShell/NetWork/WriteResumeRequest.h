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

/*写简历工作经历阅览**/
+(AFRequestState*)resumeWritingPreviewWithSucc:(void(^)(NSDictionary * dataDic))succ resumeWritingPreviewParam:(NSDictionary *)param;
/*写简历教育经历阅览**/
+(AFRequestState*)rducationExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ educationExperienceReadingParam:(NSDictionary *)param;
/*写简历培训经历阅览**/
+(AFRequestState*)trainingExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ trainingExperienceReadingParam:(NSDictionary *)param;
/*写简历专业技能阅览**/
+(AFRequestState*)readingSkillWithSucc:(void(^)(NSDictionary * dataDic))succ readingSkillgParam:(NSDictionary *)param;

/*写简历项目经验阅览**/
+(AFRequestState*)projectExperienceReadingWithSucc:(void(^)(NSDictionary * dataDic))succ projectExperienceReadingParam:(NSDictionary *)param;

/*写简历证书阅览**/
+(AFRequestState*)certificatesReadingWithSucc:(void(^)(NSDictionary * dataDic))succ certificatesReadingParam:(NSDictionary *)param;


//使用简历
+(AFRequestState *)user_resumeWithSucc:(void(^)(NSDictionary *dataDic))succ withParam:(NSDictionary *)param;

//删除简历中得子项目 (type 1工作经历 2教育经历 3培训经历 4专业技能 5项目经验 6证书)
+(AFRequestState *)deleteResumeItemWithSucc:(void(^)(NSDictionary * dataDic))succ withToken:(NSString *)token uid:(NSString *)uid eid:(NSString *)eid withId:(NSString *)id type:(int)type;

//获取自我评价
+ (AFRequestState *)getSelfEvaluateWithSucc:(void(^)(NSDictionary * dataDic))succ uid:(NSString *)uid token:(NSString *)token;

@end
