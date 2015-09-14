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

#import "WriteRusumeModel2.h"


#import "WorkExReadingVC.h"


#import "WriteResumeRequest.h"
#import "AppDelegate.h"
#import "ResumeModel.h"
#import <UIKit/UIKit.h>
@interface WorkingExperienceVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    UITableView * _tableView;
    WriteRusumeModel2 * _model;
    ResumeModel * _resume_model;
}
@property(strong,nonatomic)NSArray * nameArray;
@property(strong,nonatomic)UIScrollView * scro;
@property(nonatomic,strong)UILabel * placeHoderTextLable;
@property (strong,nonatomic)NSArray * holderArray;
@property(strong,nonatomic)NSMutableArray * jobArray;

@end

@implementation WorkingExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"工作经历";
    self.jobArray = [NSMutableArray arrayWithCapacity:0];
    _model = [[WriteRusumeModel2 alloc] init];
    _resume_model = [ResumeModel sharedResume];
    [self createScro];
    [self createUI];
    [self createData];
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
    if(i == 1)
        {
            WorkingTimeCell * cell = self.jobArray[i];
            cell.StartTime.selected = NO;
            cell.endTime.selected = NO;
            cell.todaySelect.selected = NO;

            
            
        
        }else
        {
             WriteResumeCell * cell = self.jobArray[i];
            if(i == 0)
            {
                 cell.contentTextField.text = @"";
            }
            if(i == 2)
            {
                cell.contentTextField.text = @"";
            }
            if(i == 3)
            {
                 cell.contentTextField.text = @"";
            }

        }
     self.contentTextField.text  = @"";
        

        
    }
        }
-(void)createScro
{  self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
-(void)createData
{
    self.nameArray = @[@"单位名称",@"工作时间",@"所在部门",@"担任职位"];
    self.holderArray = @[@"请填写单位名称",@"",@"请填写所在部门",@"请填写担任职位"];
}

-(void)createUI
{
    self.view.backgroundColor = color(243, 243, 241);
    UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 150, 20) Font:14 Text:[NSString stringWithFormat:@"%@-工作经历",_resume_model.resumeName]];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(165, 15, 53, 23) ImageName:@"hongniu2" Target:self Action:nil Title:@"必填项"];
    [stateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.scro addSubview:stateBtn];
    
    //中间tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(-1, 45, WIDETH + 1, 168)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.layer.borderWidth = 0.5;
    _tableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
     _tableView.separatorColor = color(221, 221, 221);
    [self.scro addSubview:_tableView];
    
    //下方View
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(-1, 233, WIDETH, 120)];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderWidth = 0.5;
    backView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    [self.scro addSubview:backView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 57, 21) Font:13 Text:@"工作内容"];
    [backView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(81, 48, 1, 28)];
    line.backgroundColor = color(203, 203, 203);
    [backView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(91, 6, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = [UIColor blackColor];
    self.contentTextField.delegate = self;
    [backView addSubview:self.contentTextField];
    /*显示隐藏内容**/
    UILabel * placeHoderTextLable =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDETH - 121, 30)];
    placeHoderTextLable.text = @"请填写培训内容";
    placeHoderTextLable.textColor = color(203, 203, 203);
    self.placeHoderTextLable = placeHoderTextLable;
    [self.contentTextField addSubview:placeHoderTextLable];
    self.placeHoderTextLable.font = [UIFont systemFontOfSize:13];
    
    //下方按钮
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 - 100, 368, 90, 29) ImageName:@"hongniu2" Target:self Action:@selector(saveClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 + 10, 368, 90, 29) ImageName:@"lanniu2" Target:self Action:@selector(replaceClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:replaceBtn];
}
#pragma mark - 保存简历阅览
-(void)saveClick
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
        {
            WorkingTimeCell * cell = self.jobArray[i];
            if(!cell.StartTime.selected)
            {
                [MBProgressHUD creatembHub:@"请输入开始时间"];
                return;
            }
        
            if(cell.StartTime.selected)
            {
                if(!cell.endTime.selected)
                {
                    [MBProgressHUD creatembHub:@"请输入结束时间"];
                    return;
                }
            }
            _model.sdate = cell.StartTime.titleLabel.text;
            _model.edate = cell.endTime.titleLabel.text;
            
            
        }else
        {
            WriteResumeCell * cell = self.jobArray[i];
            if([cell.contentTextField.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请输入%@",cell.resumeName.text]];
                return;
            }else
            {
                if(i == 0)
                {
                    _model.name = cell.contentTextField.text;
                }
                if(i == 2)
                {
                    _model.department = cell.contentTextField.text;
                }
                if(i == 3)
                {
                    _model.title = cell.contentTextField.text;
                }
            }
        }
        
    }
    if(self.contentTextField.text.length > 15)
    {
        _model.content = self.contentTextField.text;
    }else
    {
        [MBProgressHUD creatembHub:@"请输入至少15个字符"];
        return;
    }
    NSDictionary * param = @{@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"name":_model.name,@"sdate":_model.sdate,@"edate":_model.edate,@"department":_model.department,@"title":_model.title,@"content":_model.content};
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    [[WriteResumeRequest uploadWorkExperienceWithSucc:^(NSDictionary * dataDic) {
        WorkExReadingVC * workreading = [[WorkExReadingVC alloc] init];
        workreading.model = _model;
        [self.navigationController pushViewController:workreading animated:YES];
    } WithResumeParam:param] addNotifaction:hub];
}

-(void)replaceClick
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
        {
            WorkingTimeCell * cell = self.jobArray[i];
            cell.StartTime.selected = NO;
            cell.endTime.selected = NO;
            cell.todaySelect.selected = NO;
            continue;
        }
        WriteResumeCell * cell = self.jobArray[i];
        cell.contentTextField.text = @"";
    }
    [self.jobArray removeAllObjects];
    self.contentTextField.text = @"";
    self.placeHoderTextLable.hidden = NO;
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
    if(indexPath.row == 1)
    {
        WorkingTimeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkingTimeCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.controller = self;
        [self.jobArray addObject:cell];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
        {
            continue;
        }
        WriteResumeCell * cell = self.jobArray[i];
        [cell.contentTextField resignFirstResponder];
    }
    
    [self.contentTextField resignFirstResponder];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.placeHoderTextLable.hidden = YES;
    if(HEIGHT == 480)
    {
        self.scro.contentSize = CGSizeMake(WIDETH, 400+ 64 + 150);
        [self.scro scrollRectToVisible:CGRectMake(0, 450, WIDETH, HEIGHT) animated:YES];
    }else
    {
        self.scro.contentSize = CGSizeMake(WIDETH,  400+ 64 + 150);
        [self.scro scrollRectToVisible:CGRectMake(0, 450, WIDETH, HEIGHT) animated:YES];
        
    }
    
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.contentTextField  resignFirstResponder];
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
