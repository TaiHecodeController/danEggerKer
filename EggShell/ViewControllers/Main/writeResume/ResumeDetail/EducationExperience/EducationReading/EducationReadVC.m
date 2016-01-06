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
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
#import "TH_EducationExperienceVC.h"

@interface EducationReadVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;
    

}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation EducationReadVC
-(void)viewWillAppear:(BOOL)animated
{
     [self loadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    _resume_model = [ResumeModel sharedResume];
    [self createTableView];
   
}
-(void)createTableView
{
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@-教育经历",_resume_model.resumeName];
    titleLab.font = [UIFont systemFontOfSize:13];
    CGSize titleLabSize = [titleLab.text sizeWithFont:[UIFont systemFontOfSize:13]];
    titleLab.frame = CGRectMake(10, 0, titleLabSize.width, 40);
    [titleView addSubview:titleLab];
    
    UIImageView *selectedIcon = [[UIImageView alloc]init];
    selectedIcon.image = [UIImage imageNamed:@"bixuan2"];
    selectedIcon.frame = CGRectMake(CGRectGetMaxX(titleLab.frame) + 5, 7.5, 54, 25);
    [titleView addSubview:selectedIcon];
    
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
    [addButtn setTitle:@"+添加教育经历" forState:UIControlStateNormal];
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
    TH_EducationExperienceVC *vc = [[TH_EducationExperienceVC alloc]init];
    vc.pushtype = 0;
    vc.resumeId = self.resumeId;
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
    cell.jobNameLable.text = dic[@"specialty"];
    cell.limitedTimeLable.text = [dic[@"sdate"] stringByAppendingFormat:@"到%@",dic[@"edate"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic =self.dataArray[indexPath.row];
    TH_EducationExperienceVC *vc = [[TH_EducationExperienceVC alloc]init];
    vc.company = dic[@"name"];
    vc.sdate = dic[@"sdate"];
    vc.edate =dic[@"edate"];
    vc.specialty =dic[@"specialty"];
    vc.Edutitle =dic[@"title"];
    vc.content =dic[@"content"];
    vc.detailId =dic[@"id"];
    vc.pushtype = 1;
    vc.resumeId = self.resumeId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    [[WriteResumeRequest rducationExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
        
    } educationExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}
#pragma mark --继续添加
-(void)addbUttonClick
{
}
-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
