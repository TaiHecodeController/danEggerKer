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
@interface TH_MainTabBarController ()
@end

@implementation TH_MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor = [UIColor whiteColor];
    [self createViewcontrollers];
    [self createTabBarItems];

    
    // Do any additional setup after loading the view.
}

-(void)createViewcontrollers
{
    TH_HomeVC * main_vc = [[TH_HomeVC alloc] init];
   THCustomNavigationController * nc1 = [[THCustomNavigationController alloc] initWithRootViewController:main_vc];
    
    TH_PlayFanVC * acti_vc = [[TH_PlayFanVC alloc] init];
    THCustomNavigationController * nc2 = [[THCustomNavigationController alloc] initWithRootViewController:acti_vc];
    
    TH_ClassVC * class_vc = [[TH_ClassVC alloc] init];
    THCustomNavigationController * nc3 = [[THCustomNavigationController alloc] initWithRootViewController:class_vc];
    
    TH_MineVC * mine_vc = [[TH_MineVC alloc] init];
    THCustomNavigationController * nc4 = [[THCustomNavigationController alloc] initWithRootViewController:mine_vc];
    
    self.viewControllers = @[nc1,nc2,nc3,nc4];
    [self createTabBarItems];
    
}

-(void)createTabBarItems
{
    self.tabBar.backgroundImage = [UIImage imageNamed:@"矩形-8-拷贝-3"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    NSArray * titleArray = @[@"首页",@"玩出范",@"公开课",@"我的"];
    NSArray * unSelectArray = @[@"home", @"wanchufan", @"gongkaike00",@"wode"];
    NSArray * selectArray = @[@"home01",@"wanchufan01",@"gongkaike01",@"wode01"];
    
    NSArray * items = self.tabBar.items;
    for(int i = 0;i < items.count;i++)
    {
        UITabBarItem * item = items[i];
        item = [items[i] initWithTitle:titleArray[i] image:[UIImage imageNamed:unSelectArray[i]] selectedImage:[UIImage imageNamed:selectArray[i]]];
        
    }
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
