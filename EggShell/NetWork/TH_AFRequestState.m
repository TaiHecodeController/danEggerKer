//
//  TH_AFRequestState.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_AFRequestState.h"
#define base_Url @"http://195.198.1.120/eggker"
@implementation TH_AFRequestState
//玩出范
+(AFRequestState *)playClassrRequestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp withPage:(int)pageNumber withLimit:(int)limit withType:(int)type
{
    NSNumber * pagenumber = [NSNumber numberWithInt:pageNumber];
    NSNumber * limitNum = [NSNumber numberWithInt:limit];
    NSNumber * typeNum = [NSNumber numberWithInt:type];
    
    NSDictionary * param = @{@"page":pagenumber,@"limit":limitNum,@"type":typeNum};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Activity/index" param:param succ:succ resp:resp];
    
}
/*玩出范详情**/
+(AFRequestState *)playClassDetailRequestWithSucc:(void(^)(NSArray * dataDic))succ withType:(int)type withId:(int) classId
{

    NSNumber * typeNum =[NSNumber numberWithBool:type];
    NSNumber  * classID = [NSNumber numberWithInt:classId];
    NSDictionary * param = @{@"type":typeNum,@"id":classID};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Activity/details" param:param succ:succ];
}

/*意见反馈**/
+(AFRequestState*)feedbackReRequestWithSucc:(void(^)( NSDictionary * DataDic))succ   withSource:(int)source withOpinion:(NSString*)opinion withqq:(NSString*)qq withEmail:(NSString*)email withfail:(void (^)(int errCode, NSError * err))fail
{
    NSNumber * num = [NSNumber numberWithInt:source];
    
    
  NSDictionary * param = @{@"source":num ,@"opinion":opinion,@"qq":qq,@"email":email};
    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/feedback" param:param succ:succ fail:fail];
   

}

/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)pageNumber resp:(Class)resp
{
    NSNumber * numPager = [NSNumber numberWithInt:pageNumber];
    NSNumber * limit = [NSNumber numberWithInt:3];
    NSDictionary * param = @{@"page":numPager,@"limit":limit};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/loadMore" param:param succ:succ fail:fail resp:resp];
    
}

/*职位详情**/
+(AFRequestState* )jobDetailsRequestWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode, NSError *err))fail withId:(int)id pid:(int)pid resp:(Class)resp
{
    NSNumber *numid = [NSNumber numberWithInt:id];
    NSNumber *numpid = [NSNumber numberWithInt:pid];
    NSDictionary *param = @{@"id":numid,@"pid":numpid};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/details" param:param succ:succ fail:fail resp:resp];
    
}

/*收藏职位**/
+(AFRequestState *)saveJobWithSucc:(void(^)(NSDictionary *DataArr))succ withFail:(void(^)(int errCode, NSError *err))fail withJob_id:(int)job_id resp:(Class)resp
{
    NSNumber *jobid = [NSNumber numberWithInt:job_id];
    NSNumber *uid = [NSNumber numberWithInt:6];
    NSDictionary *param = @{@"job_id":jobid,@"uid":uid};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/collect" param:param succ:succ fail:fail resp:resp];
}

/*收藏职位列表**/
+(AFRequestState *)saveJobListSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid page:(int)page limit:(int)limit resp:(Class)resp
{
    NSNumber *nsuid = [NSNumber numberWithInt:6];
    NSNumber *nspage = [NSNumber numberWithInt:page];
    NSNumber *nslimit = [NSNumber numberWithInt:limit];
    NSDictionary *param = @{@"uid":nsuid,@"page":nspage,@"limit":nslimit};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/collectlist" param:param succ:succ fail:fail resp:resp];
    
}

/*删除职位**/
+(AFRequestState *)deleteJobWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_idStr:(NSString *)job_idStr resp:(Class)resp
{
    NSNumber *nsuid = [NSNumber numberWithInt:uid];
    NSDictionary *param = @{@"uid":nsuid,@"id":job_idStr};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/delcollectlist" param:param succ:succ fail:fail resp:resp];

}

/*申请职位**/
+(AFRequestState *)SQJobWithSucc:(void(^)(NSString *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_id:(NSString *)job_id resp:(Class)resp
{
    
    NSNumber *nsuid = [NSNumber numberWithInt:uid];
    NSDictionary *param = @{@"uid":nsuid,@"job_id":job_id};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/getPosition" param:param succ:succ fail:fail resp:resp];
}
/*轮播图**/
+(AFRequestState*)CarouselFigureRequestWithSucc:(void(^)(NSDictionary *arr))succ withfail:(void(^)(int errCode, NSError *err))fail
{

    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/lunbo" param:nil succ:succ fail:fail];
}
/*信息台**/
+(AFRequestState*)InformationDeskRequestWithSucc:(void(^)(NSArray * arr))succ  resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type;
{
    NSNumber * pageNum =[NSNumber numberWithInt:pageNumber];
    NSNumber * limitNum =[NSNumber numberWithInt:limit];
    NSNumber * typeNum =[NSNumber numberWithInt:type];
    NSDictionary * param = @{@"page":pageNum,@"limit":limitNum,@"type":typeNum};

    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Infos/index" param:param succ:succ resp:resp];
}
/*名企推荐**/
+(AFRequestState*)PrivateRecommendationWithSucc:(void(^)(NSDictionary * arr))succ
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Position/recommend_company" param:nil succ:succ];
}
//名企详情
+(AFRequestState*)famousEnterprisesDetailWithSucc:(void(^)(NSDictionary * arr))succ withd:(NSDictionary*)dic
{
    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/Position/company_detail" param:dic succ:succ];
//=======
//    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Activity/index" param:param succ:succ resp:resp];
}

/*职位搜索**/
+(AFRequestState *)searchJobWithSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withlongitude:(NSString *)longitude dimensionality:(NSString *)dimensionality keyword:(NSString *)keyword page:(NSString *)page hy:(NSString *)hy job_post:(NSString *)job_post salary:(NSString *)salary edu:(NSString *)edu exp:(NSString *)exp type:(NSString *)type resp:(Class)resp
{
    
    if (longitude.length == 0)
    {
        longitude = @"";
    }
    
    if (dimensionality.length == 0)
    {
        dimensionality = @"";
    }
    
    if (keyword.length == 0)
    {
        keyword = @"";
    }
    
    if (page.length == 0)
    {
        page = @"";
    }
    
    if (hy.length == 0)
    {
        hy = @"";
    }
    
    if (job_post.length == 0)
    {
        job_post = @"";
    }
    
    if (salary.length == 0)
    {
        salary = @"";
    }
    if (edu.length == 0)
    {
        edu = @"";
    }
    if (exp.length == 0)
    {
        exp = @"";
    }
    if (type.length == 0)
    {
        type = @"";
    }
    
    NSDictionary *param = @{@"longitude":longitude,@"dimensionality":dimensionality,@"keyword":keyword,@"page":page,@"hy":hy,@"job_post":job_post,@"salary":salary,@"edu":edu,@"exp":exp,@"type":type};
    return [self postRequestWithUrl:@"http://195.198.1.84/eggker/interface/Position/nearbycompany" param:param succ:succ fail:fail resp:resp];

}
@end
