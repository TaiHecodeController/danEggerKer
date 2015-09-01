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
+(AFRequestState *)playClassrRequestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp withPage:(NSString *)pageNumber;
{
    NSDictionary * param = @{@"page":pageNumber};
    return [self postRequestWithUrl:@"http://195.198.1.122:8066/eggker/phpyun/api/admin/index.php?m=act&c=list" param:param succ:succ resp:resp];
    
}
/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)pageNumber resp:(Class)resp
{NSNumber * numPager = [NSNumber numberWithInt:pageNumber];
    NSDictionary * param = @{@"page":numPager};
//    return [self postRequestWithUrl:@"http://195.198.1.83/eggker/interface/Position/loadMore/" param:param succ:succ fail:false ];
    return [self postRequestWithUrl:@"http://195.198.1.83/eggker/interface/Position/loadMore/" param:param succ:succ fail:fail resp:resp];
    



}

@end
