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
#import "WriteJLChooseVC.h"
#import "ProfessonSkillVC.h"
@interface TH_ProfessionalSkillVC ()<UITableViewDelegate,UITableViewDataSource,writeJLChooseVCDelegate,UITextFieldDelegate>
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
@property (nonatomic, strong) UIView *corver;

@end

@implementation TH_ProfessionalSkillVC
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeClick:) name:@"removeMessage" object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{ [super viewWillDisappear:NO];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"removeMessage" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专业技能";
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
-(void)removeClick:(NSNotification*)notion
{
   
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        ProfessionalCell * cell = self.jobCellArr[i];
        
        if(i == 0)
        {
            cell.profisionTextField.text = @"";
        }
        
        if(i == 1)
        {

            cell.profisionTextField.text = @"";
        }
        if(i == 2)
        {

            cell.profisionTextField.text = @"";
        }
        if(i == 3)
        {
             cell.profisionTextField.text = @"";
        }
        

    
    }
}
-(void)setData
{
    self.nameArray = @[@"技能名称",@"技能类别",@"熟练程度",@"掌握时间"];
    if (self.detailId)
    {
        self.holderArray = @[self.skillName,self.skillType,self.skillDegree,self.time];
    }
    else
    {
        
   self.holderArray = @[@"请填技能名称",@"请填写技能类别",@"请选择熟练程度",@"请填写掌握时间"];
        
    }

    self.imageArray  = @[@"",@"xiala-拷贝",@"xiala-拷贝",@""];
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
    UIButton * saveBtn = [ZCControl createButtonWithFrame:CGRectMake(75, 225, 50, 30) ImageName:@"" Target:self Action:@selector(saveBtnClick) Title:@"保存"];
    
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
//    [self.scro addSubview:saveBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),225, 50, 30) ImageName:@"" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    [self.scro addSubview:replaceBtn];
    UIButton *deleteBtn = [[UIButton alloc]init];
    deleteBtn.frame = CGRectMake(75, CGRectGetMaxY(tableview.frame) + 20, WIDETH - 75 * 2, 30);
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setBackgroundColor:[UIColor orangeColor]];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除此专业技能" forState:UIControlStateNormal];
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
        
    } withToken:tokenStr uid:[AppDelegate instance].userId eid:[AppDelegate instance].resumeId withId:self.detailId type:4];
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
            _model.skillType = cell.cellId;
        }
        if(i == 2)
        {
            _model.skillDegree = cell.cellId;
        }
        if(i == 3)
        {
            
            NSCharacterSet *cs;
            cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
            NSString *filtered = [[cell.profisionTextField.text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            BOOL basicTest = [cell.profisionTextField.text isEqualToString:filtered];
            if(!basicTest)
            {
                [MBProgressHUD creatembHub:@"掌握时间必须为数字"];
                
                return ;
                
            }else
            {
            _model.skillTime = cell.profisionTextField.text;
            }
            
        }
        
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
    THLog(@"%@ %@ %@ %@ %@",_model.name,_model.skillType,_model.skillDegree,_model.skillTime,self.detailId);
    [[WriteResumeRequest uploadProfessionalSkillWithSucc:^(NSDictionary *dataDic) {
        [self.navigationController popViewControllerAnimated:YES];
    } WithResumeParam:@{@"token":tokenStr,@"uid":[AppDelegate instance].userId,@"eid":self.resumId,@"name":_model.name,@"skill":_model.skillType,@"ing":_model.skillDegree,@"longtime":_model.skillTime,@"id":self.detailId}] addNotifaction:hub];
    
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 1 || indexPath.row == 2)
    {
        cell.profisionTextField.enabled = NO;
        if (self.detailId)
        {
            if (indexPath.row == 1)
            {
//                if ([self.skillType isEqualToString:@"外语"])
//                {
//                    cell.cellId = @"26";
//                }
//                else if ([self.skillType isEqualToString:@"计算机"])
//                {
//                    cell.cellId = @"27";
//                }
//                else if ([self.skillType isEqualToString:@"其他"])
//                {
//                     cell.cellId = @"28";
//                }
                cell.cellId = self.skillId;
                THLog(@"skillId%@",self.skillId);
                
            }
            if (indexPath.row == 2)
            {
//                if ([self.skillType isEqualToString:@"一般"])
//                {
//                    cell.cellId = @"40";
//                }
//                else if ([self.skillType isEqualToString:@"良好"])
//                {
//                    cell.cellId = @"41";
//                }
//                else if ([self.skillType isEqualToString:@"熟练"])
//                {
//                    cell.cellId = @"42";
//                }
//                else if ([self.skillType isEqualToString:@"精通"])
//                {
//                    cell.cellId = @"43";
//                }
                cell.cellId = self.ingId;
                THLog(@"ingId%@",self.ingId);
            }
        }
        
    }
    if (indexPath.row== 3) {
        cell.profisionTextField.delegate = self;
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = @"单位:年";
        lab.font = [UIFont systemFontOfSize:11];
        lab.textAlignment = NSTextAlignmentRight;
        lab.frame = CGRectMake(WIDETH - 10, 10, 50, 20);
        [cell addSubview:lab];
    }
    
    cell.profesionNameLable.text = self.nameArray[indexPath.row];
    if (self.detailId)
    {
        cell.profisionTextField.text = self.holderArray[indexPath.row];
    }
    else
    {
        cell.profisionTextField.placeholder = self.holderArray[indexPath.row];
    }
    cell.logoImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    [self.jobCellArr addObject:cell];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    THLog(@"%@",self.dataDic);
    if(indexPath.row == 1)
    {
        WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
        _writeJLChooseVC.delegete = self;
        _writeJLChooseVC.titleText = @"技能类别";
        _writeJLChooseVC.cellIndex = indexPath;
        _writeJLChooseVC.tableViewTagIndex = 1555;
        _writeJLChooseVC.DataArray = self.dataDic[@"skill"];
        [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
    }
    
    if(indexPath.row == 2)
    {
        WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
        _writeJLChooseVC.delegete = self;
        _writeJLChooseVC.titleText = @"熟练程度";
        _writeJLChooseVC.cellIndex = indexPath;
        _writeJLChooseVC.tableViewTagIndex = 1555;
        _writeJLChooseVC.DataArray = self.dataDic[@"ing"];
        [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
    }
}

- (void)chooseWord:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
{
    
        ProfessionalCell *cell = self.jobCellArr[cellIndex.row];
        cell.profisionTextField.text = keyWord;
        cell.cellId = Id;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for(int i = 0;i < self.jobCellArr.count;i++)
    {
        ProfessionalCell * cell = self.jobCellArr[i];
        [cell.profisionTextField resignFirstResponder];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        [MBProgressHUD creatembHub:@"请输入数字"];
        
        return NO;
    }
    
    return YES;
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
