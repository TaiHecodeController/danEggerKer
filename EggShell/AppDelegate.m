//
//  AppDelegate.m
//  EggShell
//
//  Created by mac on 15/7/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "AppDelegate.h"
#import "TH_MainTabBarController.h"
#import "LoginAndRegisterRequest.h"
#import "WriteResumeViewController.h"
#import "TH_featureVC.h"
@interface AppDelegate ()
{
    NSString * _trackViewUrl;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults * versionId = [NSUserDefaults standardUserDefaults];
    [versionId setObject:@"" forKey:@"ver"];
    [versionId synchronize];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

//    [self checkVersion];
//    self.window.rootViewController = [[WriteResumeViewController alloc] init];
   
    //rk——test
    
    //初始化保利视频
//    [self initPloyVideo];
    
    [self.window makeKeyAndVisible];
    sleep(1);
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kBundleVersion];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[kBundleVersion];
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        self.mainTabBar = [[TH_MainTabBarController alloc] init];
        self.window.rootViewController = self.mainTabBar;
        
    }else
    {
        self.window.rootViewController = [[TH_featureVC alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    return YES;
   
}
//版本检测
-(void)checkVersion
{
    //1.同步请求json数据
    NSError * error;
    NSString * urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSData * response = [NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:nil error:nil];
    NSDictionary * appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];
    if(error)
    {
        NSLog(@"版本检测数据error,message:%@",error);
        return;
    }
    
    NSArray * resultsArray = [appInfoDic objectForKeyedSubscript:@"results"];
    if(!resultsArray.count)
    {
        NSLog(@"版本检测数据error,resultsArray==nil");
        return;
    }
    
    NSDictionary * infoDic = [resultsArray objectAtIndex:0];
    //2.需要version,trackViewUrl,trackName三个数据
    NSString * latestVersion = [infoDic objectForKey:@"version"];
    _trackViewUrl = [infoDic objectForKey:@"trackViewUrl"];//地址trackViewUrl
    NSString * trackName = [infoDic objectForKey:@"trackName"];
    
    //3.获取此应用的版本号
    NSDictionary * Local_infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * currentVersion = [Local_infoDic objectForKey:@"CFBundleVersion"];
    
    double doubleCurrentVersion = [currentVersion doubleValue];
    double doubleUpdateVersion = [latestVersion doubleValue];
    
    //两个点的，最后那个是无效的
    if(doubleUpdateVersion > doubleCurrentVersion)
    {
        NSString * titleStr = [NSString stringWithFormat:@"检查更新:%@",trackName];
        NSString * messageStr = [NSString stringWithFormat:@"发现版本(%@),是否升级?",latestVersion];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_trackViewUrl]];
    }
    
}

- (void)initPloyVideo
{
//    polyvSettings = [[PolyvSettings alloc] init];
//    [polyvSettings initVideoSettings:@"ylzOkbgQcn" Readtoken:@"AAiK2jiX0t-BAnX4n6CrX-xV0TfqPUML" Writetoken:@"ZDYlp4fGF8g100D-TYug02Z14idkcelP" UserId:@"00018093b1"];
}


+(AppDelegate*)instance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
