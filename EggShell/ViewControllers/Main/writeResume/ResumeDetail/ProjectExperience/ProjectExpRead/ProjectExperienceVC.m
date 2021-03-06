

//
//  ProjectExperienceVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProjectExperienceVC.h"
#import "ProjectExpReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
#import "TH_ProjectExperienceVC.h"
@interface ProjectExperienceVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;
    
    
}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;

@end

@implementation ProjectExperienceVC
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
    //个人简历标题
//    personalInformationTitleView * personTitle = [personalInformationTitleView setpersonalInformationTitleView];
//    personTitle.frame = CGRectMake(0, 0, WIDETH, 40);
//    [self.view addSubview:personTitle];
//    personTitle.personBackBtn.selected = YES;
//     personTitle.personTitleLable.text = [NSString stringWithFormat:@"%@-项目经验",_resume_model.resumeName];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@-项目经验",_resume_model.resumeName];
    titleLab.font = [UIFont systemFontOfSize:13];
    CGSize titleLabSize = [titleLab.text sizeWithFont:[UIFont systemFontOfSize:13]];
    titleLab.frame = CGRectMake(10, 0, titleLabSize.width, 40);
    [titleView addSubview:titleLab];
    
    UIImageView *selectedIcon = [[UIImageView alloc]init];
    selectedIcon.image = [UIImage imageNamed:@"kexuan2"];
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
    [addButtn setTitle:@"+添加项目经验" forState:UIControlStateNormal];
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
    TH_ProjectExperienceVC *vc = [[TH_ProjectExperienceVC alloc]init];
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
    TH_ProjectExperienceVC *vc = [[TH_ProjectExperienceVC alloc]init];
    vc.Projectexperience = dic[@"name"];
     vc.sdate = dic[@"sdate"];
     vc.edate = dic[@"edate"];
     vc.projectEnvironmental = dic[@"sys"];
     vc.postion = dic[@"title"];
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
    
    [[WriteResumeRequest projectExperienceReadingWithSucc:^(NSDictionary *dataDic) {
        self.dataArray = [NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
    } projectExperienceReadingParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}


-(void)createView
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i=0 ; i < self.dataArray.count; i++) {
        
    ProjectExpReadView * project =[ProjectExpReadView setProjectExperienceView];
    project.frame = CGRectMake(0, 215*i, WIDETH,215);
        project.ProjectContentLable.editable = NO;
        project.ProjectContentLable.showsVerticalScrollIndicator = NO;
    [project configValue:self.dataArray[i]];
    project.resumTitle.text = [NSString stringWithFormat:@"%@-项目经验%d",_resume_model.resumeName,i+1];
    [self.scro addSubview:project];
        if (i>0) {
            project.selectBtn.hidden = YES;
        }
        self.scro.contentSize = CGSizeMake(WIDETH, 215*self.dataArray.count+150);
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
