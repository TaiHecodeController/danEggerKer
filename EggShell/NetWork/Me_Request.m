//
//  Me_Request.m
//  EggShell
//
//  Created by 太和 on 15/9/6.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "Me_Request.h"

@implementation Me_Request

/*投递职位列表**/
+(AFRequestState *)TDjobListWithSucc:(void(^)(NSArray *DataArr))succ withfail:(void(^)(int errCode,NSError *err))fail withUid:(int)uid page:(int)page limit:(int)limit resp:(Class)resp
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSLog(@"~~%@",[df objectForKey:@"uid"]);
    NSNumber *nspage = [NSNumber numberWithInt:page];
    NSNumber *nslimit = [NSNumber numberWithInt:limit];

   
    NSString * userId = [df objectForKey:@"uid"];
    if ([userId length]==0) {
        userId = @"";
    }
//    NSDictionary *param = @{@"uid":userId,@"page":nspage,@"limit":nslimit};
//    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/Position/getPositionlist" param:param succ:succ fail:fail resp:resp];
//=======
    
    NSDictionary *param = @{@"uid":userId,@"page":nspage,@"limit":nslimit};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Position/getPositionlist",base_Url] param:param succ:succ resp:resp];

}

@end
