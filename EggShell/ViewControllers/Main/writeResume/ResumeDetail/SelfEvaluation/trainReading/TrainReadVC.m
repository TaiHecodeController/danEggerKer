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
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
#import "TH_TrainExperienceVC.h"

@interface TrainReadVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;
    
    
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation TrainReadVC
-(void)viewWillAppear:(BOOL)animated
{
    /***/
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
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
     _resume_model = [ResumeModel sharedResume];
    [self createTableView];
}
-(void)createTableView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@-培训经历",_resume_model.resumeName];
    titleLab.font = [UIFont systemFontOfSize:13];
    CGSize titleLabSize = [titleLab.text sizeWithFont:[UIFont systemFontOfSize:13]];
    titleLab.frame = CGRectMake(10, 0, titleLabSize.width, 40);
    [titleView addSubview:titleLab];
    
    UIImageView *selectedIcon = [[UIImageView alloc]init];
    selectedIcon.image = [UIImage imageNamed:@"kexuan2"];
    selectedIcon.frame = CGRectMake(CGRectGetMaxX(titleLab.frame) + 5, 7.5, 82, 25);
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
    [addButtn setTitle:@"+添加培训经历" forState:UIControlStateNormal];
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
    TH_TrainExperienceVC *vc = [[TH_TrainExperienceVC alloc]init];
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
    TH_TrainExperienceVC *vc = [[TH_TrainExperienceVC alloc]init];
    vc.train = dic[@"name"];
    vc.sdate = dic[@"sdate"];
    vc.edate = dic[@"edate"];
    vc.trainDirection = dic[@"title"];
    vc.content = dic[@"content"];
    vc.detailId = dic[@"id"];
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
    [[WriteResumeRequest trainingExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
        
    } trainingExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
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
    [button setTitle:@"添加培训经历" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, self.dataArray.count* 200+150);
    
    }
}
#pragma mark --继续添加
-(void)addbUttonClick
{
//  [self.navigationController popViewControllerAnimated:NO];
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
//    [self.navigationController pushViewController:working animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
   
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
