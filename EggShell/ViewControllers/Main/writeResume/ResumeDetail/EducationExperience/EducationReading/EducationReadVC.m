//
//  EducationReadVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/4.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "EducationReadVC.h"
#import "EducationReadingView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
@interface EducationReadVC ()
{
    ResumeModel * _resume_model;
    

}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;

@end

@implementation EducationReadVC
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
    [[WriteResumeRequest rducationExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self createView];
        
    } educationExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}
-(void)createView
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i = 0; i < self.dataArray.count; i++) {
    EducationReadingView   * education = [EducationReadingView setView];
    education.frame = CGRectMake(0, 215*i, WIDETH,215);
    education.contentTextView.editable = NO;
        education.contentTextView.showsVerticalScrollIndicator= NO;
    [education config:self.dataArray[i]];
    education.ResumeTitle.text = [NSString stringWithFormat:@"%@-教育经历%d",_resume_model.resumeName,i+1];
    [self.scro addSubview:education];
        if (i>0) {
            education.logoBtn.hidden = YES;
        }
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 215*self.dataArray.count+35, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"继续添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, 215*self.dataArray.count+150);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
