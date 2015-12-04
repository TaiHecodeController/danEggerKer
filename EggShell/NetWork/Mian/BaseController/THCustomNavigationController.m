//
//  THCustomNavigationController.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "THCustomNavigationController.h"

@interface THCustomNavigationController ()

@end

@implementation THCustomNavigationController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:color(253, 253, 253)];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    navigationBar.titleTextAttributes = @{NSFontAttributeName :[UIFont systemFontOfSize:18]};
    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage imageNamed:@"矩形-4"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if (self.viewControllers.count > 0)
    {[[NSNotificationCenter defaultCenter] postNotificationName:@"videoClose" object:nil];
        [self popViewControllerAnimated:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itermWithTarget:self Action:@selector(pop) Image:@"fanhui" HighImage:@"fanhui"];
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark -返回
- (void)pop
{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"writeresum" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"company" object:nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"videoClose" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"writeStep2BackClick" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"findJobBackClick" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jb_detail" object:nil];
    [self popViewControllerAnimated:YES];

}
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleBlackOpaque;
//}



@end
