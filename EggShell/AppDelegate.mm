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
#import <BaiduMapAPI/BMKMapManager.h>
#import "IQTitleBarButtonItem.h"
#import "MobClick.h"
@interface AppDelegate ()<BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    NSString * _trackViewUrl;
    BMKMapManager* _mapManager;
      BMKLocationService * _locService;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [UIViewController new];
    [self.window makeKeyAndVisible];
    //注册友盟统计
    [MobClick startWithAppkey:@"55f24438e0f55aa7af001c3d" reportPolicy:BATCH   channelId:nil];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSNumber *num = [NSNumber numberWithInt:0];
    [df setObject:num forKey:@"citytag"];
    [df synchronize];
    
   [self checkVersion];
    
    
    //初始化保利视频
    [self initPloyVideo];
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"VETGQ5nQXBXtGt0VHhIetQuh" generalDelegate:self];
    if (ret)
    {
        NSLog(@"配置成功");
    }
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kBundleVersion];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[kBundleVersion];
    
    if ([currentVersion isEqualToString:lastVersion])
    {
        
        self.mainTabBar = [[TH_MainTabBarController alloc] init];
        
        self.window.rootViewController = self.mainTabBar;
        
    }else
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window.rootViewController = [[TH_featureVC alloc] init];
        
    }
    self.userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if(self.userId)
    {
        NSLog(@"已登陆");
    }

    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    /*键盘处理**/
    [self keyBoard];
    

    return YES;
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %0.2f,long %0.2f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _longitude = userLocation.location.coordinate.longitude;
    _latitude  = userLocation.location.coordinate.latitude;
    
}
#pragma mark -- 键盘收回处理
-(void)keyBoard
{
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];

//    IQTitleBarButtonItem * done =[[IQTitleBarButtonItem alloc] initWithFrame:CGRectMake(WIDETH-60, 0, 440, 40) Title:@"完成"];
    
}

//版本检测
-(void)checkVersion
{
    //1.同步请求json数据
    NSError * error;
    NSString * urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",APPID];
    
    NSURL * url = [NSURL URLWithString:urlStr];
    NSData * response = [NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:url] returningResponse:nil error:nil];
    
    if (!response) {
        return;
    }
    
    NSDictionary * appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:&error];

    if(!appInfoDic) {
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
    //    CFBundleShortVersionString
    NSDictionary * Local_infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString * currentVersion = [Local_infoDic objectForKey:@"CFBundleShortVersionString"];
    
    self.doubleCurrentVersion = [currentVersion doubleValue];
    
    self.doubleUpdateVersion = [latestVersion doubleValue];
    
    //两个点的，最后那个是无效的
    if(self.doubleUpdateVersion > self.doubleCurrentVersion)
    {
        NSString * titleStr = [NSString stringWithFormat:@"检查更新:%@",trackName];
//        NSString * messageStr = [NSString stringWithFormat:@"发现新版本(%@),是否升级?",latestVersion];
        
        NSString * releaseNotes = appInfoDic[@"results"][0][@"releaseNotes"];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:titleStr message:releaseNotes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"升级", nil];
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
        polyvSettings = [[PolyvSettings alloc] init];
        [polyvSettings initVideoSettings:@"ylzOkbgQcn" Readtoken:@"AAiK2jiX0t-BAnX4n6CrX-xV0TfqPUML" Writetoken:@"ZDYlp4fGF8g100D-TYug02Z14idkcelP" UserId:@"00018093b1"];
}

+(AppDelegate*)instance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if( self.ori_flag == 1){
        return UIInterfaceOrientationMaskAll;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
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
