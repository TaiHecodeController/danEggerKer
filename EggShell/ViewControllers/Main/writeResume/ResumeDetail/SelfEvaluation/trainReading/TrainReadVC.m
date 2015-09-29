//
//  TrainReadVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TrainReadVC.h"
#import "TrainReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
@interface TrainReadVC ()
{
    ResumeModel * _resume_model;
    
    
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;

@end

@implementation TrainReadVC

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
    [[WriteResumeRequest trainingExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self createView];
        
    } trainingExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShow]];
}
-(void)createView
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i = 0 ; i < self.dataArray.count; i++) {
    TrainReadView * traiView     = [TrainReadView settrinView];
    traiView.frame = CGRectMake(0, 200*i, WIDETH,200);
        traiView.trainingContentLable.editable = NO;
        traiView.trainingContentLable.showsVerticalScrollIndicator = NO;
    [traiView configValue:self.dataArray[i]];
    traiView.trainingContentLable.userInteractionEnabled = NO;
   traiView.nameLable.text = [NSString stringWithFormat:@"%@-培训经历%d",_resume_model.resumeName,i+1];    [self.scro addSubview:traiView];
        if(i>0)
        {
            traiView.bitianxiang.hidden =  YES;
         
        }
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 200*self.dataArray.count+35, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"继续添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, self.dataArray.count* 200+150);
    /***/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
    }
}
#pragma mark --继续添加
-(void)addbUttonClick
{
//  [self.navigationController popViewControllerAnimated:NO];
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
//    [self.navigationController pushViewController:working animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
   
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
