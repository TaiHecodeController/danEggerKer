//
//  enterPriseRequest.h
//  EggShell
//
//  Created by 太和 on 15/11/25.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface enterPriseRequest : AFAppRequest

/*收到简历**/
+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))succ uid:(NSString *)uid is_browse:(int )is_browse pageIndex:(int)pageIndex page:(int)page resp:(Class)resp;

/*已查看**/
+(AFRequestState *)requestWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id;

/*待通知**/
+(AFRequestState *)requestWillNotifWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id;

/*不合适**/
+(AFRequestState *)requestUnadptedWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(int )eid job_id:(int )job_id com_id:(int)com_id;

/*删除简历**/
+(AFRequestState *)requestDeletResumeWithSucc:(void(^)(NSDictionary * DataDic))succ eid:(NSString *)eid job_id:(NSString *)job_id com_id:(int)com_id;

/*人才库**/
+(AFRequestState *)requestTanlentLibWithSucc:(void(^)(NSArray * DataDic))succ com_id:(int)com_id pageIndex:(int)pageIndex page:(int)page resp:(Class)resp;

/*人才库删除简历**/
+(AFRequestState *)requestDeletTanlentWithSucc:(void(^)(NSDictionary * DataDic))succ com_id:(int)com_id eid:(NSString *)eid;

@end
