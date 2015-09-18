//
//  TH_CertificateVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_CertificateVC.h"
#import "projectTableViewCell.h"
#import "WriteRusumeModel2.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
#import "ResumeModel.h"
#import "CertificateReadVC.h"
@interface TH_CertificateVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    WriteRusumeModel2 * _model;
    ResumeModel * _resume_model;
}
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UITextView * contentTextField;
@property(strong,nonatomic)UILabel * placeHoderTextLable;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property (strong,nonatomic)NSMutableArray * jobCellArr;
@end

@implementation TH_CertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.jobCellArr = [NSMutableArray arrayWithCapacity:0];
    _model = [[WriteRusumeModel2 alloc] init];
    _resume_model = [ResumeModel sharedResume];
    [self createScro];
    [self createView];
    [self setData];
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        projectTableViewCell * cell = self.jobCellArr[i];
        
        
        if(i == 0)
        {
             cell.placehoderTextfield.text = @"";
        }
        
        if(i == 1)
        {
             cell.placehoderTextfield.text = @"";
        }
        if(i == 2)
        {
           cell.placehoderTextfield.text = @"";
        }
    }
self.contentTextField.text = @"";
   
}
-(void)setData
{
    self.nameArray = @[@"证书全称",@"颁发时间",@"颁发单位"];
    self.holderArray = @[@"请填写证书全称",@"请填写颁发时间",@"请填写颁发单位"];
}
-(void)createScro
{self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}

-(void)createView
{
    UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, 135, 13) Font:13 Text:[NSString stringWithFormat:@"%@-证书",_resume_model.resumeName]];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(160, 9.5, 53, 23) ImageName:@"lanniu2" Target:self Action:nil Title:@"可选填"];
    [stateBtn setTitleColor:color(255, 255, 255) forState:UIControlStateNormal];
    stateBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.scro addSubview:stateBtn];
    
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 42, WIDETH, 126)];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.tableView = tableview;
    tableview.scrollEnabled= NO;
    tableview.layer.borderWidth = 0.5;
    tableview.layer.borderColor = color(221, 221, 221).CGColor;
    tableview.separatorColor = color(221, 221, 221);
    [self.scro addSubview:tableview];
    
    /*请输入相关内容**/
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 188, WIDETH, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    [self.scro addSubview:bgView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 52, 21) Font:13 Text:@"证书内容"];
    [bgView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(77, 46, 1, 26)];
    line.backgroundColor = color(203, 203, 203);
    [bgView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(87, 6, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    self.contentTextField.delegate = self;
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = [UIColor blackColor];
        [bgView addSubview:self.contentTextField];
    /*显示隐藏内容**/
    UILabel * placeHoderTextLable =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, WIDETH - 121, 30)];
    placeHoderTextLable.text = @"请填写培训内容";
    placeHoderTextLable.textColor = color(203, 203, 203);
    self.placeHoderTextLable = placeHoderTextLable;
    [self.contentTextField addSubview:placeHoderTextLable];
    self.placeHoderTextLable.font = [UIFont systemFontOfSize:13];
    
    /*按钮选项**/
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 323, (WIDETH-150-18)/2.0, 30) ImageName:@"hongniu2" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),323, (WIDETH-150-18)/2.0, 30) ImageName:@"lanniu2" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.scro addSubview:replaceBtn];
    
    
}
/*保存**/
-(void)saveBtnClick
{
   
    
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        projectTableViewCell * cell = self.jobCellArr[i];
        if([cell.placehoderTextfield.text isEqualToString:@""])
        {
            [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请输入%@",cell.nameLable.text]];
            return;
        }
        
        if(i == 0)
        {
            _model.name = cell.placehoderTextfield.text;
        }
        
        if(i == 1)
        {
            _model.sdate = cell.placehoderTextfield.text;
        }
        if(i == 2)
        {
            _model.position = cell.placehoderTextfield.text;
        }
    }
    
    if(self.contentTextField.text.length < 15)
    {
        [MBProgressHUD creatembHub:@"请输入至少15个字符"];
        return;
    }else
    {
        _model.content = self.contentTextField.text;
    }
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    [[WriteResumeRequest uploadCertificateWithSucc:^(NSDictionary *dataDic) {
        [MBProgressHUD creatembHub:@"保存成功"];
//        [self.navigationController popViewControllerAnimated:YES];
        CertificateReadVC * read = [[CertificateReadVC alloc] init];
        read.model = _model;
        [self.navigationController pushViewController:read animated:YES];
    } WithResumeParam:@{@"token":tokenStr,@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"name":_model.name,@"sdate":_model.sdate,@"title":_model.position,@"content":_model.content}] addNotifaction:hub];
    
    
}
/*重置**/
-(void)replaceBtnClick
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        projectTableViewCell * cell = self.jobCellArr[i];
        cell.placehoderTextfield.text = @"";
        [_tableView reloadData];
    }
    [self.jobCellArr removeAllObjects];
    self.contentTextField.text = @"";
    self.placeHoderTextLable.hidden = NO;
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
    projectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"projectTableViewCell" owner:self options:nil] lastObject];
    }
    cell.nameLable.text = self.nameArray[indexPath.row];
    cell.placehoderTextfield.placeholder= self.holderArray[indexPath.row];
    [self.jobCellArr addObject:cell];
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        if(i == 1)
        {
            continue;
        }
        projectTableViewCell * cell = self.jobCellArr[i];
        [cell.placehoderTextfield resignFirstResponder];
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
