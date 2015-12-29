//
//  AFAppRequest.m
//  EggShell
//
//  Created by mac on 15/7/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AFAppRequest.h"
#import "MJRefresh.h"
#import "Gson.h"
#import "THMBProgressHubView.h"
#define EGURL @"http://195.198.1.195/index.php?m=api"

@interface UploadImgResp : NSObject<Expose>
@property (nonatomic, strong) NSString * img;
@end

@implementation UploadImgResp
@end

@interface AFRequestState()
@property NSMutableArray * NotfifyArray;

-(void)changeState:(id)notify;
-(void)setEnd;
-(void)start;

@end

@implementation AFRequestState

-(id)init
{
    self = [super init];
    _NotfifyArray = [NSMutableArray new];
    return self;
}

-(AFRequestState *)addNotifaction:(id)notify
{
    //    NSValue * v = [NSValue valueWithNonretainedObject:notify];
    [_NotfifyArray addObject:notify];
    
    [self changeState:notify ];
    
    return self;
}

-(void)changeState:(id)notify
{
    if( [notify isKindOfClass:[MJRefreshBaseView class]]){
        if( _running ){
           
        }
        else{
            [(MJRefreshBaseView *)notify endRefreshing];
        }
    }
    if( [notify isKindOfClass:[THMBProgressHubView class]]){
        if( _running ){
            [(THMBProgressHubView *)notify startAnimationWithText:@"正在加载" ];
        }
        else{
           [(THMBProgressHubView *)notify stopAnimationWithLoadText:nil withType:YES];
           
        }
        
    }}


-(void)setEnd;
{
    _running = NO;
    
    for( id notify in _NotfifyArray ){
        [self changeState:notify];
    }
    
    [_NotfifyArray removeAllObjects];
}

-(void)start
{
    _running = YES;
    
    for( id notify in _NotfifyArray ){
        [self changeState:[(NSValue *)notify nonretainedObjectValue]];
    }
}

@end

@implementation AFAppRequest

+(AFHTTPRequestOperationManager *)sharedManager
{
    static AFHTTPRequestOperationManager* _om = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _om =[[AFHTTPRequestOperationManager alloc]init];
    });
    
    return _om;
}

//+(AFAppRequest*)sharedClient
//{
//    static AFAppRequest* _AFRequest = nil;
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        _AFRequest=[[AFAppRequest alloc]init];
//    });
//    
//    return _AFRequest;
//}

+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ
{
    return [self postRequestWithUrl:url param:param succ:succ resp:nil];
}
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail
{
    return [self postRequestWithUrl:url param:param succ:succ fail:fail resp:nil];
}
//上传数据统一错误处理
+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ resp:(Class)resp
{
    return [self postRequestWithUrl:url param:param succ:succ fail:^(int errCode, NSError *err) {
        
        [self error_hanlde:errCode Witherr:err];
        
    } resp:resp];
}

+(AFRequestState *)postRequestWithUrl:(NSString *)url param:(NSDictionary *)param succ:(void (^)(id))succ fail:(void (^)(int errCode, NSError * err))fail resp:(Class)resp;
{
    
    AFRequestState * State = [AFRequestState new];
    
    AFHTTPRequestOperationManager*manager=[self sharedManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 8.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation * operation, id responseObject)
     {
         
         
         [self handleResponse:responseObject Succ:succ Fail:fail Resp:resp State:State];
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSNumber * errcode = [NSNumber numberWithInteger:error.code];
         fail([errcode intValue],error);
         //查原始数据 responseObject
         [State setEnd];
         NSLog(@"Error: %@", error);
         NSLog ( @"operation: %@" , operation.responseString );
         if ((int)errcode==404) {
             [MBProgressHUD creatembHub:@"网络异常"];

         }
         
    }];
    [State start];
    return State;
}
//统一错误处理
+(void)error_hanlde:(int)errCode Witherr:(NSError *)err {
    
    if(errCode ==1000 )
    {
        [MBProgressHUD creatembHub:@"您的手机号为空"];
    }if (errCode ==1001) {
        [MBProgressHUD creatembHub:@"验证码错误"];
    }if (errCode ==1002) {
        [MBProgressHUD creatembHub:@"该手机号已经注册了"];
    }if (errCode ==1003) {
        [MBProgressHUD creatembHub:@"修改的密码与当前密码相同"];
    }if (errCode ==1004) {
        [MBProgressHUD creatembHub:@"密码修改失败"];
    }if (errCode ==1005) {
        
        [MBProgressHUD creatembHub:@"用户名为空"];
    }if (errCode ==1006) {
        [MBProgressHUD creatembHub:@"密码不正确"];
    }if (errCode ==1007) {
        [MBProgressHUD creatembHub:@"用户不存在"];
    }if (errCode ==1008) {
        [MBProgressHUD creatembHub:@"验证码不正确"];
    }
    
    if (errCode ==1009) {
        [MBProgressHUD creatembHub:@"你的手机号没有注册"];
    }
    if (errCode ==1010) {
        [MBProgressHUD creatembHub:@"密码为空"];
    }
    if(errCode == 5)
    {
        [MBProgressHUD creatembHub:@"开始时间和结束时间一致"];
    }if (errCode == 1012) {
//        [MBProgressHUD creatembHub:@"您还有登录"];
    }
    if(errCode == 3840)
    {
        [MBProgressHUD creatembHub:@"服务器异常"];
    }if (errCode == -1001||errCode==404||errCode==500) {
        [MBProgressHUD creatembHub:@"网络异常"];
    }
    if (errCode == 1013) {
        [MBProgressHUD creatembHub:@"请认真填写意见"];
        
    }if (errCode ==1014) {
        [MBProgressHUD creatembHub:@"抱歉，由于未知原因，你的建议我们没有收到，请重试"];
    }
    if (errCode ==1016) {
        [MBProgressHUD creatembHub:@"已操作"];
    }
    if (errCode ==1017) {
        [MBProgressHUD creatembHub:@"参数不对"];
    }

}

//对象转换＋异常捕获（防崩溃）
+(void)handleResponse:(id)responseObject Succ:(void (^)(id data))succ Fail:(void (^)(int errCode, NSError * err))fail Resp:(Class)resp State:(AFRequestState *)State;
{
    @try
    {
        //1、首先判断请求是否成功，成功的话就会有数据返回：有数据直接解析，返回succ，没数据，直接返回fail，给一个自定义的错误码
        //判断返回的数据是否是二进制流，如果是，就转换成JSON。
        if([responseObject isKindOfClass:[NSData class]])
        {
            responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        if( responseObject == nil )
        {
            fail(10002, nil);
            return;
        }
        
        //2.请求成功后，判断返回的数据是否是自己想要的。这里我们规定responseObject字典中，code=0时，数据是我们想要的，code！=0时，数据是错误的，执行fail回调函数，别忘记return，不然会继续以下方法。
        int error_code = [[responseObject objectForKey:@"code"] intValue];
        
        if( error_code != 0)
        {
            fail(error_code, nil);
            return;
        }
        
        //3、判断是否有返回类型规定：没有返回类型，直接返回字典数据
        if(!resp)
        {
            succ(responseObject);
            return;
        }
        
        //有返回类型，Gson返回列表模型（Gson作用是不需要写字典转模型的实现，只定义字段就可以了，利用了运行时机制）
        id data = [Gson fromObj:[responseObject objectForKey:@"data"] Cls:resp];
        
        //没有返回类型，没有返回数据，返回空
        if(data == nil && resp == [NSNull class])
        {
            succ(nil);
            return;
        }
        
        //规定了返回类型，但没返回数据，说明返回类型不是统一的格式，（例如列表是统一的）
        if( data == nil && resp != [NSNull class] )
        {
            fail(10001, nil);
            return;
        }
        //这块没明白
        if(succ == nil)
        {
            return;
        }
        //返回正确数据
        succ(data);
    }
    @catch(GsonException * excep){
        fail(10000, nil);
    }
    @catch(NSException * excep){
        fail(50000, nil);
        
    }
    @finally{
        [State setEnd];
    }
}

@end
