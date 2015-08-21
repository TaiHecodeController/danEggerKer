//
//  OpenClassVideoListRequest.m
//  EggShell
//
//  Created by 太和 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "OpenClassVideoListRequest.h"

@implementation OpenClassVideoListRequest

+(AFRequestState *)requestWithSucc:(void(^)(NSArray * DataDic))succ resp:(Class)resp
{
    NSDictionary * param = nil;
    return [self postRequestWithUrl:@"http://195.198.1.122:8066/eggker/phpv/API.php/video/getListImage" param:param succ:succ resp:resp];
}

@end
