//
//  THCustomNavigationController.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "THCustomNavigationController.h"

@interface THCustomNavigationController ()

@property (nonatomic, strong) UISwipeGestureRecognizer *swipe;

@end

@implementation THCustomNavigationController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:color(253, 253, 253)];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
    navigationBar.titleTextAttributes = @{NSFontAttributeName :[UIFont systemFontOfSize:18]};
    UIImage *icon = [UIImage imageNamed:@"shipinchuangkou"];
//     [navigationBar setBackgroundImage:icon forBarMetrics:UIBarMetricsDefault];
        [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [navigationBar setBackgroundImage:icon forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
//    navigationBar.clipsToBounds=YES;
    navigationBar.shadowImage = [UIImage imageNamed:@"矩形-4"];
//    navigationBar.shadowImage = icon;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    navigationBar.titleTextAttributes = @{@"NSForegroundColorAttributeName":[UIColor yellowColor]};
    
    //设置返回按钮
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
//                                                          forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 滑动手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:swipe];
//    self.swipe = swipe;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rmG) name:@"rmG" object:nil];
    //导航栏跟着一起滑动
//    self.hidesBarsOnSwipe = YES;
    
    /**
     (1).tintColor是描述线条轮廓的一种颜色,该颜色默认具有传递性,默认状态下最底部的视图的tintcolor会一直往上面的视图传递
     (2).如果子视图改变了tintcolor那么将会和父视图的tintColor不一样;传递链从此处断开
     (3).navagation的item的  tintColor和controller自带的View不是在同一层次上;改变controller的view的tintColor对navagation的tintColor没有颜色;
     (4).由于,tintColor的特性,我们可以对镂空的图片(如tabbar的image和 BarButtonItem的image)进行设置tintColor就可以设置改变镂空图片的颜色
     渲染navigationBar的子控件，类比如果view.tintColor 是渲染view的子控件
     */
//    self.navigationBar.tintColor = [UIColor yellowColor];
}

- (void)rmG
{
    [self.view removeGestureRecognizer:self.swipe];
}
- (void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if (self.viewControllers.count > 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"videoClose" object:nil];
        [self popViewControllerAnimated:YES];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //push之前设置返回按钮
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
