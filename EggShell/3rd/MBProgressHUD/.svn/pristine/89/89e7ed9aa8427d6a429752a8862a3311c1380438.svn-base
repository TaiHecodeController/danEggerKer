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
        sleep(1);
        
    } completionBlock:^{
        [mbHud removeFromSuperview];
    }];
}

+(MBProgressHUD *)mbHubShow
{
    AppDelegate * app = [AppDelegate instance];
    UIWindow * window = app.window;
    MBProgressHUD * mbHud = [[MBProgressHUD alloc]initWithWindow:window];
    [window addSubview:mbHud];
    mbHud.dimBackground = YES;
    [mbHud show:YES];
    return mbHud;
}





@end
