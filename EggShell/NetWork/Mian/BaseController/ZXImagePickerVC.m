//
//  ZXImagePickerVC.m
//  致学在线
//
//  Created by zhixue on 15/5/14.
//  Copyright (c) 2015年 ZQZX. All rights reserved.
//

#import "ZXImagePickerVC.h"

@interface ZXImagePickerVC ()

@end

@implementation ZXImagePickerVC
+ (void)initialize
{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowWidth, 20)];
//    statusBarView.backgroundColor = color(235, 67, 67);
//    [self.view addSubview:statusBarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
