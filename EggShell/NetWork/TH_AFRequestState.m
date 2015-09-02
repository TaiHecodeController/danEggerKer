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
/*职位列表**/
+(AFRequestState* )jobListReRequestWithSucc:(void(^)(NSArray * DataDic))succ withfail:(void (^)(int errCode, NSError * err))fail withPageNumber:(int)pageNumber resp:(Class)resp
{NSNumber * numPager = [NSNumber numberWithInt:pageNumber];
    NSDictionary * param = @{@"page":numPager};
//    return [self postRequestWithUrl:@"http://195.198.1.83/eggker/interface/Position/loadMore/" param:param succ:succ fail:false ];
    return [self postRequestWithUrl:@"http://195.198.1.83/eggker/interface/Position/loadMore/" param:param succ:succ fail:fail resp:resp];
 }
/*意见反馈**/
+(AFRequestState*)feedbackReRequestWithSucc:(void(^)(NSArray * DataDic))succ withUserId:(NSString * )userId withContent:(NSDictionary*)contenDic withfail:(void (^)(int errCode, NSError * err))fail
{
    NSDictionary * param = @{@"uid":userId,@"descriptionContent":contenDic};
    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/feedback" param:param succ:succ fail:fail];

}

@end
