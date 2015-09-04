//
//  TH_EducationExperienceVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_EducationExperienceVC.h"
#import "EducationTimeCell.h"
#import "EducationWriteCell.h"
#import "EducationReadVC.h"

#import "WriteRusumeModel2.h"

#import "WriteResumeRequest.h"
#import "AppDelegate.h"


@interface TH_EducationExperienceVC ()<UITableViewDataSource,UITableViewDelegate>
{
    WriteRusumeModel2 * _model;
}
@property(nonatomic,strong)UITableView * tableView ;
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UITextView * contentTextField;
@property(nonatomic,strong)UIScrollView * scro;
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property(strong,nonatomic)NSMutableArray * jobArray;
@end

@implementation TH_EducationExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jobArray = [NSMutableArray arrayWithCapacity:0];
    _model = [[WriteRusumeModel2 alloc] init];
    [self createScro];
    [self createView];
     [self setData];
    

    }
-(void)setData
{
    self.nameArray = @[@"学校名称",@"在校时间",@"所学专业",@"社团职位"];
    self.holderArray = @[@"请填写学校名称",@"",@"请填写学专业",@"请填写社团职位"];
}
-(void)createScro
{self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}
-(void)createView
{   UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 135, 20) Font:13 Text:@"个人简历001-教育经历"];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(160, 13, 53, 23) ImageName:@"hongniu2" Target:self Action:nil Title:@"必填项"];
    [stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.scro addSubview:stateBtn];

    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, WIDETH, 168)];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.tableView = tableview;
    tableview.scrollEnabled= NO;
    tableview.layer.borderWidth = 0.5;
    tableview.layer.borderColor = color(221, 221, 221).CGColor;
     tableview.separatorColor = color(221, 221, 221);
    [self.scro addSubview:tableview];
    
    //下方View
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 233, WIDETH, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    [self.scro addSubview:bgView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 52, 21) Font:13 Text:@"工作内容"];
    [bgView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(77, 46, 1, 26)];
    line.backgroundColor = color(203, 203, 203);
    [bgView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(87, 6, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = color(203, 203, 203);
    self.contentTextField.text = @"请填写工作内容";
    [bgView addSubview:self.contentTextField];
    
    //下方按钮
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 368, (WIDETH-150-18)/2.0, 30) ImageName:@"hongniu2" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),368, (WIDETH-150-18)/2.0, 30) ImageName:@"lanniu2" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:replaceBtn];
}
/*保存**/
-(void)saveBtnClick
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
        {
            EducationTimeCell * cell = self.jobArray[i];
            if(!cell.startTime.selected)
            {
                [MBProgressHUD creatembHub:@"请输入开始时间"];
                return;
            }
            
            if(cell.startTime.selected)
            {
                if(!cell.endTime.selected)
                {
                    [MBProgressHUD creatembHub:@"请输入结束时间"];
                    return;
                }
            }
            _model.sdate = cell.startTime.titleLabel.text;
            _model.edate = cell.endTime.titleLabel.text;
        }else
        {
            EducationWriteCell * cell = self.jobArray[i];
            if([cell.educationContentTextFile.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请输入%@",cell.educationTitleLable.text]];
                return;
            }
            if(i == 0)
            {
                _model.name = [cell.educationTitleLable.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            if(i == 2)
            {
                _model.department = [cell.educationTitleLable.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            if(i == 3)
            {
                _model.position = [cell.educationTitleLable.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
        }
        
    }
    

   

    if(self.contentTextField.text.length < 30)
    {
        [MBProgressHUD creatembHub:@"请输入至少15个字"];
        return;
    }else
    {
        _model.content = [self.contentTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    [[WriteResumeRequest uploadEducationWithSucc:^(NSDictionary *dataDic) {
        EducationReadVC * eduCation =[[EducationReadVC alloc] init];
        eduCation.model = _model;
        [self.navigationController pushViewController:eduCation animated:YES];
    } WithResumeParam:@{@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"name":_model.name,@"sdate":_model.sdate,@"edate":_model.edate,@"specialty":_model.department,@"title":_model.position,@"content":_model.content}] addNotifaction:hub];
    

}
/*重置**/
-(void)replaceBtnClick
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
        EducationTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"EducationTimeCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [self.jobArray addObject:cell];
        return cell;
    }
    EducationWriteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WriteCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EducationWriteCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.educationTitleLable.text = self.nameArray[indexPath.row];
    cell.educationContentTextFile.placeholder= self.holderArray[indexPath.row];

   [self.jobArray addObject:cell];
    
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
    {
        continue;
    }
        EducationWriteCell * cell = self.jobArray[i];
        [cell.educationContentTextFile resignFirstResponder];
    }
    [self.contentTextField resignFirstResponder];
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
