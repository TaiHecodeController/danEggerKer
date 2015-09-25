//
//  OpenClassVideoListRequest.h
//  EggShell
//
//  Created by 太和 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface OpenClassVideoListRequest : AFAppRequest
/*公开课页面**/
+(AFRequestState *)requestWithSucc:(void(^)(NSDictionary * DataDic))succ resp:(Class)resp paramPage:(NSString *)page Pagesize:(NSString *)pageSie;
//课程列表
+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))suc resp:(Class)resp paramWithId:(NSString *)id;

/*名师风采**/
+(AFRequestState *)requestTeacherWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp paramPage:(NSString *)page Pagesize:(NSString *)pageSie;


@end
