//
//  WorkingExperienceVC.m
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkingExperienceVC.h"
#import "WriteResumeCell.h"
#import "WorkingTimeCell.h"

@interface WorkingExperienceVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property(strong,nonatomic)NSMutableArray * jobArray;

@end

@implementation WorkingExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作经历";
    [self createUI];
    [self createData];
    // Do any additional setup after loading the view.
}

-(void)createData
{
    self.nameArray = @[@"单位名称",@"工作时间",@"所在部门",@"担任职位"];
    self.holderArray = @[@"请填写单位名称",@"",@"请填写所在部门",@"请填写担任职位"];
    
}

-(void)createUI
{
    self.view.backgroundColor = color(243, 243, 241);
    UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 150, 20) Font:14 Text:@"个人简历001-工作经历"];
    [self.view addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(165, 15, 53, 23) ImageName:@"hongniu2" Target:self Action:nil Title:@"必填项"];
    [stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:stateBtn];
    
    //中间tableView
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(-1, 45, WIDETH + 1, 168)];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.layer.borderWidth = 0.5;
    tableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
     tableView.separatorColor = color(221, 221, 221);
    [self.view addSubview:tableView];
    
    //下方View
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(-1, 233, WIDETH, 120)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 0.5;
    backView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    [self.view addSubview:backView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 57, 21) Font:13 Text:@"工作内容"];
    [backView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(81, 48, 1, 28)];
    line.backgroundColor = color(203, 203, 203);
    [backView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(91, 6, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = color(203, 203, 203);
    self.contentTextField.text = @"请填写工作内容";
    [backView addSubview:self.contentTextField];
    
    //下方按钮
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 - 100, 368, 90, 29) ImageName:@"hongniu2" Target:self Action:@selector(saveClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 + 10, 368, 90, 29) ImageName:@"lanniu2" Target:self Action:@selector(replaceClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:replaceBtn];
}

-(void)saveClick
{
    
}

-(void)replaceClick
{
    
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
    if(indexPath.row == 1)
    {
        WorkingTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkingTimeCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    WriteResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WriteCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.resumeName.text = self.nameArray[indexPath.row];
    cell.contentTextField.placeholder = self.holderArray[indexPath.row];
    [self.jobArray addObject:cell];
    return cell;
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
