//
//  WorkExReadingVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkExReadingVC.h"
#import "WorkExReadingView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
@interface WorkExReadingVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation WorkExReadingVC
-(void)viewWillAppear:(BOOL)animated
{
    /***/
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
    
    //填写或修改完简历，刷新页面
    [self loadData];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"writeresum" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    self.dataArray = [NSArray array];
    [self createTableView];
    
}
-(void)createTableView
{
    //个人简历标题
    personalInformationTitleView * personTitle = [personalInformationTitleView setpersonalInformationTitleView];
    personTitle.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:personTitle];
    _resume_model = [ResumeModel sharedResume];
    personTitle.personTitleLable.text = [NSString stringWithFormat:@"%@-工作经历",_resume_model.resumeName];
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
    [addButtn setTitle:@"+添加工作经历" forState:UIControlStateNormal];
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
    //    [self.navigationController popViewControllerAnimated:YES];
    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
    working.pushtype = addPush;
    working.resumeId = self.resumeId;
    [self.navigationController pushViewController:working animated:YES];
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
    cell.jobNameLable.text = dic[@"title"];
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
    WorkingExperienceVC *vc = [[WorkingExperienceVC alloc]init];
    vc.company = dic[@"name"];
    vc.startTime = dic[@"sdate"];
    vc.endTime = dic[@"edate"];
    vc.deprtment = dic[@"department"];
    vc.position =  dic[@"title"];
    vc.workContent = dic[@"content"];
    vc.detailId = dic[@"id"];
    vc.pushtype = editPush;
    vc.resumeId = self.resumeId;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    [[WriteResumeRequest resumeWritingPreviewWithSucc:^(NSDictionary *dataDic) {
        self.dataArray = [NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
        
    } resumeWritingPreviewParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}

-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
