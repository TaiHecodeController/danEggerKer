//
//  TH_ResumePreviewVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//  简历预览

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

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"resumepreview"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"resumepreview"];
}

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
{
    /*基本信息**/
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
    CGFloat y = 390;
    CGFloat gH = 160;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"work"]).count; i++)
    {
        CGFloat workingY = y + i * gH;
        WorkExperienceView * working = [WorkExperienceView setWorkExperienceView];
        [working configVulue:self.dataDic[@"work"] withArrIndex:i];
        working.workContent.editable = NO;
        working.workContent.showsVerticalScrollIndicator = NO;
        working.frame = CGRectMake(0, workingY, WIDETH, gH);
        [self.scro  addSubview: working];
    }
    y = y + gH *  ((NSArray *)self.dataDic[@"work"]).count;
    
    /*教育经历**/
    CGFloat jH = 175;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"jy"]).count; i++)
    {
        CGFloat educationY = y + i * jH;
        EducationExperienceView * education  = [EducationExperienceView setEducationExperienceView];
        education.frame = CGRectMake(0, educationY, WIDETH, jH);
        education.departmentIntroduce.editable = NO;
        education.departmentIntroduce.showsVerticalScrollIndicator = NO;
        [education configVulue:self.dataDic[@"jy"] withArrIndex:i];
        [self.scro addSubview:education];
        
    }
    y = y + jH *  ((NSArray *)self.dataDic[@"jy"]).count;
    
    /*专业技能**/
    CGFloat zH = 120 ;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"skill"]).count; i++)
    {
        
        CGFloat professionalSkillViewY = y + i*zH;
        professionalSkillView * skill = [professionalSkillView setprofessionalSkillView];
        
        [skill conFigValue:self.dataDic[@"skill"] withArrIndex:i];
        skill.frame = CGRectMake(0, professionalSkillViewY, WIDETH, zH);
        [self.scro addSubview:skill];
    }
    
    y = y + zH *  ((NSArray *)self.dataDic[@"skill"]).count;
    /*项目经验**/
    CGFloat xH = 140;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"project"]).count; i++)
    {
        CGFloat projectY = y + i * xH;
        ProjectExperienceView * project =[ProjectExperienceView setProjectExperienceView];
        project.frame = CGRectMake(0, projectY, WIDETH, xH);
        project.proIntroduce.editable = NO;
        project.proIntroduce.showsVerticalScrollIndicator = NO;
        [project configValue:self.dataDic[@"project"] withArrIndex:i];
        [self.scro addSubview:project];
    }
    y  = y + xH * ((NSArray *)self.dataDic[@"project"]).count;
    
    /*证书**/
    CGFloat ZSh = 155;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"cert"]).count; i++)
    {
        CGFloat certificY = y + i * ZSh;
        CertificateView * certific = [CertificateView setCertificateView];
        certific.certificateIntroduce.editable = NO;
        certific.certificateIntroduce.showsVerticalScrollIndicator = NO;
        [certific configValue:self.dataDic[@"cert"] withArrIndex:i];
        certific.frame = CGRectMake(0, certificY, WIDETH, ZSh);
        [self.scro addSubview:certific];
    }
    y = y + ZSh * ((NSArray *)self.dataDic[@"cert"]).count;
    
    /*培训内容**/
    CGFloat Ph = 155;
    for (int i = 0; i < ((NSArray *)self.dataDic[@"training"]).count; i ++)
    {
        CGFloat trainY = y + i * Ph;
        trainingExperienceView * train = [trainingExperienceView settrainingExperienceView];
        train.frame = CGRectMake(0,trainY, WIDETH, Ph);
        train.trainIntroduce.editable = NO;
        train.trainIntroduce.showsVerticalScrollIndicator = NO;
        [train configValue:self.dataDic[@"training"] withArrIndex:i];
        [self.scro addSubview:train];
    }
    y = y + ((NSArray *)self.dataDic[@"training"]).count * Ph;
    
    /*自我评价**/
    CGFloat ZWH= 70;
    SelfEvaluationView * selfevaluat =[SelfEvaluationView setSelfEvaluationView];
//    selfevaluat.frame = CGRectMake(0, 810+135+205+200+200, WIDETH, 100);
    selfevaluat.frame = CGRectMake(0, y, WIDETH, ZWH);
    selfevaluat.selfEvaluation.editable = NO;
    selfevaluat.selfEvaluation.showsVerticalScrollIndicator = NO;
    [selfevaluat configValue:self.dataDic[@"other"]];
    [self.scro addSubview:selfevaluat];
    
//    self.scro.contentSize   = CGSizeMake(WIDETH, 810+135+205+200+200+100);
    self.scro.contentSize   = CGSizeMake(WIDETH, y + ZWH);
    
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
