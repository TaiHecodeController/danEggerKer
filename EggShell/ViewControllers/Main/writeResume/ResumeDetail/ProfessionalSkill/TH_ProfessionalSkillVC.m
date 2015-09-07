//
//  TH_ProfessionalSkillVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ProfessionalSkillVC.h"
#import "ProfessionalCell.h"
#import "WriteRusumeModel2.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
#import "ResumeModel.h"
@interface TH_ProfessionalSkillVC ()<UITableViewDelegate,UITableViewDataSource>
{
    WriteRusumeModel2 * _model;
    ResumeModel * _resume_model;
}
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property(strong,nonatomic)NSArray * imageArray;
@property(strong,nonatomic)NSMutableArray * jobCellArr;
@end

@implementation TH_ProfessionalSkillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jobCellArr = [NSMutableArray arrayWithCapacity:0];
    _model = [[WriteRusumeModel2 alloc] init];
    _resume_model = [ResumeModel sharedResume];
    [self createScro];
    [self createView];
    [self setData];
}
-(void)setData
{
    self.nameArray = @[@"技能名称",@"技能类别",@"熟练程度",@"掌握时间"];
    self.holderArray = @[@"请填写培训中心",@"请填写技能类别",@"请选择熟练程度",@"请填写掌握时间"];
    self.imageArray  = @[@"",@"xiala-拷贝",@"xiala-拷贝",@""];
}
-(void)createScro
{self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}
-(void)createView
{   UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 135, 13) Font:13 Text:[NSString stringWithFormat:@"%@-专业技能",_resume_model.resumeName]];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(160, 9.5, 53, 23) ImageName:@"lanniu2" Target:self Action:nil Title:@"可选填"];
    [stateBtn setTitleColor:color(255, 255, 255) forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.scro addSubview:stateBtn];
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, WIDETH, 168)];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.tableView = tableview;
    tableview.scrollEnabled= NO;
    tableview.layer.borderWidth = 0.5;
    tableview.layer.borderColor = color(221, 221, 221).CGColor;
     tableview.separatorColor = color(221, 221, 221);
    [self.scro addSubview:tableview];
    
    
        //下方按钮
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 225, (WIDETH-150-18)/2.0, 30) ImageName:@"hongniu2" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),225, (WIDETH-150-18)/2.0, 30) ImageName:@"lanniu2" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:replaceBtn];
    
    
}
/*保存**/
-(void)saveBtnClick
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        ProfessionalCell * cell = self.jobCellArr[i];
        
        if([cell.profisionTextField.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请输入%@",cell.profesionNameLable.text]];
                return;
            }
        if(i == 0)
        {
            _model.name = cell.profisionTextField.text;
        }
        
        if(i == 1)
        {
            _model.skillType = cell.profisionTextField.text;
        }
        if(i == 2)
        {
            _model.skillDegree = cell.profisionTextField.text;
        }
        if(i == 3)
        {
            _model.skillTime = cell.profisionTextField.text;
        }
        
    }
    
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    
    [[WriteResumeRequest uploadProfessionalSkillWithSucc:^(NSDictionary *dataDic) {
        [MBProgressHUD creatembHub:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } WithResumeParam:@{@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"name":_model.name,@"skill":_model.skillType,@"ing":_model.skillDegree,@"longtime":_model.skillTime}] addNotifaction:hub];
    
    
    

}
/*重置**/
-(void)replaceBtnClick
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        ProfessionalCell * cell = self.jobCellArr[i];
        cell.profisionTextField.text = @"";
        
    }
    [self.jobCellArr removeAllObjects];
    [_tableView reloadData];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfessionalCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfessionalCell" owner:self options:nil] lastObject];
    }
    cell.profesionNameLable.text = self.nameArray[indexPath.row];
    cell.profisionTextField.placeholder= self.holderArray[indexPath.row];
    cell.logoImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    [self.jobCellArr addObject:cell];
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        ProfessionalCell * cell = self.jobCellArr[i];
        [cell.profisionTextField resignFirstResponder];
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
