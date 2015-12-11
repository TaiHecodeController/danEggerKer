    //
//  TH_MainTabBarController.m
//  EggShell
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_MainTabBarController.h"
#import "TH_SociallyVC.h"
#import "TH_ClassVC.h"
#import "TH_MineVC.h"
#import "TH_HomeVC.h"
#import "TH_PlayFanVC.h"
#import "TH_FindJobVC.h"
#import "SearchModelShare.h"
#import "TH_FindJobVC.h"
#import "TH_PlayFanVC.h"
#import "TH_JobDetailVC.h"
#import "TH_SwipeFindJobListVC.h"

@interface TH_MainTabBarController ()
@end

@implementation TH_MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = UIColorFromRGB(0xF44336);
    [self createViewcontrollers];
    [self createTabBarItems];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagePush) name:@"messagePush" object:nil];

}

-(void)createViewcontrollers
{
    TH_HomeVC * main_vc = [[TH_HomeVC alloc] init];
   THCustomNavigationController * nc1 = [[THCustomNavigationController alloc] initWithRootViewController:main_vc];
    
    TH_PlayFanVC * acti_vc = [[TH_PlayFanVC alloc] init];
    THCustomNavigationController * nc2 = [[THCustomNavigationController alloc] initWithRootViewController:acti_vc];
    
//    TH_FindJobVC * find_vc = [[TH_FindJobVC alloc] init];
//     find_vc.title = @"找工作";
//     find_vc.job_type = @"0";
//    [SearchModelShare sharedInstance].type = @"55";
//    THCustomNavigationController * nc3 = [[THCustomNavigationController alloc] initWithRootViewController:find_vc];
        TH_SwipeFindJobListVC * find_vc = [[TH_SwipeFindJobListVC alloc] init];
//         find_vc.title = @"找工作";
//         find_vc.job_type = @"0";
        [SearchModelShare sharedInstance].type = @"55";
    
        THCustomNavigationController * nc3 = [[THCustomNavigationController alloc] initWithRootViewController:find_vc];

    
    TH_MineVC * mine_vc = [[TH_MineVC alloc] init];
    THCustomNavigationController * nc4 = [[THCustomNavigationController alloc] initWithRootViewController:mine_vc];
    
    self.viewControllers = @[nc1,nc2,nc3,nc4];
    
}

-(void)createTabBarItems
{
    self.tabBar.backgroundImage = [UIImage imageNamed:@"矩形-8-拷贝-3"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0xF44336)} forState:UIControlStateSelected];
    NSArray * titleArray = @[@"首页",@"玩出范",@"找工作",@"我的"];
    NSArray * unSelectArray = @[@"home1", @"playFan1", @"zhaogongzuobottom11",@"mine1"];
    NSArray * selectArray = @[@"home11",@"playFan11",@"zhaogongzuobottom1111",@"mine11"];
    
    NSArray * items = self.tabBar.items;
    for(int i = 0;i < items.count;i++)
    {
        UITabBarItem * item = items[i];
        item = [items[i] initWithTitle:titleArray[i] image:[UIImage imageNamed:unSelectArray[i]] selectedImage:[UIImage imageNamed:selectArray[i]]];
        
    }
}

- (void)messagePush
{
    //获取当前选项卡的根控制器
    UINavigationController *oldNavigationController = [self.viewControllers objectAtIndex:self.selectedIndex];
//
    for (int i = [oldNavigationController.viewControllers count] - 1; i >= 0; i--)
    {
        
        UIViewController *viewController = [oldNavigationController.viewControllers objectAtIndex:i];
        
        NSArray *array = [oldNavigationController popToViewController:viewController animated:NO];
        
    }
//
    if (0 != self.selectedIndex)
    {
        
        self.selectedIndex = 0;
    }
    
    //self.viewControllers 数组中4个对象 nc1 nc2 nc3 nc4 是四个被导航控制器包装好的TH_HomeVC，TH_PlayFanVC，TH_FindJobVC，TH_MineVC
    UINavigationController *newNavigationController = [self.viewControllers objectAtIndex:0];
    //newNavigationController.viewControllers 是选项卡index=0时的UINavigationController栈中所有控制器
//    UINavigationController *homeVc = [newNavigationController.viewControllers objectAtIndex:0];
    newNavigationController.navigationBarHidden = NO;
    
//    NSLog(@"%@",newNavigationController.viewControllers);
    TH_HomeVC *vc1 = [[TH_HomeVC alloc]init];
    
    TH_FindJobVC *vc2 = [[TH_FindJobVC alloc] init];
    vc2.rk_pushType = homePushType;

    TH_JobDetailVC *vc3 = [[TH_JobDetailVC alloc]init];
    NSArray *arr = @[vc1,vc2,vc3];
    
    [newNavigationController pushViewController:vc3 animated:NO];
//    [newNavigationController setViewControllers:arr];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
