//
//  AccountRequest.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/29.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AccountRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLSessionManager.h"
@implementation AccountRequest
+(AFHTTPRequestOperationManager *)sharedManager
{
    static AFHTTPRequestOperationManager* manager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
      manager =[[AFHTTPRequestOperationManager alloc]init];
    });
    
    return manager;
}


//注册
+(void)RegisterRequestWithUserName:(NSString *)username PassWord:(NSString *)password withAccountName:(NSString *)accountName succ:(void (^)(NSDictionary *))succ
{
    NSDictionary * param = @{@"telphone":username,@"password":password,@"code":accountName};
  [[AccountRequest sharedManager] POST:@"http://195.198.1.197/eggker/interface/register"parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        succ(responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

//登录
+(void)loginRequestWithusername:(NSString * )username WithPassword:(NSString *)password withSucc:(void(^)(NSDictionary*))succ
{
    NSDictionary * param = @{@"username":username,@"password":password};
    [[AccountRequest sharedManager]POST:@"http://195.198.1.197/eggker/interface/login" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succ(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/*忘记密码**/
+(void)forgitRequestWithPhoneNum:(NSString *)phone withSucc:(void(^)(NSDictionary*))succ
{
    NSDictionary * param = @{@"telphone":phone};
    [[AccountRequest sharedManager]POST:@"http://195.198.1.197/eggker/interface/login/send_code" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succ(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
/*忘记密码下一步**/
+(void)forgitNextRequestWithPhoneNum:(NSString*)phone withSecurityCode:(NSString*)SecurityCode withSucc:(void(^)(NSDictionary*))succ
{
    NSDictionary * param = @{@"telphone":phone,@"code":SecurityCode};
    [[AccountRequest sharedManager]POST:@"http://195.198.1.197/eggker/interface/login/next" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succ(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
/*重置密码**/
+(void)resetPasswordRequestWithPhoneNum:(NSString*)phone withNewCode:(NSString*)newCode  withSucc:(void(^)(NSDictionary*))succ
{
    NSDictionary * param = @{@"telphone":phone,@"newpwd":newCode};
    [[AccountRequest sharedManager]POST:@"http://195.198.1.197/eggker/interface/login/update_pwd" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        succ(responseObject);
        //请求的头部信息
        NSLog(@"%@",operation.request.allHTTPHeaderFields);
               
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}
@end
