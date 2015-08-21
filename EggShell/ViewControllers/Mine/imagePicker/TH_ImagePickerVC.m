//
//  TH_ImagePickerVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ImagePickerVC.h"

@interface TH_ImagePickerVC ()

@end

@implementation TH_ImagePickerVC

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
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 20)];
    statusBarView.backgroundColor =
    color(235, 67, 67);
    [self.view addSubview:statusBarView];
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
