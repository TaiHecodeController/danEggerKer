//
//  enterPriseRequest.m
//  EggShell
//
//  Created by 太和 on 15/11/25.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "enterPriseRequest.h"

@implementation enterPriseRequest

+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))succ uid:(NSString *)uid is_browse:(int )is_browse pageIndex:(int)pageIndex page:(int)page resp:(Class)resp
{
    NSNumber *browse = [NSNumber numberWithInt:is_browse];
    NSNumber *numPageIndex = [NSNumber numberWithInt:pageIndex];
    NSNumber *numPage = [NSNumber numberWithInt:page];
    
    NSDictionary * param = @{@"uid":uid,@"is_browse":browse,@"pageIndex":numPageIndex,@"page":numPage};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/resumelist",base_Url] param:param succ:succ resp:resp];
}

+(AFRequestState *)requestWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id
{
    NSNumber *numeid = [NSNumber numberWithInt:eid];
    NSNumber *numjobid = [NSNumber numberWithInt:job_id];
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
    NSDictionary * param = @{@"eid":numeid,@"job_id":numjobid,@"com_id":numcomid};
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/lookedResume",base_Url] param:param succ:succ];
}

+(AFRequestState *)requestWillNotifWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id
{
    NSNumber *numeid = [NSNumber numberWithInt:eid];
    NSNumber *numjobid = [NSNumber numberWithInt:job_id];
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
    NSDictionary * param = @{@"eid":numeid,@"job_id":numjobid,@"com_id":numcomid};
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/willNotifeResume",base_Url] param:param succ:succ];
}

+(AFRequestState *)requestUnadptedWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id
{
    NSNumber *numeid = [NSNumber numberWithInt:eid];
    NSNumber *numjobid = [NSNumber numberWithInt:job_id];
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
    NSDictionary * param = @{@"eid":numeid,@"job_id":numjobid,@"com_id":numcomid};
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/unAdaptedResume",base_Url] param:param succ:succ];

}

+(AFRequestState *)requestDeletResumeWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(NSString *)eid job_id:(NSString *)job_id com_id:(int)com_id
{
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
    NSDictionary * param = @{@"eid":eid,@"job_id":job_id,@"com_id":numcomid};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/deleteResume",base_Url] param:param succ:succ];
}
/*全职职位暂停招聘刷新删除**/
+(AFRequestState *)FulltimeJobsPauseResumeWithSucc:(void(^)(NSDictionary * DataDic))succ withParam:(NSDictionary *)param
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/operatereleasejob",base_Url] param:param succ:succ];
}


+(AFRequestState *)requestTanlentLibWithSucc:(void(^)(NSArray * DataDic))succ com_id:(int)com_id pageIndex:(int)pageIndex page:(int)page resp:(Class)resp
{
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
    NSNumber *numPageIndex = [NSNumber numberWithInt:pageIndex];
    NSNumber *numPage = [NSNumber numberWithInt:page];
    
    NSDictionary * param = @{@"com_id":numcomid,@"pageIndex":numPageIndex,@"page":numPage};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/getRencaiLibList",base_Url] param:param succ:succ resp:resp];
}

+(AFRequestState *)requestDeletTanlentWithSucc:(void(^)(NSDictionary * DataDic))succ com_id:(int)com_id eid:(NSString *)eid
{
    NSNumber *numcomid = [NSNumber numberWithInt:com_id];
//    NSNumber *numeid = [NSNumber numberWithInt:eid];
    NSDictionary * param = @{@"com_id":numcomid,@"eid":eid};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Company/deleteResumeFromRencaiLib",base_Url] param:param succ:succ ];
}

@end
