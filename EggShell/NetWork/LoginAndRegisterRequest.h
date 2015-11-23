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
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)userName WithPassword:(NSString *)password withSecurityCodee:(NSString *)SecurityCodee;
//登录
+(AFRequestState *)loginRequestWithusername:(NSString * )username WithPassword:(NSString *)password usertype :(int)usertype withSucc:(void(^)(NSDictionary*))succ ;
/*忘记密码**/
+(AFRequestState *)forgitRequestWithPhoneNum:(NSString *)phone withSucc:(void(^)(NSDictionary*))succ;
/*忘记密码下一步**/
+(AFRequestState *)forgitNextRequestWithPhoneNum:(NSString*)phone withSecurityCode:(NSString*)SecurityCode withSucc:(void(^)(NSDictionary*))succ;
/*重置密码**/
+(AFRequestState *)resetPasswordRequestWithPhoneNum:(NSString *)phone withNewCode:(NSString*)newCode  withSucc:(void(^)(NSDictionary*))succ;
/*头像上传**/
+(AFRequestState *)uploadImage:(void (^)(NSDictionary * ))succ :(UIImage *)inputImage withUid:(NSString*)uid ;
/*获取个人资料**/
+(AFRequestState *)getImagewithSucc:(void (^)(NSDictionary * ))succ withUid:(NSDictionary*)dic withFail:(void(^)(int errCode, NSError *err))fail;
/*编辑资料添加**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withParam:(NSDictionary*)dic;
/*编辑资料预览**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withuid:(NSDictionary*)uid;
/*企业忘记密码**/
+(AFRequestState *)enterpriseForgitRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ;
/*企业忘记密码下一步**/
+(AFRequestState *)enterpriseForgitNextRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ;
/*企业重置密码**/
+(AFRequestState *)enterpriseResetPasswordRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ;
@end
