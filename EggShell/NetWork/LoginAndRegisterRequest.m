//
//  LoginRequest.m
//  EggShell
//
//  Created by mac on 15/7/27.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "LoginAndRegisterRequest.h"
#import "MyMD5.h"

@implementation LoginAndRegisterRequest
+(AFRequestState *)loginWithSucc:(void(^)(NSDictionary * DataDic))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password
{
    //密码加密
    NSString * md5_passWord = [MyMD5 md5:password];
    NSDictionary * param = @{@"username":userName,@"pw":md5_passWord};
    return [self postRequestWithUrl:@"http://195.198.1.195/index.php?m=api" param:param succ:succ];
}
    
+(AFRequestState *)registerWithSucc:(void (^)(NSDictionary *))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password WithUserType:(int)userType WithSource:(int)source WithPhoneNum:(NSString *)phoneNum WithEmail:(NSString *)email
{
    NSString * md5_passWord = [MyMD5 md5:password];
    NSDictionary * param = @{@"username":userName,@"password":md5_passWord,@"usertype":@(userType),@"source":@(source),@"moblie":phoneNum,@"email":email};
    return [self postRequestWithUrl:@"http://195.198.1.195/index.php?m=api&c=res" param:param succ:succ];
}
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)phonenumber WithPassword:(NSString *)password withSecurityCode:(NSString *)SecurityCode
{
    
    NSDictionary * para = @{@"phonenumber":phonenumber,@"password":password,@"smscode":SecurityCode};
    return [self postRequestWithUrl:@"http://195.198.1.122:8066/eggker/interface/register" param:para succ:succ];

}



@end
