//
//  LoginRequest.h
//  EggShell
//
//  Created by mac on 15/7/27.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"


@interface LoginAndRegisterRequest : AFAppRequest


+(AFRequestState *)loginWithSucc:(void(^)(NSDictionary * DataDic))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password;
/*获取验证码**/
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)phonenumber WithPassword:(NSString *)password withSecurityCode:(NSString *)SecurityCode;
/*注册**/
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)userName WithPassword:(NSString *)password withSecurityCodee:(NSString *)SecurityCodee ;

@end
