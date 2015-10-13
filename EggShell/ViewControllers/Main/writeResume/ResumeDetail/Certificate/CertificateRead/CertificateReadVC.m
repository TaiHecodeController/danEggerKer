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
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation CertificateReadVC
-(void)viewWillAppear:(BOOL)animated
{
    /***/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
[super viewWillDisappear:NO];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"writeresum" object:nil];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _resume_model = [ResumeModel sharedResume];
    [self loadData];
    
    
}
-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
   [[WriteResumeRequest certificatesReadingWithSucc:^(NSDictionary *dataDic) {
       self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
       [self createView];
       
   } certificatesReadingParam:param] addNotifaction:[MBProgressHUD mbHubShow]];
}
-(void)createView

{   UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i = 0; i <self.dataArray.count; i++) {
        

{

    CertificateReadView * certific = [CertificateReadView setCertificateReadView];
   
    [certific configValue:self.dataArray[i]];
     certific.certificContent.editable = NO;
    certific.certificContent.showsVerticalScrollIndicator = NO;
    certific.resumNameTitle.text = [NSString stringWithFormat:@"%@-证书%d",_resume_model.resumeName,i+1];
    certific.frame = CGRectMake(0, 200*i, WIDETH, 200);
    [self.scro addSubview:certific];
        if (i>0) {
            certific.selectBtn.hidden = YES;
        }
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 200*self.dataArray.count+35, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"继续添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, 200*self.dataArray.count+150);
    
    }
    }
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

@end
