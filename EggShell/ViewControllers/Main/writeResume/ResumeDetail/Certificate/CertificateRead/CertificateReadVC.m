//
//  CertificateReadVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CertificateReadVC.h"
#import "CertificateReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
@interface CertificateReadVC ()
{
    ResumeModel * _resume_model;

}
@end

@implementation CertificateReadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _resume_model = [ResumeModel sharedResume];
    [self createView];
    
    // Do any additional setup after loading the view.
}
-(void)createView
{
    CertificateReadView * certific = [CertificateReadView setCertificateReadView];
    certific.certificContent.userInteractionEnabled = NO;
    [certific configValue:self.model];
    certific.resumNameTitle.text = [NSString stringWithFormat:@"%@-证书",_resume_model.resumeName];
    certific.frame = CGRectMake(0, 0, WIDETH, 300);
    [self.view addSubview:certific];
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 300, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"继续添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    /***/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
}
#pragma mark --继续添加
-(void)addbUttonClick
{
    
   [self.navigationController popViewControllerAnimated:YES];
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
//    [self.navigationController pushViewController:working animated:YES];
}
-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:NO];
    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
    [self.navigationController popToViewController:write animated:YES];
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
