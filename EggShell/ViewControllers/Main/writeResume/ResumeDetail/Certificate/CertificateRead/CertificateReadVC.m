//
//  CertificateReadVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CertificateReadVC.h"
#import "CertificateReadView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
#import "PersonalInformationBaseCell.h"
#import "personalInformationTitleView.h"
#import "TH_CertificateVC.h"
@interface CertificateReadVC ()<UITableViewDataSource,UITableViewDelegate>
{
    ResumeModel * _resume_model;

}
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation CertificateReadVC
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
//    personTitle.personTitleLable.text = [NSString stringWithFormat:@"%@-证书",_resume_model.resumeName];
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@-证书",_resume_model.resumeName];
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
    [addButtn setTitle:@"+添加证书" forState:UIControlStateNormal];
    addButtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 50)];
    self.tableView.tableFooterView = footerView;
    [footerView addSubview:addButtn];
}

#pragma mark 继续添加
-(void)addClick
{
    TH_CertificateVC *vc = [[TH_CertificateVC alloc]init];
    vc.pushtype = 0;
    vc.resumeId = self.resuemId;
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
    cell.limitedTimeLable.text = [NSString stringWithFormat:@"颁发时间:%@", dic[@"sdate"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic =self.dataArray[indexPath.row];
    TH_CertificateVC *vc = [[TH_CertificateVC alloc]init];
    vc.cerName = dic[@"name"];
    vc.awardTime = dic[@"sdate"];
    vc.awardCompany = dic[@"title"];
    vc.content = dic[@"content"];
    vc.detailId = dic[@"id"];
    vc.pushtype = 1;
    vc.resumeId = self.resuemId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
   [[WriteResumeRequest certificatesReadingWithSucc:^(NSDictionary *dataDic) {
       self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
//       [self createView];
       [self.tableView reloadData];
       
   } certificatesReadingParam:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
}
-(void)createView

{   UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    for (int i = 0; i <self.dataArray.count; i++) {
        

{

    CertificateReadView * certific = [CertificateReadView setCertificateReadView];
   
    [certific configValue:self.dataArray[i]];
     certific.certificContent.editable = NO;
    certific.certificContent.showsVerticalScrollIndicator = NO;
    certific.resumNameTitle.text = [NSString stringWithFormat:@"%@-证书%d",_resume_model.resumeName,i+1];
    certific.frame = CGRectMake(0, 200*i, WIDETH, 200);
    [self.scro addSubview:certific];
        if (i>0) {
            certific.selectBtn.hidden = YES;
        }
    /*继续添加**/
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH  - 150)/2.0, 200*self.dataArray.count+35, 150, 30)];
    [button addTarget:self action:@selector(addbUttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [button setTitle:@"添加证书" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.scro addSubview:button];
        self.scro.contentSize = CGSizeMake(WIDETH, 200*self.dataArray.count+150);
    
    }
    }
}
#pragma mark --继续添加
-(void)addbUttonClick
{
    
   [self.navigationController popViewControllerAnimated:YES];
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
//    [self.navigationController pushViewController:working animated:YES];
}
-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:NO];
    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
    [self.navigationController popToViewController:write animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
