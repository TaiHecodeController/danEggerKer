//
//  WriteResumeRequest.h
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"

@interface WriteResumeRequest : AFAppRequest
//简历选择信息列表
+(AFRequestState *)getResumeMessageListWithSucc:(void(^)(NSDictionary * DataDic))succ;
//简历列表
+(AFRequestState *)getResumeListWithSucc:(void(^)(NSArray * DataArray))succ WithUserId:(NSString *)userId resp:(Class)resp;
//上传用户所填信息
+(AFRequestState *)uploadResumeMessageAboutUserMessageWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param;

+(AFRequestState *)uploadWorkExperienceWithSucc:(void(^)(NSDictionary * dataDic))succ WithResumeParam:(NSDictionary *)param;
/*简历预览**/
+(AFRequestState*)biographyPreviewWithSucc:(void(^)(NSDictionary * DataDic))succ WithResumeParam:(NSDictionary *)param withfail:(void (^)(int errCode, NSError * err))fail;

@end
