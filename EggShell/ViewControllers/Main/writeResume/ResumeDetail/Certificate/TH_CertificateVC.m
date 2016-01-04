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
#import "CertifiCateTime.h"
@interface TH_CertificateVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    WriteRusumeModel2 * _model;
    ResumeModel * _resume_model;
    NSString * dateStr;
    UIButton * record_btn;
    UIView * backView;
    UIButton * ok;
    
}
@property (strong,nonatomic)UIDatePicker * dataPicker;
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UITextView * contentTextField;
@property(strong,nonatomic)UILabel * placeHoderTextLable;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property (strong,nonatomic)NSMutableArray * jobCellArr;
@property (nonatomic, strong) UIView *corver;

@end

@implementation TH_CertificateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
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
    
//    for(int i = 0;i < self.jobCellArr.count;i++)
//    {
//        projectTableViewCell * cell = self.jobCellArr[i];
//        
//        
//        if(i == 0)
//        {
//             cell.placehoderTextfield.text = @"";
//        }
//        
//        if(i == 1)
//        {
//            CertifiCateTime * cell = self.jobCellArr[i];
//            
//            cell.selectTime.selected = NO;
//        }
//        if(i == 2)
//        {
//           cell.placehoderTextfield.text = @"";
//        }
//    }
//self.contentTextField.text = @"";
   
}
-(void)setData
{
    self.nameArray = @[@"证书全称",@"颁发时间",@"颁发单位"];
    
    if (self.detailId)
    {
        self.holderArray = @[self.cerName,@"",self.awardCompany];
    }
    else
    {
         self.holderArray = @[@"请填写证书全称",@"",@"请填写颁发单位"];
    }

}
-(void)createScro
{
    self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}

-(void)createView
{
    UILabel * nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 15, WIDETH, 13) Font:13 Text:[NSString stringWithFormat:@"%@-证书",_resume_model.resumeName]];
    [self.scro addSubview:nameLab];
    
    UIButton * stateBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 10 - 53, 9.5, 53, 23) ImageName:@"lanniu2" Target:self Action:nil Title:@"可选填"];
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
       placeHoderTextLable.textColor = color(203, 203, 203);
    self.placeHoderTextLable = placeHoderTextLable;
    [self.contentTextField addSubview:placeHoderTextLable];
    self.placeHoderTextLable.font = [UIFont systemFontOfSize:13];
    if (self.detailId)
    {
        self.contentTextField.text = self.content;
        self.placeHoderTextLable.hidden = YES;
    }
    else
    {
        placeHoderTextLable.text = @"请填写证书内容";
    }
    /*按钮选项**/
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 323, 50, 30) ImageName:@"" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [self.scro addSubview:saveBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),323, 50, 30) ImageName:@"" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    [self.scro addSubview:replaceBtn];
    UIButton *deleteBtn = [[UIButton alloc]init];
    deleteBtn.frame = CGRectMake(75, CGRectGetMaxY(bgView.frame) + 20, WIDETH - 75 * 2, 30);
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setBackgroundColor:[UIColor orangeColor]];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除此证书" forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    deleteBtn.layer.cornerRadius = 5;
    if (_pushtype == 0)
    {
        
    }
    else
    {
        [self.scro addSubview:deleteBtn];
    }
}

- (void)deleteClick:(UIButton *)btn
{
    [self presentDeleteView:nil];
}

- (void)presentDeleteView:(NSInteger)index
{
    UIView *corver = [[UIView alloc]init];
    corver.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    corver.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:corver];
    self.corver = corver;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((WIDETH - 300) / 2, 100, 300, 85)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    [corver addSubview:bgView];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((300 - 150) / 2, 15, 150, 15)];
    titleLab.text = @"你确定要删除吗？";
    titleLab.textColor = [UIColor orangeColor];
    [bgView addSubview:titleLab];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(22.5, 40, 112.5, 30)];
    cancelBtn.backgroundColor = [UIColor orangeColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.layer.cornerRadius =5;
    [bgView addSubview:cancelBtn];
    
    UIButton *OkBtn = [[UIButton alloc] initWithFrame:CGRectMake(165, 40, 112.5, 30)];
    [OkBtn setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [OkBtn setTitle:@"确认" forState:UIControlStateNormal];
    OkBtn.layer.cornerRadius = 5;
    [OkBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    OkBtn.tag = index;
    [bgView addSubview:OkBtn];
    
}

- (void)cancelClick:(UIButton *)btn
{
    [self.corver removeFromSuperview];
}

- (void)okClick:(UIButton *)btn
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    [WriteResumeRequest deleteResumeItemWithSucc:^(NSDictionary *dataDic) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } withToken:tokenStr uid:[AppDelegate instance].userId eid:[AppDelegate instance].resumeId withId:self.detailId type:6];
    
}


/*保存**/
-(void)saveBtnClick
{
   
    
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        if(i == 1)
        {
            
            CertifiCateTime * cell = self.jobCellArr[i];
            if (!cell.selectTime.selected) {
                [MBProgressHUD creatembHub:@"请选择时间"];
                return;
            }
            _model.sdate = cell.selectTime.titleLabel.text;
            
            
        }else
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
        
        
        if(i == 2)
        {
            _model.position = cell.placehoderTextfield.text;
        }
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
    THMBProgressHubView * hub = [MBProgressHUD mbHubShowMBProgressHubView:self];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    if (self.detailId)
    {
        
    }
    else
    {
        self.detailId = @"";
    }
    [[WriteResumeRequest uploadCertificateWithSucc:^(NSDictionary *dataDic) {
        [self.navigationController popViewControllerAnimated:YES];
    } WithResumeParam:@{@"token":tokenStr,@"uid":[AppDelegate instance].userId,@"eid":self.resumeId,@"name":_model.name,@"sdate":_model.sdate,@"title":_model.position,@"content":_model.content,@"id":self.detailId}] addNotifaction:hub];
    
    
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
    
    if (indexPath.row==1) {
        
        CertifiCateTime * cell =[tableView dequeueReusableCellWithIdentifier:@"timeid"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CertifiCateTime" owner:self options:nil] firstObject];
        }
        if (self.detailId)
        {
            [cell.selectTime setTitle:self.awardTime forState:UIControlStateNormal];
            cell.selectTime.selected = YES;
            cell.selectTime.titleLabel.textColor =[UIColor blackColor];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.jobCellArr addObject:cell];
        return cell;
    }
    projectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"projectTableViewCell" owner:self options:nil] lastObject];
    }
    cell.nameLable.text = self.nameArray[indexPath.row];
    if (self.detailId)
    {
        cell.placehoderTextfield.text = self.holderArray[indexPath.row];
    }
    else
    {
        cell.placehoderTextfield.placeholder = self.holderArray[indexPath.row];
    }
//    cell.placehoderTextfield.placeholder= self.holderArray[indexPath.row];
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


@end
