//
//  ProfessonSkillVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProfessonSkillVC.h"
#import "ProfessonSkillReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
#import "TH_ProfessionalSkillVC.h"
@interface ProfessonSkillVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;
    

}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;



@end

@implementation ProfessonSkillVC
-(void)viewWillAppear:(BOOL)animated
{
    /***/
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeMessage" object:self];
    [self loadData];

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"writeresum" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
     _resume_model = [ResumeModel sharedResume];
    [self createTableView];
    
}
-(void)createTableView
{
    //个人简历标题
    personalInformationTitleView * personTitle = [personalInformationTitleView setpersonalInformationTitleView];
    personTitle.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:personTitle];
    personTitle.personBackBtn.selected = YES;
    personTitle.personTitleLable.text  = [NSString stringWithFormat:@"%@-专业技能",_resume_model.resumeName];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT-40-64)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    //添加工作经历
    UIButton * addButtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 15, WIDETH-160, 30)];
    [addButtn setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    addButtn.titleLabel.font =[UIFont  systemFontOfSize:13];
    [addButtn setTitle:@"+添加专业技能" forState:UIControlStateNormal];
    addButtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 50)];
    self.tableView.tableFooterView = footerView;
    [footerView addSubview:addButtn];
    
}
#pragma mark --继续添加
-(void)addClick
{
    TH_ProfessionalSkillVC *vc = [[TH_ProfessionalSkillVC alloc]init];
    vc.dataDic = self.dataDic;
    vc.pushtype = 0;
    vc.resumId = self.resumeId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalInformationBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonalInformationBaseCell" owner:self options:nil] lastObject];
        
    }
    NSDictionary * dic =self.dataArray[indexPath.row];
    cell.companyNameLable.text = dic[@"name"];
    cell.jobNameLable.text = dic[@"skill"];
    cell.limitedTimeLable.text = [NSString stringWithFormat:@"%@年",dic[@"longtime"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic =self.dataArray[indexPath.row];
    TH_ProfessionalSkillVC *vc = [[TH_ProfessionalSkillVC alloc]init];
    vc.skillName = dic[@"name"];
    vc.skillType = dic[@"skill"];
    vc.skillDegree = dic[@"ing"];
    vc.time = dic[@"longtime"];
    vc.detailId = dic[@"id"];
    //技能熟练度，技能类型的选项数据
    vc.dataDic = self.dataDic;
    vc.pushtype = 1;
    vc.resumId = self.resumeId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    [[WriteResumeRequest readingSkillWithSucc:^(NSDictionary *dataDic)
    {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
        
    } readingSkillgParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}

-(void)createView
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator =NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i = 0; i < self.dataArray.count; i++) {
        
   
    ProfessonSkillReadView  * prosion = [ProfessonSkillReadView setProfessonSkillReadView];
    prosion.frame = CGRectMake(0, 152*i, WIDETH, 152);
    prosion.resumTitleLable.text  = [NSString stringWithFormat:@"%@-转技能%d",_resume_model.resumeName,i+1];
    [prosion configValue:self.dataArray[i]];
    [self.scro addSubview:prosion];
        if (i>0) {
            prosion.selectBtn.hidden = YES;
        }
            self.scro.contentSize = CGSizeMake(WIDETH, 152*self.dataArray.count+150);
    
    }
}

-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:YES];
//    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
//    [self.navigationController popToViewController:write animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
