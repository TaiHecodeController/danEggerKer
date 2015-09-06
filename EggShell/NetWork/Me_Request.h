//
//  Me_Request.h
//  EggShell
//
//  Created by 太和 on 15/9/6.
//  Copyright (c) 2015年 wsd. All rights reserved.
//



#import "AFAppRequest.h"

@interface Me_Request : AFAppRequest
/*我的 模块所有接口**/

/*投递职位列表**/
+(AFRequestState *)TDjobListWithSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid page:(int)page limit:(int)limit resp:(Class)resp;

@end
