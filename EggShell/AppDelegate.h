//
//  AppDelegate.h
//  EggShell
//
//  Created by mac on 15/7/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
//保利视频
//#import "PolyvSettings.h"
#import "TH_MainTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
//    PolyvSettings *polyvSettings;

}
@property(nonatomic,assign)int ori_flag;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)TH_MainTabBarController * mainTabBar;
@property (strong,nonatomic)NSString * userId;
@property (strong,nonatomic)NSString * resumeId;
@property(nonatomic,assign)  double doubleCurrentVersion;
@property(nonatomic,assign)   double doubleUpdateVersion;
@property(nonatomic,copy)NSString * trackViewUrl;
+(AppDelegate*)instance;

@end

