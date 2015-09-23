

//
//  ProjectExperienceVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProjectExperienceVC.h"
#import "ProjectExpReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
@interface ProjectExperienceVC ()
{
    ResumeModel * _resume_model;
    
    
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation ProjectExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _resume_model = [ResumeModel sharedResume];
   
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}
-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    
    [[WriteResumeRequest projectExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray = [NSArray arrayWithArray:dataDic[@"data"]];
        [self createView];
    } projectExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShow]];
}


-(void)createView
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i ; i < self.dataArray.count; i++) {
        
    ProjectExpReadView * project =[ProjectExpReadView setProjectExperienceView];
    project.frame = CGRectMake(0, 215*i, WIDETH,215);
    [project configValue:self.dataArray[i]];
    project.resumTitle.text = [NSString stringWithFormat:@"%@-项目经验%d",_resume_model.resumeName,i];
    [self.scro addSubview:project];
        if (i>0) {
            project.selectBtn.hidden = YES;
        }
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 215*self.dataArray.count+35, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"继续添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, 215*self.dataArray.count+150);
    /***/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
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
