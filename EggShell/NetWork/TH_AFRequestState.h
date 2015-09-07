//
//  TH_AFRequestState.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface TH_AFRequestState : AFAppRequest
//公开课

//玩出范
+(AFRequestState *)playClassrRequestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type;
/*玩出范详情**/
+(AFRequestState *)playClassDetailRequestWithSucc:(void(^)(NSArray * dataDic))succ withType:(int)type withId:(int) classId;
/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)Page resp:(Class)resp;

/*意见反馈**/
+(AFRequestState*)feedbackReRequestWithSucc:(void(^)(NSDictionary * DataDic))succ   withSource:(int)source withOpinion:(NSString*)opinion withqq:(NSString*)qq withEmail:(NSString*)email withfail:(void (^)(int errCode, NSError * err))fail;

/*职位详情**/
+(AFRequestState* )jobDetailsRequestWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode, NSError *err))fail withId:(int)id pid:(int)pid page:(int)page resp:(Class)resp;

/*收藏职位**/
+(AFRequestState *)saveJobWithSucc:(void(^)(NSDictionary *DataArr))succ withFail:(void(^)(int errCode, NSError *err))fail withJob_id:(int)job_id resp:(Class)resp;

/*收藏职位列表**/
+(AFRequestState *)saveJobListSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid page:(int)page limit:(int)limit resp:(Class)resp;

/*删除职位**/
+(AFRequestState *)deleteJobWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_idStr:(NSString *)job_idStr resp:(Class)resp;

/*申请职位**/
+(AFRequestState *)SQJobWithSucc:(void(^)(NSString *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_id:(NSString *)job_id resp:(Class)resp;

/*职位搜索**/
+(AFRequestState *)searchJobWithSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withlongitude:(NSString *)longitude dimensionality:(NSString *)dimensionality keyword:(NSString *)keyword page:(NSString *)page hy:(NSString *)hy job_post:(NSString *)job_post salary:(NSString *)salary edu:(NSString *)edu exp:(NSString *)exp type:(NSString *)type sdate:(NSString *)sdate job1:(NSString *)job1 cityid:(NSString *)cityid resp:(Class)resp;

/*轮播图**/
+(AFRequestState*)CarouselFigureRequestWithSucc:(void(^)(NSDictionary * arr))succ withfail:(void(^)(int errCode, NSError *err))fail;
/*信息台**/

+(AFRequestState*)InformationDeskRequestWithSucc:(void(^)(NSArray * arr))succ  resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type;
/*名企推荐**/
+(AFRequestState*)PrivateRecommendationWithSucc:(void(^)(NSDictionary * arr))succ ;
//名企详情
+(AFRequestState*)famousEnterprisesDetailWithSucc:(void(^)(NSDictionary * arr))succ withd:(NSDictionary*)dic;

//+(AFRequestState*)InformationDeskRequestWithSucc:(void(^)(NSDictionary * arr))succ  resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type;


@end
