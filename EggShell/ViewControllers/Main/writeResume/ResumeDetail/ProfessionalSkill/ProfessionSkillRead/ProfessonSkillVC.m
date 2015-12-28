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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeMessage" object:self];
}
-(void)viewDidDisappear:(BOOL)animated
{ [super viewWillDisappear:NO];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"writeresum" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     _resume_model = [ResumeModel sharedResume];
    [self createTableView];
    [self loadData];
    
}
-(void)createTableView
{
    //个人简历标题
    personalInformationTitleView * personTitle = [personalInformationTitleView setpersonalInformationTitleView];
    personTitle.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.view addSubview:personTitle];
    personTitle.personTitleLable.text  = [NSString stringWithFormat:@"%@-转技能",_resume_model.resumeName];
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT-40-64)];
    tableView.dataSource = self;
    tableView.delegate = self;
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
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
//    [self.navigationController pushViewController:working animated:YES];
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
   
    
    
}

-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    [[WriteResumeRequest readingSkillWithSucc:^(NSDictionary *dataDic) {
        self.dataArray =[NSArray arrayWithArray:dataDic[@"data"]];
        [self.tableView reloadData];
        
    } readingSkillgParam:param] addNotifaction:[MBProgressHUD mbHubShowControllerView:self]];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
