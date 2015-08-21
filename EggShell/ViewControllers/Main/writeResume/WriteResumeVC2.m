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
@interface WriteResumeVC2 ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * writeTabView;
}
@property (strong,nonatomic)NSArray * nameArray;
@end

@implementation WriteResumeVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
    self.view.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    
    [self createUI];
    [self createData];
    // Do any additional setup after loading the view.
}

-(void)createData
{
    self.nameArray = @[@"工作经历",@"教育经历",@"培训经历",@"专业技能",@"项目经验",@"证书",@"自我评价"];
}

-(void)createUI
{
    self.resumeNameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 10, 120, 20) Font:14 Text:@"个人简历001"];
    [self.view addSubview:self.resumeNameLab];
    
    writeTabView = [[UITableView alloc] initWithFrame:CGRectMake(-15, 42, WIDETH + 15, 294)];
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
    return 7;
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
        cell.stateBtn.selected = NO;
    }else
    {
        cell.stateBtn.selected = YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            WorkingExperienceVC * wvc = [[WorkingExperienceVC alloc] init];
            [self.navigationController pushViewController:wvc animated:YES];
        }
            break;
        case 1:
        {
            TH_EducationExperienceVC * education = [[TH_EducationExperienceVC alloc] init];
            education.title = @"教育经历";
            [self.navigationController pushViewController:education animated:YES];
            
        }
            break;
        case 2:
        {
            TH_TrainExperienceVC * train = [[TH_TrainExperienceVC alloc] init];
            train.title = @"培训经历";
            [self.navigationController pushViewController:train animated:YES];
        }
            break;
        case 3:
        {
            TH_ProfessionalSkillVC * skill = [[TH_ProfessionalSkillVC alloc] init];
            skill.title = @"专业技能";
            [self.navigationController pushViewController:skill animated:YES];
        }
            break;
        case 4:
        {
            TH_ProjectExperienceVC * project = [[TH_ProjectExperienceVC alloc] init];
            project.title = @"项目经验";
            [self.navigationController pushViewController:project animated:YES];
        }break;
        case 5:
        {
            TH_CertificateVC * certificate = [[TH_CertificateVC alloc] init];
            certificate.title = @"自我评价";
            [self.navigationController pushViewController:certificate animated:YES];
        }
            break ;
            
        case 6:
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
