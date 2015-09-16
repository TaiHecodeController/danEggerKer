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

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"imagepickervc"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"imagepickervc"];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 64)];
    statusBarView.backgroundColor =
    color(253, 253, 253);
    [self.view addSubview:statusBarView];
    UIButton *  button = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH-60, 24, 40, 40)];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    button.titleLabel.font =[UIFont systemFontOfSize:16];
    [button setTitleColor:UIColorFromRGB(0xF34336) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)leftBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
