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
@property (nonatomic, strong) NSDictionary *itemDic;
@end

@implementation WriteResumeVC2


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backClick) name:@"writeStep2BackClick" object:nil];
    
    [MobClick beginLogPageView:@"writeresumevc2"];
    
    //为跳转页面做准备
    [self getItemNum];

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
    [self loadData];
    
    //    // Do any additional setup after loading the view.
}

- (void)getItemNum
{
    THMBProgressHubView * hub = [MBProgressHUD mbHubShowMBProgressHubViewwindow];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *tokenStr = [df objectForKey:@"md5_token"];
    [[WriteResumeRequest getResumeItemNumberWithSucc:^(NSDictionary *dataDic) {
        
        THLog(@"%@",dataDic);
        self.itemDic = [NSDictionary dictionaryWithDictionary:dataDic[@"data"]];
        
    } withToken:tokenStr uid:[AppDelegate instance].userId eid:self.resumeid] addNotifaction:hub];
}

- (void)loadData
{
    THMBProgressHubView * hub = [MBProgressHUD mbHubShowMBProgressHubViewwindow];
    [[WriteResumeRequest getResumeMessageListWithSucc:^(NSDictionary *DataDic) {
        
        self.dataDic = DataDic[@"data"];
        
    }] addNotifaction:hub];
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createData
{
    self.nameArray = @[@"个人资料",@"工作经历",@"教育经历",@"培训经历",@"专业技能",@"项目经验",@"证书",@"自我评价"];
}

-(void)createUI
{
    self.resumeNameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 10, 120, 20) Font:14 Text:_model.resumeName];
    [self.view addSubview:self.resumeNameLab];
    
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
    //可选项、必选项
    if(indexPath.row >2)
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

            WriteResumeViewController * vc = [[WriteResumeViewController alloc] init];
            vc.resumeId = self.resumeid;
            vc.isEdit = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            if ([self.itemDic[@"work"] integerValue] == 0)
            {
                WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
                working.pushtype = addPush;
                working.resumeId = self.resumeid;
                [self.navigationController pushViewController:working animated:YES];
            }
            else
            {
                WorkExReadingVC *vc = [[WorkExReadingVC alloc]init];
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 2:
        {
            if ([self.itemDic[@"edu"] integerValue] == 0)
            {
                TH_EducationExperienceVC *vc = [[TH_EducationExperienceVC alloc]init];
                vc.pushtype = 0;
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                EducationReadVC *vc =[[EducationReadVC alloc]init];
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 3:
        {
            if ([self.itemDic[@"training"] integerValue] == 0)
            {
                TH_TrainExperienceVC *vc = [[TH_TrainExperienceVC alloc]init];
                vc.pushtype = 0;
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                TrainReadVC * vc = [[TrainReadVC alloc]init];
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 4:
        {
            if ([self.itemDic[@"skill"] integerValue] == 0)
            {
                TH_ProfessionalSkillVC *vc = [[TH_ProfessionalSkillVC alloc]init];
                vc.dataDic = self.dataDic;
                vc.pushtype = 0;
                vc.resumId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                ProfessonSkillVC *vc = [[ProfessonSkillVC alloc]init];
                vc.dataDic = self.dataDic;
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }

           
        }
            break;
        case 5:
        {

            if ([self.itemDic[@"project"] integerValue] == 0)
            {
                TH_ProjectExperienceVC *vc = [[TH_ProjectExperienceVC alloc]init];
                vc.pushtype = 0;
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                ProjectExperienceVC *vc = [[ProjectExperienceVC alloc]init];
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }

            
        }
            break;
        case 6:
        {
            if ([self.itemDic[@"cert"] integerValue] == 0)
            {
                TH_CertificateVC *vc = [[TH_CertificateVC alloc]init];
                vc.pushtype = 0;
                vc.resumeId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                CertificateReadVC *vc = [[CertificateReadVC alloc]init];
                vc.resuemId = self.resumeid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break ;
            
        case 7:
        {
            TH_SelfEvaluationVC * selfEvaluate = [[TH_SelfEvaluationVC alloc] init];
            selfEvaluate.title = @"自我评价";
            selfEvaluate.resumId = self.resumeid;
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
