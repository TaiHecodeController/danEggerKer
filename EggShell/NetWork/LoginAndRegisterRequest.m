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
    return [self postRequestWithUrl:@"http://195.198.1.211/index.php?m=api" param:param succ:succ];
}
    
+(AFRequestState *)registerWithSucc:(void (^)(NSDictionary *))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password WithUserType:(int)userType WithSource:(int)source WithPhoneNum:(NSString *)phoneNum WithEmail:(NSString *)email
{
    NSString * md5_passWord = [MyMD5 md5:password];
    NSDictionary * param = @{@"username":userName,@"password":md5_passWord,@"usertype":@(userType),@"source":@(source),@"moblie":phoneNum,@"email":email};
    return [self postRequestWithUrl:@"http://195.198.1.211/index.php?m=api&c=res" param:param succ:succ];
}
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)phonenumber WithPassword:(NSString *)password withSecurityCode:(NSString *)SecurityCode
{
    
    NSDictionary * para = @{@"telphone":phonenumber,@"password":password,@"smscode":SecurityCode};
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/register/chTelphone" param:para succ:succ];

}
/*注册**/
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)userName WithPassword:(NSString *)password withSecurityCodee:(NSString *)SecurityCodee
{
    NSDictionary * para = @{@"telphone":userName,@"password":password,@"code":SecurityCodee};
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/register" param:para succ:succ];
}

//登录
+(AFRequestState *)loginRequestWithusername:(NSString * )username WithPassword:(NSString *)password withSucc:(void(^)(NSDictionary*))succ
{
    NSDictionary * param = @{@"username":username,@"password":password};

    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/login" param:param succ:succ ];
    

}
/*忘记密码**/
+(AFRequestState *)forgitRequestWithPhoneNum:(NSString *)phone withSucc:(void(^)(NSDictionary*))succ
{
NSDictionary * param = @{@"telphone":phone};
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/login/send_code" param:param succ:succ];
    
}
/*忘记密码下一步**/
+(AFRequestState *)forgitNextRequestWithPhoneNum:(NSString*)phone withSecurityCode:(NSString*)SecurityCode withSucc:(void(^)(NSDictionary*))succ
{
NSDictionary * param = @{@"telphone":phone,@"code":SecurityCode};
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/login/next" param:param succ:succ];
}
/*重置密码**/
+(AFRequestState *)resetPasswordRequestWithPhoneNum:(NSString *)phone withNewCode:(NSString *)newCode  withSucc:(void(^)(NSDictionary*))succ
{
    
NSDictionary * param = @{@"telphone":phone,@"newpwd":newCode};
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/login/update_pwd" param:param succ:succ];
}
/*头像上传**/
+(AFRequestState*)uploadImage:(void (^)(NSDictionary *))succ :(UIImage *)inputImage withUid:(NSString*)uid
{
    NSData * data = UIImagePNGRepresentation(inputImage);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    NSDictionary * param = @{@"uid":uid,@"photo":encodedImageStr} ;
    
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/basicdata/head" param:param succ:succ];
//    [self postImageFlag:YES url:@"http://195.198.1.211/eggker/interface/basicdata/head" succ:succ  WithData:param withImg:inputImage fail:faile];

}
/*获取头像**/
+(AFRequestState *)getImagewithSucc:(void (^)(NSDictionary * ))succ withUid:(NSString*)uid
{
        NSDictionary * param = @{@"uid":uid} ;
    
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/basicdata/gethead"param:param succ:succ];

}
/*编辑资料添加**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withParam:(NSDictionary*)dic
{
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/basicdata/add_basicdata" param:dic succ:succ];
}
/*编辑资料预览**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withuid:(NSString*)uid

{
    NSDictionary * param = @{@"uid":uid};
    
//    @"http://195.198.1.120/eggker/interface/basicdata
    return [self postRequestWithUrl:@"http://195.198.1.120/eggker/interface/basicdata" param:param succ:succ];
}
@end
