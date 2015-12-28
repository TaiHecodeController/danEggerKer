//
//  WriteResumeVC2.m
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeVC2.h"
#import "WriteResumeCell2.h"
#import "WorkingExperienceVC.h"
#import "TH_EducationExperienceVC.h"
#import "TH_SelfEvaluationVC.h"
#import "TH_CertificateVC.h"
#import "TH_ProfessionalSkillVC.h"
#import "TH_TrainExperienceVC.h"
#import "TH_ProjectExperienceVC.h"
#import "ResumeModel.h"
#import "ManagerResumeVC.h"
#import "WriteResumeViewController.h"
#import "WorkExReadingVC.h"
#import "EducationReadVC.h"
#import "ProjectExperienceVC.h"
#import "TrainReadVC.h"
#import "ProfessonSkillVC.h"
#import "CertificateReadVC.h"
#import "TH_SelfEvaluationVC.h"

@interface WriteResumeVC2 ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * writeTabView;
    ResumeModel * _model;
}
@property (strong,nonatomic)NSArray * nameArray;
@end

@implementation WriteResumeVC2


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backClick) name:@"writeStep2BackClick" object:nil];
    
    [MobClick beginLogPageView:@"writeresumevc2"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"writeresumevc2"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"写简历";
    self.view.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    
    [self createData];
    [self createUI];
    
    
    //    // Do any additional setup after loading the view.
}
-(void)backClick
{
//    for(UIViewController *controller in self.navigationController.viewControllers)
//    {
//        [self.navigationController popViewControllerAnimated:NO];
//        if([controller isKindOfClass:[ManagerResumeVC class]]){
//            ManagerResumeVC*owr = (ManagerResumeVC *)controller;
//            [self.navigationController popToViewController:owr animated:YES];
//        }}
    [self.navigationController popViewControllerAnimated:YES];
    //    self.navigationItem.leftBarButtonItem = nil;
    //    [self.navigationController popViewControllerAnimated:NO];
    //    ManagerResumeVC * manager = [[ManagerResumeVC alloc] init];
    //    [self.navigationController popToViewController:manager animated:YES];
    
}

-(void)createData
{
    self.nameArray = @[@"个人资料",@"工作经历",@"教育经历",@"培训经历",@"专业技能",@"项目经验",@"证书",@"自我评价"];
}

-(void)createUI
{
    self.resumeNameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 10, 120, 20) Font:14 Text:_model.resumeName];
    [self.view addSubview:self.resumeNameLab];
    
//    writeTabView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 42, WIDETH + 15, 294 + 42)];
    writeTabView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 42, WIDETH + 15, self.nameArray.count * 42)];
    writeTabView.delegate = self;
    writeTabView.dataSource = self;
    writeTabView.scrollEnabled = NO;
    writeTabView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    writeTabView.layer.borderWidth = 0.5;
    writeTabView.separatorColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1];
    [self.view addSubview:writeTabView];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WriteResumeCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell2" owner:self options:nil] firstObject];
    }
    cell.nameLab.text = self.nameArray[indexPath.row];
    if(indexPath.row >1)
    {
        cell.stateBtn.selected = YES;
    }else
    {
        cell.stateBtn.selected = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [AppDelegate instance].resumeId = self.resumeid;
    
    switch (indexPath.row) {
        case 0:
        {
//            WriteResumeViewController *vc = [[WriteResumeViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
                        WriteResumeViewController * vc = [[WriteResumeViewController alloc] init];
                        vc.resumeId = self.resumeid;
                        vc.isEdit = YES;
//                        [AppDelegate instance].resumeId = self.resumeid;
                        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            WorkingExperienceVC * wvc = [[WorkingExperienceVC alloc] init];
//            [self.navigationController pushViewController:wvc animated:YES];
            WorkExReadingVC *vc = [[WorkExReadingVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
//            TH_EducationExperienceVC * education = [[TH_EducationExperienceVC alloc] init];
//            education.title = @"教育经历";
//            [self.navigationController pushViewController:education animated:YES];
            EducationReadVC *vc =[[EducationReadVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 3:
        {
//            TH_TrainExperienceVC * train = [[TH_TrainExperienceVC alloc] init];
//            train.title = @"培训经历";
//            [self.navigationController pushViewController:train animated:YES];
            TrainReadVC * vc = [[TrainReadVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
//            TH_ProfessionalSkillVC * skill = [[TH_ProfessionalSkillVC alloc] init];
//            skill.title = @"专业技能";
//            skill.dataDic = self.dataDic;
//            [self.navigationController pushViewController:skill animated:YES];
            ProfessonSkillVC *vc = [[ProfessonSkillVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
//            TH_ProjectExperienceVC * project = [[TH_ProjectExperienceVC alloc] init];
//            project.title = @"项目经验";
//            [self.navigationController pushViewController:project animated:YES];
            ProjectExperienceVC *vc = [[ProjectExperienceVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
//            TH_CertificateVC * certificate = [[TH_CertificateVC alloc] init];
//            certificate.title = @"证书";
//            [self.navigationController pushViewController:certificate animated:YES];
            CertificateReadVC *vc = [[CertificateReadVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break ;
            
        case 7:
        {
            TH_SelfEvaluationVC * selfEvaluate = [[TH_SelfEvaluationVC alloc] init];
            selfEvaluate.title = @"自我评价";
            [self.navigationController pushViewController:selfEvaluate animated:YES];
        }
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
