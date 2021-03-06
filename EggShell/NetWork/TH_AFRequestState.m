//
//  TH_AFRequestState.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_AFRequestState.h"

@implementation TH_AFRequestState
//玩出范
+(AFRequestState *)playClassrRequestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp withPage:(int)pageNumber withLimit:(int)limit withType:(int)type
{
    NSNumber * pagenumber = [NSNumber numberWithInt:pageNumber];
    NSNumber * limitNum = [NSNumber numberWithInt:limit];
    NSNumber * typeNum = [NSNumber numberWithInt:type];
    
    NSDictionary * param = @{@"page":pagenumber,@"limit":limitNum,@"type":typeNum};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/index",base_Url] param:param succ:succ resp:resp];
    
}

+(AFRequestState *)loveActivityRequestListWithSucc:(void(^)(NSDictionary * DataDic))succ resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type
{
    NSNumber * pagenumber = [NSNumber numberWithInt:pageNumber];
    NSNumber * limitNum = [NSNumber numberWithInt:limit];
    NSNumber * typeNum = [NSNumber numberWithInt:type];
    
    NSDictionary * param = @{@"page":pagenumber,@"limit":limitNum,@"type":typeNum};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/act",base_Url] param:param succ:succ resp:resp];
}


+(AFRequestState *)collectRequestWithSucc:(void(^)(NSDictionary *DataDic))succ resp:(Class)resp activeId:(NSString *)activeId uid:(NSString *)uid token:(NSString *)token

{
    NSDictionary * param = @{@"id":activeId,@"uid":uid,@"token":token};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/act_collect",base_Url] param:param succ:succ resp:resp];
}

+(AFRequestState *)signUpRequestWithSucc:(void(^)(NSDictionary *DataDic))succ resp:(Class)resp activeId:(NSString *)activeId uid:(NSString *)uid token:(NSString *)token

{
    NSDictionary * param = @{@"id":activeId,@"uid":uid,@"token":token};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/act_apply",base_Url] param:param succ:succ resp:resp];

}

/*玩出范详情**/
+(AFRequestState *)playClassDetailRequestWithSucc:(void(^)(NSArray * dataDic))succ withType:(int)type withId:(int) classId
{

    NSNumber * typeNum =[NSNumber numberWithBool:type];
    NSNumber  * classID = [NSNumber numberWithInt:classId];
    NSDictionary * param = @{@"type":typeNum,@"id":classID};
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/details",base_Url] param:param succ:succ];
}

/*意见反馈**/
+(AFRequestState*)feedbackReRequestWithSucc:(void(^)( NSDictionary * DataDic))succ   withSource:(int)source withOpinion:(NSString*)opinion withqq:(NSString*)qq withEmail:(NSString*)email
{
    NSNumber * num = [NSNumber numberWithInt:source];
  NSDictionary * param = @{@"source":num ,@"opinion":opinion,@"qq":qq,@"email":email};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@feedback",base_Url] param:param succ:succ];
   

}

/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)pageNumber resp:(Class)resp
{
    NSNumber * numPager = [NSNumber numberWithInt:pageNumber];
    NSNumber * limit = [NSNumber numberWithInt:3];
    NSDictionary * param = @{@"page":numPager,@"limit":limit};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/loadMore",base_Url] param:param succ:succ fail:fail resp:resp];
    

}
/*职位详情**/
+(AFRequestState* )jobDetailsRequestWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode, NSError *err))fail withId:(int)id pid:(int)pid page:(int)page resp:(Class)resp
{
    
    NSNumber *numid = [NSNumber numberWithInt:id];
    NSNumber *numpid = [NSNumber numberWithInt:pid];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];

    NSString * userUid = [df objectForKey:@"uid"];
    
    if([userUid length]==0)
    {
    userUid = @"";
    }
    if([[df objectForKey:@"md5_token"] length]==0)
    {
    tokenStr = @"";
    }
    NSDictionary *param = @{@"id":numid,@"pid":numpid,@"uid":userUid,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/details",base_Url] param:param succ:succ fail:fail resp:resp];
    
}

/*收藏职位**/
+(AFRequestState *)saveJobWithSucc:(void(^)(NSDictionary *DataArr))succ withFail:(void(^)(int errCode, NSError *err))fail withJob_id:(int)job_id resp:(Class)resp
{
    NSNumber *jobid = [NSNumber numberWithInt:job_id];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userId =[df objectForKey:@"uid"];
    
    if ([userId length]==0) {
        userId = @"";
    }
    NSDictionary *param = @{@"job_id":jobid,@"uid":userId,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/collect",base_Url]param:param succ:succ fail:fail resp:resp];
    
}

/*收藏职位列表**/
+(AFRequestState *)saveJobListSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid page:(int)page limit:(int)limit resp:(Class)resp
{
    NSNumber *nspage = [NSNumber numberWithInt:page];
    NSNumber *nslimit = [NSNumber numberWithInt:limit];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * userId =[df objectForKey:@"uid"];
     NSString * tokenStr = [df objectForKey:@"md5_token"];
    if ([userId length]==0) {
        userId = @"";
    }
    
    NSDictionary *param = @{@"uid":userId,@"page":nspage,@"limit":nslimit,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/collectlist",base_Url] param:param succ:succ fail:fail resp:resp];
    
}

/*删除申请职位**/
+(AFRequestState *)deleteSQJobWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_idStr:(NSString *)job_idStr resp:(Class)resp
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * userId =[df objectForKey:@"uid"];
    NSString * tokenStr = [df objectForKey:@"md5_token"];

    if ([userId length]==0) {
        userId = @"";
    }
    NSDictionary *param = @{@"uid":userId,@"job_id":job_idStr,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/delgetPosition",base_Url] param:param succ:succ fail:fail resp:resp];
}

/*删除收藏职位**/
+(AFRequestState *)deleteJobWithSucc:(void(^)(NSDictionary *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_idStr:(NSString *)job_idStr resp:(Class)resp
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * userId =[df objectForKey:@"uid"];
    NSString * tokenStr = [df objectForKey:@"md5_token"];

    if ([userId length]==0) {
        userId = @"";
    }
    NSDictionary *param = @{@"uid":userId,@"job_id":job_idStr,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/delcollectlist",base_Url] param:param succ:succ fail:fail resp:resp];

}

/*申请职位**/
+(AFRequestState *)SQJobWithSucc:(void(^)(NSString *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid job_id:(NSString *)job_id resp:(Class)resp
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
     NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSDictionary *param = @{@"uid":[df objectForKey:@"uid"],@"job_id":job_id,@"token":tokenStr};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/getPosition",base_Url] param:param succ:succ fail:fail resp:resp];
}

/*轮播图**/
+(AFRequestState*)CarouselFigureRequestWithSucc:(void(^)(NSDictionary *arr))succ withfail:(void(^)(int errCode, NSError *err))fail
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@lunbo",base_Url] param:nil succ:succ fail:fail];
    
}
/*信息台**/
+(AFRequestState*)InformationDeskRequestWithSucc:(void(^)(NSArray * arr))succ  resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit withType:(int)type;
{
    NSNumber * pageNum =[NSNumber numberWithInt:pageNumber];
    NSNumber * limitNum =[NSNumber numberWithInt:limit];
    NSNumber * typeNum =[NSNumber numberWithInt:type];
    NSDictionary * param = @{@"page":pageNum,@"limit":limitNum,@"type":typeNum};

    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Infos/index",base_Url]param:param succ:succ resp:resp];
}

/*名企推荐**/
+(AFRequestState*)PrivateRecommendationWithSucc:(void(^)(NSDictionary * arr))succ
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/recommend_company",base_Url] param:nil succ:succ];
}

//名企详情
+(AFRequestState*)famousEnterprisesDetailWithSucc:(void(^)(NSDictionary * arr))succ withd:(NSDictionary*)dic
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/company_detail",base_Url] param:dic succ:succ];
}

/*职位搜索**/
+(AFRequestState *)searchJobWithSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withlongitude:(NSString *)longitude dimensionality:(NSString *)dimensionality keyword:(NSString *)keyword page:(NSString *)page hy:(NSString *)hy job_post:(NSString *)job_post salary:(NSString *)salary edu:(NSString *)edu exp:(NSString *)exp type:(NSString *)type sdate:(NSString *)sdate job1:(NSString *)job1 cityid:(NSString *)cityid provinceid:(NSString *)provinceid job1_post:(NSString *)job1_post resp:(Class)resp
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
    if (sdate.length == 0)
    {
        sdate = @"";
    }
    if (job1.length == 0)
    {
        job1 = @"";
    }
    if (cityid.length == 0)
    {
        cityid = @"";
    }
    if (provinceid.length == 0)
    {
        provinceid = @"";
    }if (job1_post.length==0) {
        job1_post = @"";
    }

    //job1废弃了，以后删除
    NSDictionary *param = @{@"longitude":longitude,@"dimensionality":dimensionality,@"keyword":keyword,@"page":page,@"hy":hy,@"job_post":job_post,@"salary":salary,@"edu":edu,@"exp":exp,@"type":type,@"fbtime":sdate,@"job1":job1,@"three_cityid":cityid,@"provinceid":provinceid,@"job1_son":job1_post};

    NSLog(@"%@",param);
    
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/nearbycompany",base_Url] param:param succ:succ fail:fail resp:resp];

}
//V达人
+(AFRequestState*)eggshellAmbassadorWithSucc:(void(^)(NSDictionary * arr))succ withd:(NSDictionary*)dic
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Vtalent",base_Url] param:dic succ:succ];
}
//社交圈
+(AFRequestState*)socialCircleWithSucc:(void(^)(NSDictionary * arr))succ withd:(NSDictionary*)dic
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Cricle",base_Url] param:dic succ:succ];

}
//企业全部职位列表
+(AFRequestState*)EnterpriseFullPositionWithSucc:(void(^)( NSArray * dic))succ withd:(NSDictionary*)dic resp:(Class)resp
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/releasejob",base_Url] param:dic succ:succ resp:resp];
}

/*版本更新**/
+(AFRequestState*)versionUpdataWithSucc:(void(^)(NSDictionary * dic))succ withd:(NSDictionary*)dic
{
 return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Update/index",base_Url] param:dic succ:succ ];
}
/*活动详情**/
+(AFRequestState*)activityWithSucc:(void(^)(NSDictionary * dic))succ withd:(NSDictionary*)dic
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/actdetail",base_Url] param:dic succ:succ ];
}
//活动收藏报名
+(AFRequestState*)activityRegistrationFavoritesWithSucc:(void(^)(NSArray * dic))succ withd:(NSDictionary*)dic resp:(Class)resp
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Activity/my_act",base_Url] param:dic succ:succ resp:resp];
}
@end
