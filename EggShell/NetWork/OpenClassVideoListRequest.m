//
//  OpenClassVideoListRequest.m
//  EggShell
//
//  Created by 太和 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "OpenClassVideoListRequest.h"

@implementation OpenClassVideoListRequest

+(AFRequestState *)requestWithSucc:(void(^)(NSDictionary * DataDic))succ resp:(Class)resp paramPage:(NSString *)page Pagesize:(NSString *)pageSie
{
    NSDictionary * param = @{@"pagesize":pageSie,@"page":page};

    return [self postRequestWithUrl:@"http://ceshi.tiahel.com/eggker/interface/api.php/video/getPageList" param:param succ:succ resp:resp];
//     return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/api.php/video/getPageList" param:param succ:succ resp:resp];
}

+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))suc resp:(Class)resp paramWithId:(NSString *)id
{
    
    NSDictionary *param = @{@"id":id};
    return [self postRequestWithUrl:@"http://ceshi.tiahel.com/eggker/interface/API.php/video/getGroup" param:param succ:suc resp:resp];
//    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/API.php/video/getGroup" param:param succ:suc resp:resp];
}

/*名师风采**/
+(AFRequestState *)requestTeacherWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp paramPage:(NSString *)page Pagesize:(NSString *)pageSie
{
    NSDictionary * param = @{@"pagesize":pageSie,@"page":page};
    return [self postRequestWithUrl:@"http://195.198.1.211/eggker/interface/api.php/video/getPageList" param:param succ:succ resp:resp];
}

@end
