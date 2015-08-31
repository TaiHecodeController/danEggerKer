//
//  AccountRequest.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/29.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountRequest : NSObject
///*注册**/
//+(void)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)userName WithPassword:(NSString *)password withSecurityCodee:(NSString *)SecurityCodee ;
//注册
+(void)RegisterRequestWithUserName:(NSString *)username PassWord:(NSString *)password withAccountName:(NSString *)accountName succ:(void (^)(NSDictionary *))succ;
//登录
+(void)loginRequestWithusername:(NSString * )username WithPassword:(NSString *)password withSucc:(void(^)(NSDictionary*))succ;
/*忘记密码**/
+(void)forgitRequestWithPhoneNum:(NSString *)phone withSucc:(void(^)(NSDictionary*))succ;
/*忘记密码下一步**/
+(void)forgitNextRequestWithPhoneNum:(NSString*)phone withSecurityCode:(NSString*)SecurityCode withSucc:(void(^)(NSDictionary*))succ;
/*重置密码**/
+(void)resetPasswordRequestWithPhoneNum:(NSString*)phone withNewCode:(NSString*)newCode  withSucc:(void(^)(NSDictionary*))succ;

@end
