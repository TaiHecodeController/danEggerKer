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
+(AFRequestState *)playClassrRequestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp withPage:( int)pageNumber withLimit:(int)limit;
/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)Page resp:(Class)resp;


@end
