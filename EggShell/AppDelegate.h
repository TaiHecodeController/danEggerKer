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
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)TH_MainTabBarController * mainTabBar;

+(AppDelegate*)instance;

@end

