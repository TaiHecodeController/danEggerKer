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
    [addButtn setTitle:@"添加" forState:UIControlStateNormal];
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
    [cell configValeus:dic];
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

//-(void)createView
//{
//    for (int i = 0; i< self.dataArray.count; i++) {
//        _resume_model = [ResumeModel sharedResume];
//        WorkExReadingView * workingView =[WorkExReadingView setView];
//        //添加手势
//        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editClick:)];
//        [workingView addGestureRecognizer:tap];
//        
//        workingView.frame = CGRectMake(0, 215*i, WIDETH, 215);
//        workingView.resumTitle.text = [NSString stringWithFormat:@"%@-工作经历%d",_resume_model.resumeName,i+1];
//        [workingView.descriptionTextView setEditable:NO];
//        workingView.descriptionTextView.showsVerticalScrollIndicator  = NO;
//        workingView.descriptionTextView.scrollEnabled = YES;
//        
//        THLog(@"self.dataArray:%@",self.dataArray);
//        
//        [workingView config:self.dataArray[i]];
//        [self.scro addSubview:workingView];
//        if (i>0) {
//            workingView.workBtn.hidden = YES;
//        }
//        UIButton * addButtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH - 150)/2.0, 215*self.dataArray.count+35, 150, 30)];
//        [addButtn setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
//        addButtn.titleLabel.font =[UIFont  systemFontOfSize:13];
//        [addButtn setTitle:@"添加工作经历" forState:UIControlStateNormal];
//        addButtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.scro addSubview:addButtn];
//       
//        
//        self.scro.contentSize = CGSizeMake(WIDETH, self.dataArray.count*215+150);
//    }
//}
//
//- (void)editClick:(UITapGestureRecognizer *)tap
//{
//    THLog(@"查看详情");
////    self.companyNameLable.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
////    self.HoldTimelable.text = [dic[@"sdate"] stringByAppendingFormat:@"-%@",dic[@"edate"]];
////    self.DepartmentLable.text = dic[@"department"];
////    self.descriptionTextView.text = dic[@"content"];
////    self.OfficeLable.text = dic[@"title"];
////    self.detailId = dic[@"id"];
//   WorkExReadingView *wv = (WorkExReadingView *)tap.view;
////wv.detailId
////    THLog(@"%@",wv.detailId);
//    WorkingExperienceVC *vc = [[WorkingExperienceVC alloc]init];
//    vc.company = wv.companyNameLable.text;
//    vc.startTime = wv.startTime;
//    vc.endTime = wv.endTime;
//    vc.deprtment = wv.DepartmentLable.text;
//    vc.position = wv.OfficeLable.text;
//    vc.workContent = wv.descriptionTextView.text;
//    vc.detailId = wv.detailId;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    
//}
//
-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:YES];
//    for(UIViewController *controller in self.navigationController.viewControllers) {
//        if([controller isKindOfClass:[WriteResumeVC2 class]]){
//            WriteResumeVC2*owr = (WriteResumeVC2 *)controller;
//            [self.navigationController popToViewController:owr animated:YES];
//            
//        }
        //    [self.navigationController popViewControllerAnimated:NO];
        //    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
        //    [self.navigationController popToViewController:write animated:YES];
        //
        //    [self.navigationController pushViewController:write animated:YES];
//    }
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
