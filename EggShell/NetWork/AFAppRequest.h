//
//  AFAppRequest.h
//  EggShell
//
//  Created by mac on 15/7/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AFRequestState : NSObject

-(AFRequestState *)addNotifaction:(id)notify;
@property (readonly)BOOL running;
@end

@interface AFAppRequest : AFHTTPRequestOperationManager
//获取单例
+(AFHTTPRequestOperationManager *)sharedManager;
//函数设计：
//若失败block参数为空，表明到上层处理错误
//若resp参数为空，表明不确定转换类型

//缺少fail和resp参数
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ;
//缺少resp参数
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail;
//缺少fail参数
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ resp:(Class)resp;
//不缺参数
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;
//上传头像
+(AFRequestState *)postImageFlag:(BOOL)flag url:(NSString *)url succ:(void(^)(id img))succ WithData:(NSDictionary *)data withImg:(UIImage *)img fail:(void (^)(int errCode, NSError * err))fail;
@end
