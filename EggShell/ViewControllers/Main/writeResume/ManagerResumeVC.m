//
//  ManagerResumeVC.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ManagerResumeVC.h"
#import "TH_ResumePreviewVC.h"
#import "WriteResumeViewController.h"
@interface ManagerResumeVC ()

@end

@implementation ManagerResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"简历管理";
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)createNewResume:(UIButton *)sender {
    
    WriteResumeViewController * write = [[WriteResumeViewController alloc] init];
    [self.navigationController pushViewController:write animated:YES];
}
- (IBAction)previewresume:(id)sender {
    TH_ResumePreviewVC  * presum = [[TH_ResumePreviewVC alloc] init];
    presum.title = @"简历预览";
    [self.navigationController pushViewController:presum animated:YES];
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

- (IBAction)createNewResumeClick:(UIButton *)sender {
}
- (IBAction)editClick:(UIButton *)sender {
}
- (IBAction)userResume:(UIButton *)sender {
}

- (IBAction)delete:(id)sender {
}
@end
