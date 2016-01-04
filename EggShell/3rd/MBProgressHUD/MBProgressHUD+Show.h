//
//  MBProgressHUD+Show.h
//  WeiLuYan
//
//  Created by mac on 14/12/25.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MBProgressHUD.h"
#import "THMBProgressHubView.h"
@interface MBProgressHUD (Show)
@property (strong,nonatomic)MBProgressHUD * mbHud2;
+(void)creatembHub:(NSString *)message;
+(void)creatembHub:(NSString *)message ControllerView:(UIViewController*)controllerView;
//自定义网络加载封装类
+(void)createmMBProgressbHub:(NSString *)message ControllerView:(UIViewController*)controllerView;

+(MBProgressHUD *)mbHubShow;
+(MBProgressHUD *)mbHubShowControllerView:(UIViewController*)controllerView;
//自定义网络加载封装加载view
+(THMBProgressHubView *)mbHubShowMBProgressHubView:(UIViewController*)controllerView;
//自定义网络加载封装加载window
//+(THMBProgressHubView *)mbHubShowMBProgressHubViewwindow;
@end
