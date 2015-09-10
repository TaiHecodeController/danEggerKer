//
//  TH_ResumePreviewVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ResumePreviewVC.h"
#import "Basicnformation.h"
#import "intentView.h"
#import "WorkExperienceView.h"
#import "EducationExperienceView.h"
#import "professionalSkillView.h"
#import "ProjectExperienceView.h"
#import "CertificateView.h"
#import "trainingExperienceView.h"
#import "SelfEvaluationView.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
@interface TH_ResumePreviewVC ()
@property(nonatomic,strong)UIScrollView *scro;
@property(nonatomic,strong)NSDictionary * dataDic;
@end

@implementation TH_ResumePreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
    self.scro = scro;
    [self.view addSubview:scro];
   
    [self loadData];
}
-(void)loadData
{
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    
    [[WriteResumeRequest biographyPreviewWithSucc:^(NSDictionary *DataDic) {
        self.dataDic = DataDic[@"data"];
         [self createTilteView];
        [self createView];
    } WithResumeParam:@{@"eid":self.resumeId} withfail:nil] addNotifaction:hub];
 
}

-(void)createTilteView
{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
    titleView.backgroundColor = UIColorFromRGB(0xf3f3f1);
    [self.scro addSubview:titleView];
    
    UILabel * myLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 13)];
    myLable.text = self.resumeName;
    myLable.font =[UIFont systemFontOfSize:13];
    [titleView addSubview:myLable];
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 165, 16, 150, 11)];
    timeLable.text = @"创建于2015-08-03";
    timeLable.text = [NSString stringWithFormat:@"创建于%@", self.dataDic[@"expect"][@"ctime"]];
    timeLable.font =[UIFont systemFontOfSize:11];
    timeLable.textColor = UIColorFromRGB(0x646464);
    timeLable.textAlignment = NSTextAlignmentRight;
    [titleView addSubview:timeLable];
}

-(void)createView
{/*基本信息**/
    Basicnformation * baseInformation =[Basicnformation setBaseView];
    baseInformation.frame = CGRectMake(0, 42, WIDETH, 158);
    [baseInformation configVulue:self.dataDic[@"info"]];
    [self.scro addSubview:baseInformation];
    /*求职意向**/
    intentView * intent = [intentView setIntentView];
    intent.frame = CGRectMake(0, 200, WIDETH, 190);
    [intent configValue:self.dataDic[@"expect"]];
    [self.scro addSubview:intent];
    /*工作经历**/
    WorkExperienceView * working = [WorkExperienceView setWorkExperienceView];
    [working configVulue:self.dataDic[@"work"]];
    working.workContent.userInteractionEnabled = NO;
    working.frame = CGRectMake(0, 390, WIDETH, 200);
    [self.scro  addSubview: working];
    /*教育经历**/
    EducationExperienceView * education  = [EducationExperienceView setEducationExperienceView];
    education.frame = CGRectMake(0, 590, WIDETH, 220);
    education.departmentIntroduce.userInteractionEnabled = NO;
    [education configVulue:self.dataDic[@"jy"]];
    [self.scro addSubview:education];
    /*专业技能**/
    professionalSkillView * skill = [professionalSkillView setprofessionalSkillView];
    [skill conFigValue:self.dataDic[@"skill"]];
    skill.frame = CGRectMake(0, 810, WIDETH, 135);
    [self.scro addSubview:skill];
    
    /*项目经验**/
    ProjectExperienceView * project =[ProjectExperienceView setProjectExperienceView];
    project.frame = CGRectMake(0, 810+135, WIDETH, 205);
    project.proIntroduce.userInteractionEnabled = NO;
    [project configValue:self.dataDic[@"project"]];
    [self.scro addSubview:project];
    /*证书**/
    CertificateView * certific = [CertificateView setCertificateView];
    certific.certificateIntroduce.userInteractionEnabled = NO;
    [certific configValue:self.dataDic[@"cert"]];
    certific.frame = CGRectMake(0, 810+135+205, WIDETH, 200);
    [self.scro addSubview:certific];
    /*培训内容**/
    trainingExperienceView * train = [trainingExperienceView settrainingExperienceView];
    train.frame = CGRectMake(0,  810+135+205+200, WIDETH, 200);
    train.trainIntroduce.userInteractionEnabled = NO;
    [train configValue:self.dataDic[@"training"]];
    [self.scro addSubview:train];
    /*自我评价**/
    SelfEvaluationView * selfevaluat =[SelfEvaluationView setSelfEvaluationView];
    selfevaluat.frame = CGRectMake(0, 810+135+205+200+200, WIDETH, 100);
    selfevaluat.selfEvaluation.userInteractionEnabled = NO;
    [selfevaluat configValue:self.dataDic[@"other"]];
    [self.scro addSubview:selfevaluat];
    self.scro.contentSize   = CGSizeMake(WIDETH, 810+135+205+200+200+100);
    
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
