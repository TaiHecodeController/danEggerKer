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
#import "WriteResumeViewController.h"


#import "ResumeTiltlView.h"
//基本资料
#import "personResumeCell.h"
//求职意向
#import "JobIntentionCell.h"
//教育经历
#import "EducationExperienceCell.h"
//工作经历
#import "JobExperienceCell.h"
//专业技能
#import "ProfessionalSkillCell.h"
//项目经验
#import "ProjecctExperenceCell.h"
//证书
#import "CertificateCell.h"
//培训经历
#import "TrainExperienceCell.h"
//自我评价
#import "SelfEvaluationCell.h"
#import "editAddView.h"

#import "WorkingExperienceVC.h"
#import "TH_EducationExperienceVC.h"
#import "TH_TrainExperienceVC.h"
#import "TH_ProfessionalSkillVC.h"
#import "TH_ProjectExperienceVC.h"
#import "TH_CertificateVC.h"
#import "TH_SelfEvaluationVC.h"
#import "WriteResumeViewController.h"

@interface TH_ResumePreviewVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIScrollView *scro;
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UITableView * tableView ;
@property(nonatomic,strong)NSArray * titleArray;
@end

@implementation TH_ResumePreviewVC

//- (void)viewWillAppear:(BOOL)animated
//{
//    [MobClick beginLogPageView:@"resumepreview"];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [MobClick endLogPageView:@"resumepreview"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSArray array];
    self.titleArray = @[@"个人简历",@"求职意向",@"工作经历",@"教育经历",@"培训经历",@"专业技能",@"项目经验",@"证书",@"自我评价"];
//    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
//    self.scro = scro;
//    [self.view addSubview:scro];
//   
    
    [self createTableView];
     [self loadData];

}
-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return          ((NSArray*)(self.dataArray[section][@"datadetail"])).count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ResumeTiltlView * titleView = [[ResumeTiltlView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 30)];
     titleView.backgroundColor = UIColorFromRGB(0x7adb6b);
     editAddView * editView = [[editAddView alloc] initWithFrame:CGRectMake(WIDETH - 73, 0, 73, 32)];
    [titleView addSubview:editView];
    titleView.personTileLable.text = self.titleArray[section];
    if ([titleView.personTileLable.text isEqualToString:@"求职意向"]||[titleView.personTileLable.text isEqualToString:@"自我评价"]) {
       
        editView.imageView.image = [UIImage imageNamed:@"resumeEdit"];
        editView.editLable.text = @"编辑";
        titleView.createTimeLable.hidden = YES;
        
    }else if ([titleView.personTileLable.text isEqualToString:@"个人简历"])
    {
      titleView.createTimeLable.hidden = NO;
        editView.hidden = YES;
        titleView.personTileLable.textColor = [UIColor blackColor];
    }else
    {
        editView.imageView.image = [UIImage imageNamed:@"resumeAdd"];
        editView.editLable.text = @"新增";
        titleView.createTimeLable.hidden = YES;
        
    }
    if ([titleView.personTileLable.text isEqualToString:@"个人简历"]) {
        titleView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    }else if ([titleView.personTileLable.text isEqualToString:@"求职意向"]) {
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jobIntent)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"工作经历"])
    {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(workExperice)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"教育经历"])
    {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(educateExperice)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"专业技能"])
    { UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(professionExperice)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"项目经验"])
    { UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(projectExperice)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"证书"])
    { UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(certific)];
        [titleView addGestureRecognizer:tap];
    }else if ([titleView.personTileLable.text isEqualToString:@"培训经历"])
    { UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(trainperice)];
        [titleView addGestureRecognizer:tap];
    }else
    { UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfeValue)];
        [titleView addGestureRecognizer:tap];
    }
    
     return titleView;
}
#pragma mark -- 求职意向
-(void)jobIntent
{
 NSLog(@"求职意向");
}
#pragma mark --工作经历
-(void)workExperice
{
 NSLog(@"工作经历");
}
#pragma mark -- 教育经历
-(void)educateExperice
{
 NSLog(@"教育经历");
}
#pragma mark -- 专业技能
-(void)professionExperice
{
 NSLog(@"专业技能");
}
#pragma mark -- 项目经验
-(void)projectExperice
{
 NSLog(@"项目经验");
}
#pragma mark-- 证书
-(void)certific{
 NSLog(@"证书");
}
#pragma mark -- 培训经历
-(void)trainperice
{
 NSLog(@"培训经历");
}
#pragma mark-- 自我评价
-(void)selfeValue
{
    NSLog(@"自我评价");
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{UITableViewCell * cell;
    
    if (indexPath.section ==0) {
        //基本资料
    personResumeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"personResumeCell"];
    if (!cell) {
        cell = [[personResumeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personResumeCell"];
    }if ([self.dataArray[0][@"datadetail"]count]!=0) {
        [cell configVulue:self.dataArray[0][@"datadetail"]];
        [cell setIntroductionText:nil];

    }
            return cell;
    }
    if (indexPath.section==1) {
        //求职意向
        JobIntentionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JobIntentionCell"];
        if (!cell) {
            cell = [[JobIntentionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"JobIntentionCell"];
        }
        
        if ([self.dataArray[1][@"datadetail"]count]!=0) {
            
            
          [cell configValue:self.dataArray[1][@"datadetail"]];
        }
        return cell;
    }
    if (indexPath.section ==2) {
        //工作经历
        JobExperienceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EducationExperienceCell"];
        if (!cell) {
            cell = [[JobExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EducationExperienceCell"];
        }
        if ([self.dataArray[2][@"datadetail"]count]!=0) {
            NSDictionary * dic = self.dataArray[2][@"datadetail"][indexPath.row];
            [cell configVulue:dic] ;
        }
        cell.editDeleteBlock = ^(int tag)
        {
            //编辑
            if (tag==10)
            {
                THLog(@"编辑");
              
                
            }
            //删除
            if (tag==11)
            {
                THLog(@"删除");
            }
            
            
            
        };

        return cell;
    }if (indexPath.section==3) {
        //教育经历
        EducationExperienceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EducationExperienceCell"];
        if (!cell) {
            cell = [[EducationExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EducationExperienceCell"];
        }
        cell.editDeleteBlock = ^(int tag)
        {
            //编辑
            if (tag==10) {
                
                //删除
            }if (tag==11) {
                
            }
            
        };
        if ([self.dataArray[3][@"datadetail"]count]!=0) {
            NSDictionary * dic = self.dataArray[3][@"datadetail"][indexPath.row];
            [cell configVulue:dic] ;
        }
       
        return cell;
    }if (indexPath.section==4) {
        //培训经历
        TrainExperienceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TrainExperienceCell"];
        if (!cell) {
            cell = [[TrainExperienceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TrainExperienceCell"];
        }
        cell.editDeleteBlock = ^(int tag)
        {
            
            //编辑
            if (tag==10) {
                
                //删除
            }if (tag==11) {
                
            }
        };
        if ([self.dataArray[4][@"datadetail"]count]!=0) {
            NSDictionary * dic = self.dataArray[4][@"datadetail"][indexPath.row];
            [cell configValue:dic];
        }
        return cell;

    }if (indexPath.section==5) {

                //专业技能
                ProfessionalSkillCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProfessionalSkillCell"];
                if (!cell) {
                    cell = [[ProfessionalSkillCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProfessionalSkillCell"];
                }
                cell.editDeleteBlock = ^(int tag)
                {
                    //编辑
                    if (tag==10) {
        
                        //删除
                    }if (tag==11) {
        
                    }
        
                };
        if ([self.dataArray[5][@"datadetail"]count]!=0) {
            NSDictionary * dic = self.dataArray[5][@"datadetail"][indexPath.row];
            [cell conFigValue:dic];

        }
                       return cell;
    }if (indexPath.section==6) {
                //项目经验
                ProjecctExperenceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ProjecctExperenceCell"];
                if (!cell) {
                    cell = [[ProjecctExperenceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjecctExperenceCell"];
                }
                cell.editDeleteBlock = ^(int tag)
                {
                    //编辑
                    if (tag==10) {
        
                        //删除
                    }if (tag==11) {
        
                    }
        
                };
//        if ([self.dataArray[6][@"datadetail"]count] !=0) {
//            NSDictionary * dic = self.dataArray[6][@"datadetail"][indexPath.row];
//            [cell conFigValue:dic];
//        }
//       
                return cell;
    }if (indexPath.section==7) {
        //证书
        CertificateCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CertificateCell"];
        if (!cell) {
            cell = [[CertificateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CertificateCell"];
        }
        cell.editDeleteBlock = ^(int tag)
        {
            //编辑
            if (tag==10) {
                
                //删除
            }if (tag==11) {
                
            }
            
        };
        
        if ([self.dataArray[7][@"datadetail"]count] !=0) {
            NSDictionary * dic = self.dataArray[7][@"datadetail"][indexPath.row];
            [cell configValue:dic];
        }
        
        return cell;

        
    }if (indexPath.section==8) {
        //自我评价
        SelfEvaluationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelfEvaluationCell"];
        if (!cell) {
            cell = [[SelfEvaluationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SelfEvaluationCell"];
        }
        
//        if ([self.dataArray[8][@"other"]count ]!=0) {
//            NSDictionary * dic = self.dataArray[8][@"other"][indexPath.row];
//            [cell configValue:dic];
//        }
       
        return cell;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        personResumeCell *cell = (personResumeCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }
    if (indexPath.section==1) {
        JobIntentionCell *cell = (JobIntentionCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    if (indexPath.section==2) {
        JobExperienceCell *cell = (JobExperienceCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }if (indexPath.section==3) {
        EducationExperienceCell *cell = (EducationExperienceCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }if (indexPath.section==4) {
        TrainExperienceCell *cell = (TrainExperienceCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;

    }if (indexPath.section==5) {
        ProfessionalSkillCell *cell = (ProfessionalSkillCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }if (indexPath.section==6) {
        ProjecctExperenceCell *cell = (ProjecctExperenceCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }if (indexPath.section==7) {
                CertificateCell *cell = (CertificateCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else
    {
        SelfEvaluationCell *cell = (SelfEvaluationCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }

}
-(void)loadData
{
    NSNumber *version = [NSNumber numberWithInt:2];
    THMBProgressHubView * hub = [MBProgressHUD mbHubShowMBProgressHubView:self];
    
    [[WriteResumeRequest biographyPreviewWithSucc:^(NSDictionary *DataDic) {
        
        self.dataArray = DataDic[@"data"];
//         [self createTilteView];
        [self.tableView reloadData];
    } WithResumeParam:@{@"eid":self.resumeId,@"version":version} withfail:nil] addNotifaction:hub];
 
}

-(void)createTilteView
{
//    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
//    titleView.backgroundColor = UIColorFromRGB(0xf3f3f1);
//    [self.scro addSubview:titleView];
//    
//    UILabel * myLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 13)];
//    myLable.text = self.resumeName;
//    myLable.font =[UIFont systemFontOfSize:13];
//    [titleView addSubview:myLable];
//    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 165, 16, 150, 11)];
//    timeLable.text = @"创建于2015-08-03";
//    timeLable.text = [NSString stringWithFormat:@"创建于%@", self.dataDic[@"expect"][@"ctime"]];
//    timeLable.font =[UIFont systemFontOfSize:11];
//    timeLable.textColor = UIColorFromRGB(0x646464);
//    timeLable.textAlignment = NSTextAlignmentRight;
//    [titleView addSubview:timeLable];
}

//-(void)createView
//{
//    /*基本信息**/
//    Basicnformation * baseInformation =[Basicnformation setBaseView];
//    baseInformation.frame = CGRectMake(0, 42, WIDETH, 158);
//    [baseInformation configVulue:self.dataDic[@"info"]];
//    [self.scro addSubview:baseInformation];
//
//    /*求职意向**/
//    intentView * intent = [intentView setIntentView];
//    intent.frame = CGRectMake(0, 200, WIDETH, 198);
//    [intent configValue:self.dataDic[@"expect"]];
//    [self.scro addSubview:intent];
//    __weak typeof(self) weekSelf = self;
//    //编辑点击事件
//    intent.EditClikBlock = ^()
//    {
//    
//        [weekSelf.navigationController pushViewController:[[WriteResumeViewController alloc]init] animated:YES];
//    };
//    
//    /*工作经历**/
//    CGFloat y = 390;
//    CGFloat gH = 160;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"work"]).count; i++)
//    {
//        CGFloat workingY = y + i * gH;
//        WorkExperienceView * working = [WorkExperienceView setWorkExperienceView];
//        [working configVulue:self.dataDic[@"work"] withArrIndex:i];
//        working.workContent.editable = NO;
//        working.workContent.showsVerticalScrollIndicator = NO;
//        working.frame = CGRectMake(0, workingY, WIDETH, gH);
//        [self.scro  addSubview: working];
//    }
//    y = y + gH *  ((NSArray *)self.dataDic[@"work"]).count;
//    
//    /*教育经历**/
//    CGFloat jH = 175;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"jy"]).count; i++)
//    {
//        CGFloat educationY = y + i * jH;
//        EducationExperienceView * education  = [EducationExperienceView setEducationExperienceView];
//        education.frame = CGRectMake(0, educationY, WIDETH, jH);
//        education.departmentIntroduce.editable = NO;
//        education.departmentIntroduce.showsVerticalScrollIndicator = NO;
//        [education configVulue:self.dataDic[@"jy"] withArrIndex:i];
//        [self.scro addSubview:education];
//        
//    }
//    y = y + jH *  ((NSArray *)self.dataDic[@"jy"]).count;
//    
//    /*专业技能**/
//    CGFloat zH = 120 ;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"skill"]).count; i++)
//    {
//        
//        CGFloat professionalSkillViewY = y + i*zH;
//        professionalSkillView * skill = [professionalSkillView setprofessionalSkillView];
//        
//        [skill conFigValue:self.dataDic[@"skill"] withArrIndex:i];
//        skill.frame = CGRectMake(0, professionalSkillViewY, WIDETH, zH);
//        [self.scro addSubview:skill];
//    }
//    
//    y = y + zH *  ((NSArray *)self.dataDic[@"skill"]).count;
//    /*项目经验**/
//    CGFloat xH = 140;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"project"]).count; i++)
//    {
//        CGFloat projectY = y + i * xH;
//        ProjectExperienceView * project =[ProjectExperienceView setProjectExperienceView];
//        project.frame = CGRectMake(0, projectY, WIDETH, xH);
//        project.proIntroduce.editable = NO;
//        project.proIntroduce.showsVerticalScrollIndicator = NO;
//        [project configValue:self.dataDic[@"project"] withArrIndex:i];
//        [self.scro addSubview:project];
//    }
//    y  = y + xH * ((NSArray *)self.dataDic[@"project"]).count;
//    
//    /*证书**/
//    CGFloat ZSh = 155;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"cert"]).count; i++)
//    {
//        CGFloat certificY = y + i * ZSh;
//        CertificateView * certific = [CertificateView setCertificateView];
//        certific.certificateIntroduce.editable = NO;
//        certific.certificateIntroduce.showsVerticalScrollIndicator = NO;
//        [certific configValue:self.dataDic[@"cert"] withArrIndex:i];
//        certific.frame = CGRectMake(0, certificY, WIDETH, ZSh);
//        [self.scro addSubview:certific];
//    }
//    y = y + ZSh * ((NSArray *)self.dataDic[@"cert"]).count;
//    
//    /*培训内容**/
//    CGFloat Ph = 155;
//    for (int i = 0; i < ((NSArray *)self.dataDic[@"training"]).count; i ++)
//    {
//        CGFloat trainY = y + i * Ph;
//        trainingExperienceView * train = [trainingExperienceView settrainingExperienceView];
//        train.frame = CGRectMake(0,trainY, WIDETH, Ph);
//        train.trainIntroduce.editable = NO;
//        train.trainIntroduce.showsVerticalScrollIndicator = NO;
//        [train configValue:self.dataDic[@"training"] withArrIndex:i];
//        [self.scro addSubview:train];
//    }
//    y = y + ((NSArray *)self.dataDic[@"training"]).count * Ph;
//    
//    /*自我评价**/
//    CGFloat ZWH= 70;
//    SelfEvaluationView * selfevaluat =[SelfEvaluationView setSelfEvaluationView];
////    selfevaluat.frame = CGRectMake(0, 810+135+205+200+200, WIDETH, 100);
//    selfevaluat.frame = CGRectMake(0, y, WIDETH, ZWH);
//    selfevaluat.selfEvaluation.editable = NO;
//    selfevaluat.selfEvaluation.showsVerticalScrollIndicator = NO;
//    [selfevaluat configValue:self.dataDic[@"other"]];
//    [self.scro addSubview:selfevaluat];
//    
////    self.scro.contentSize   = CGSizeMake(WIDETH, 810+135+205+200+200+100);
//    self.scro.contentSize   = CGSizeMake(WIDETH, y + ZWH);
//    
//}

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
