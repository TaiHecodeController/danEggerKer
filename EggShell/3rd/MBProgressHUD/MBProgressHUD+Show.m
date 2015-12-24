//
//  MBProgressHUD+Show.m
//  WeiLuYan
//
//  Created by mac on 14/12/25.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MBProgressHUD+Show.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (Show)

+(void)creatembHub:(NSString *)message
{
    AppDelegate * app = [AppDelegate instance];
    MBProgressHUD * mbHud = [[MBProgressHUD alloc] initWithWindow:app.window];
    [app.window addSubview:mbHud];
    mbHud.labelText = message;
    
    mbHud.mode = MBProgressHUDModeText;
    
    [mbHud showAnimated:YES whileExecutingBlock:^{
        sleep(1.2);
        
    } completionBlock:^{
        [mbHud removeFromSuperview];
    }];
}


+(void)creatembHub:(NSString *)message ControllerView:(UIViewController*)controllerView
 {
    MBProgressHUD * mbHud = [[MBProgressHUD alloc] initWithView:controllerView.view];
    [controllerView.view addSubview:mbHud];
    mbHud.labelText = message;
    mbHud.mode = MBProgressHUDModeText;
     mbHud.dimBackground = NO;
    [mbHud showAnimated:YES whileExecutingBlock:^{
        sleep(1.2);
        
    } completionBlock:^{
        [mbHud removeFromSuperview];
    }];
   
}
+(void)createmMBProgressbHub:(NSString *)message ControllerView:(UIViewController*)controllerView
{
    

}
//////////////////////////////////////////////////////////////////////////////////////
+(MBProgressHUD *)mbHubShow
{
    AppDelegate * app = [AppDelegate instance];
    UIWindow * window = app.window;
    MBProgressHUD * mbHud = [[MBProgressHUD alloc]initWithWindow:window];
    mbHud.labelText = @"正在加载";
    [window addSubview:mbHud];
    mbHud.dimBackground = NO;
    [mbHud show:YES];
    return mbHud;
}
+(MBProgressHUD *)mbHubShowControllerView:(UIViewController*)controllerView
{
    MBProgressHUD * mbHud = [[MBProgressHUD alloc]initWithView:controllerView.view];
    mbHud.labelText = @"正在加载";
    [controllerView.view addSubview:mbHud];
    mbHud.dimBackground = NO;
    [mbHud show:YES];
    return mbHud;
}
+(THMBProgressHubView *)mbHubShowMBProgressHubView:(UIViewController*)controllerView;

{
    THMBProgressHubView*  ProgressHubView = [[THMBProgressHubView alloc]initWithFrame:CGRectMake(controllerView.view.frame.size.width/2-36, controllerView.view.frame.size.height/2-45*MyWideth-64*MyWideth, 79, 90)];
//    [ProgressHubView startAnimationWithText:@"正在加载"];
    [controllerView.view addSubview:ProgressHubView];
    return ProgressHubView;
}
@end
