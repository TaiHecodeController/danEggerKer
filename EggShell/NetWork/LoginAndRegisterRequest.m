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
//+(AFRequestState *)loginWithSucc:(void(^)(NSDictionary * DataDic))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password
//{
//    //密码加密
//    NSString * md5_passWord = [MyMD5 md5:password];
//    NSDictionary * param = @{@"username":userName,@"pw":md5_passWord};
//    return [self postRequestWithUrl:@"http://195.198.1.211/index.php?m=api" param:param succ:succ];
//}
//    
//+(AFRequestState *)registerWithSucc:(void (^)(NSDictionary *))succ WithUserName:(NSString *)userName WithPassword:(NSString *)password WithUserType:(int)userType WithSource:(int)source WithPhoneNum:(NSString *)phoneNum WithEmail:(NSString *)email
//{
//    NSString * md5_passWord = [MyMD5 md5:password];
//    NSDictionary * param = @{@"username":userName,@"password":md5_passWord,@"usertype":@(userType),@"source":@(source),@"moblie":phoneNum,@"email":email};
//    return [self postRequestWithUrl:@"http://195.198.1.211/index.php?m=api&c=res" param:param succ:succ];
//}

/*获取验证码**/
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)phonenumber WithPassword:(NSString *)password withSecurityCode:(NSString *)SecurityCode
{
    
    NSDictionary * para = @{@"telphone":phonenumber,@"password":password,@"smscode":SecurityCode};
   
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@register/chTelphone",base_Url] param:para succ:succ];
}
/*注册**/
+(AFRequestState *)registerWithSucc:(void(^)(NSDictionary * DataDic))succ Withphonenumber:(NSString *)userName WithPassword:(NSString *)password withSecurityCodee:(NSString *)SecurityCodee
{
    NSDictionary * para = @{@"telphone":userName,@"password":password,@"code":SecurityCodee};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@register",base_Url] param:para succ:succ];

}

//登录
+(AFRequestState *)loginRequestWithusername:(NSString * )username WithPassword:(NSString *)password usertype:(int)usertype withSucc:(void(^)(NSDictionary*))succ
{
    NSNumber * userType = [NSNumber numberWithInt:usertype];
       NSDictionary * param = @{@"username":username,@"password":password,@"usertype":userType};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@login",base_Url] param:param succ:succ ];
}

/*忘记密码**/
+(AFRequestState *)forgitRequestWithPhoneNum:(NSString *)phone withSucc:(void(^)(NSDictionary*))succ
{
NSDictionary * param = @{@"telphone":phone};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@login/send_code",base_Url] param:param succ:succ];
}

/*忘记密码下一步**/
+(AFRequestState *)forgitNextRequestWithPhoneNum:(NSString*)phone withSecurityCode:(NSString*)SecurityCode withSucc:(void(^)(NSDictionary*))succ
{
NSDictionary * param = @{@"telphone":phone,@"code":SecurityCode};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@login/next",base_Url]param:param succ:succ];
}

/*重置密码**/
+(AFRequestState *)resetPasswordRequestWithPhoneNum:(NSString *)phone withNewCode:(NSString *)newCode  withSucc:(void(^)(NSDictionary*))succ
{
    
NSDictionary * param = @{@"telphone":phone,@"newpwd":newCode};
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@login/update_pwd",base_Url] param:param succ:succ];
}
/*头像上传**/
+(AFRequestState*)uploadImage:(void (^)(NSDictionary *))succ :(UIImage *)inputImage withUid:(NSString*)uid
{  NSUserDefaults  *user = [NSUserDefaults standardUserDefaults];
      NSString * tokenStr = [user objectForKey:@"md5_token"];
    if ([tokenStr length]==0) {
        tokenStr = @"";
        
    }if ([uid length]==0) {
        uid = @"";
    }
//    NSData * data = UIImagePNGRepresentation(inputImage,0.5);
    NSData *data = UIImageJPEGRepresentation(inputImage, 0.5);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    NSDictionary * param = @{@"token":tokenStr, @"uid":uid,@"photo":encodedImageStr} ;
    
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@basicdata/head",base_Url] param:param succ:succ];
    
}
/*获取个人资料**/
+(AFRequestState *)getImagewithSucc:(void (^)(NSDictionary *))succ withUid:(NSDictionary*)dic withFail:(void(^)(int errCode, NSError *err))fail
{
    
   return [self postRequestWithUrl:[NSString stringWithFormat:@"%@basicdata/getbasic",base_Url] param:dic succ:succ fail:fail];


}
/*编辑资料添加**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withParam:(NSDictionary*)dic
{
    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@basicdata/add_basicdata",base_Url] param:dic succ:succ];

}
/*编辑资料预览**/
+(AFRequestState *)EditInformationWithSucc:(void(^)(NSDictionary*))succ withuid:(NSDictionary*)uid
{

    return [self postRequestWithUrl:[NSString stringWithFormat:@"%@basicdata",base_Url] param:uid succ:succ];
}
/*企业忘记密码**/
+(AFRequestState *)enterpriseForgitRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except",base_Url] param:param succ:succ];

}
/*企业忘记密码下一步**/
+(AFRequestState *)enterpriseForgitNextRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except",base_Url] param:param succ:succ];
}
/*企业重置密码**/
+(AFRequestState *)enterpriseResetPasswordRequestWithResumeParam:(NSDictionary *)param withSucc:(void(^)(NSDictionary*))succ
{
return [self postRequestWithUrl:[NSString stringWithFormat:@"%@Except/except",base_Url] param:param succ:succ];
}
@end
