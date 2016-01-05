//
//  TH_TrainExperienceVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_TrainExperienceVC.h"
#import "EducationTimeCell.h"
#import "EducationWriteCell.h"
#import "WriteRusumeModel2.h"
#import "WriteResumeRequest.h"
#import "AppDelegate.h"
#import "ResumeModel.h"
#import "TrainReadVC.h"

@interface TH_TrainExperienceVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    WriteRusumeModel2 * _model;
    ResumeModel * _resume_model;
}

@property(nonatomic,strong)UITableView * tableView ;
@property (strong,nonatomic)UILabel * nameLab;
@property(nonatomic,strong)UILabel * placeHoderTextLable;
@property (strong,nonatomic)UITextView * contentTextField;
@property(nonatomic,strong)UIScrollView * scro;
@property(strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property(strong,nonatomic)NSMutableArray * jobArray;
@property (nonatomic, strong) UIView *corver;

@end

@implementation TH_TrainExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"写简历";
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.jobArray = [NSMutableArray arrayWithCapacity:0];
    _model = [[WriteRusumeModel2 alloc] init];
    _resume_model = [ResumeModel sharedResume];
    [self createScro];
    [self createView];
    [self setData];
}
-(void)viewWillAppear:(BOOL)animated
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
       if(i == 1)
        {
         EducationTimeCell * cell = self.jobArray[i];
            cell.startTime.selected = NO;
            cell.endTime.selected = NO;
            cell.todayClick.selected = NO;

        }else
        {
        EducationWriteCell * cell = self.jobArray[i];
            if(i == 0)
            {
                cell.educationContentTextFile.text = @"";
            }
            if(i == 2)
            {
                 cell.educationContentTextFile.text= @"";
            }
        }
        
        
        self.contentTextField.text  = @"";
        
        
        
    }
        
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}

-(void)setData
{
    self.nameArray = @[@"培训中心",@"",@"培训方向"];
    
    if (self.detailId)
    {
        self.holderArray = @[self.train,@"",self.trainDirection];
    }
    else
    {
        self.holderArray = @[@"请填培训中心",@"",@"请填写培训方向"];
    }

    
}
-(void)createScro
{  self.view.backgroundColor = color(243, 243, 241);
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 243);
    [self.view addSubview:scro];
}
-(void)createView
{
    
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, 0, WIDETH, 40);
    [self.scro addSubview:titleView];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.text = [NSString stringWithFormat:@"%@-培训经历",_resume_model.resumeName];
    titleLab.font = [UIFont systemFontOfSize:13];
    CGSize titleLabSize = [titleLab.text sizeWithFont:[UIFont systemFontOfSize:13]];
    titleLab.frame = CGRectMake(10, 0, titleLabSize.width, 40);
    [titleView addSubview:titleLab];
    
    UIImageView *selectedIcon = [[UIImageView alloc]init];
    selectedIcon.image = [UIImage imageNamed:@"kexuan2"];
    selectedIcon.frame = CGRectMake(CGRectGetMaxX(titleLab.frame) + 5, 7.5, 54, 25);
    [titleView addSubview:selectedIcon];

    
    UITableView * tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, WIDETH, 126)];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.tableView = tableview;
    tableview.scrollEnabled= NO;
    tableview.layer.borderWidth = 0.5;
    tableview.layer.borderColor = color(221, 221, 221).CGColor;
     tableview.separatorColor = color(221, 221, 221);
    [self.scro addSubview:tableview];
    
    //下方View
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 191, WIDETH, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 0.5;
    bgView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    [self.scro addSubview:bgView];
    
    self.nameLab = [ZCControl createLabelWithFrame:CGRectMake(15, 50, 52, 21) Font:13 Text:@"培训内容"];
    [bgView addSubview:self.nameLab];
    
    UIView * line = [ZCControl viewWithFrame:CGRectMake(77, 46, 1, 26)];
    line.backgroundColor = color(203, 203, 203);
    [bgView addSubview:line];
    
    self.contentTextField = [[UITextView alloc] initWithFrame:CGRectMake(87, 6, WIDETH - 101, 114)];
    self.contentTextField.font = [UIFont systemFontOfSize:13];
    
    self.contentTextField.textAlignment = NSTextAlignmentNatural;
    self.contentTextField.textColor = [UIColor blackColor];
       self.contentTextField.delegate = self;
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
    }
    else
    {
        placeHoderTextLable.text = @"请填写培训内容";
    }
    
    //下方按钮
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 326, 50, 30) ImageName:@"" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [self.scro addSubview:saveBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),326, 50, 30) ImageName:@"" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    [self.scro addSubview:replaceBtn];
    UIButton *deleteBtn = [[UIButton alloc]init];
    deleteBtn.frame = CGRectMake(75, CGRectGetMaxY(bgView.frame) + 20, WIDETH - 75 * 2, 30);
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setBackgroundColor:[UIColor orangeColor]];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除此培训经历" forState:UIControlStateNormal];
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
    
    UIView *bgView = [[UIView alloc]init];
    bgView.size = CGSizeMake(300, 85);
    bgView.center = corver.center;
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
        
    } withToken:tokenStr uid:[AppDelegate instance].userId eid:[AppDelegate instance].resumeId withId:self.detailId type:3];
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
                _model.name = cell.educationContentTextFile.text;
            }
            if(i == 2)
            {
                _model.position = cell.educationContentTextFile.text;
            }
        }
        
    }
    if(self.contentTextField.text.length < 15)
    {
        [MBProgressHUD creatembHub:@"请输入至少15个字"];
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
    [[WriteResumeRequest uploadTrainWithSucc:^(NSDictionary *dataDic) {
        [self.navigationController popViewControllerAnimated:YES];
    } WithResumeParam:@{@"token":tokenStr,@"uid":[AppDelegate instance].userId,@"eid":self.resumeId,@"name":_model.name,@"sdate":_model.sdate,@"edate":_model.edate,@"title":_model.position,@"content":_model.content,@"id":self.detailId}] addNotifaction:hub];
}
/*重置**/
-(void)replaceBtnClick
{
    for(int i = 0;i < self.jobArray.count;i++)
    {
        if(i == 1)
        {
            EducationTimeCell * cell = self.jobArray[i];
            cell.startTime.selected = NO;
            cell.endTime.selected = NO;
            cell.todayClick.selected = NO;
            continue;
        }
        EducationWriteCell * cell = self.jobArray[i];
        cell.educationContentTextFile.text = @"";
    }
    self.contentTextField.text = @"";
    self.placeHoderTextLable.hidden = NO;
    [self.jobArray removeAllObjects];
    [_tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        if (self.detailId)
        {
            [cell.startTime setTitle:self.sdate forState:UIControlStateNormal];
            [cell.endTime setTitle:self.edate forState:UIControlStateNormal];
            cell.startTime.titleLabel.textColor = [UIColor blackColor];
            cell.endTime.titleLabel.textColor = [UIColor blackColor];
            cell.startTime.selected = YES;
            cell.endTime.selected = YES;
        }
        [self.jobArray addObject:cell];
        cell.timeLable.text= @"培训时间";
   return cell;
    }
    else
    {
    EducationWriteCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WriteCell"];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EducationWriteCell" owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.educationTitleLable.text = self.nameArray[indexPath.row];
        if (self.detailId)
        {
            cell.educationContentTextFile.text = self.holderArray[indexPath.row];
        }
        else
        {
            cell.educationContentTextFile.placeholder = self.holderArray[indexPath.row];
        }

    
    [self.jobArray addObject:cell];
        return cell;
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.placeHoderTextLable removeFromSuperview];
    
        if(HEIGHT == 480)
        {
            self.scro.contentSize = CGSizeMake(WIDETH, 754 + 64 + 220);
            [self.scro scrollRectToVisible:CGRectMake(0, 500, WIDETH, HEIGHT) animated:YES];
        }else
        {
            self.scro.contentSize = CGSizeMake(WIDETH, 754 + 64 + 220);
            [self.scro scrollRectToVisible:CGRectMake(0, 500, WIDETH, HEIGHT) animated:YES];

        }
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
