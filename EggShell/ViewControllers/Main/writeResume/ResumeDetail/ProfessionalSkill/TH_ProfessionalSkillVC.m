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
    self.holderArray = @[@"请填技能名称",@"请填写技能类别",@"请选择熟练程度",@"请填写掌握时间"];
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
//    [self.scro addSubview:saveBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    UIButton * replaceBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH-((WIDETH-150-18)/2.0+75),225, (WIDETH-150-18)/2.0, 30) ImageName:@"lanniu2" Target:self Action:@selector(replaceBtnClick) Title:@"重置"];
    
    [replaceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    replaceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
//    [self.scro addSubview:replaceBtn];
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
    [[WriteResumeRequest uploadProfessionalSkillWithSucc:^(NSDictionary *dataDic) {
        [MBProgressHUD creatembHub:@"保存成功"];
//        [self.navigationController popViewControllerAnimated:YES];
        
        ProfessonSkillVC * professon = [[ProfessonSkillVC alloc] init];
        professon.model = _model;
        
        
        [self.navigationController pushViewController:professon animated:YES];
    } WithResumeParam:@{@"token":tokenStr,@"uid":[AppDelegate instance].userId,@"eid":[AppDelegate instance].resumeId,@"name":_model.name,@"skill":_model.skillType,@"ing":_model.skillDegree,@"longtime":_model.skillTime}] addNotifaction:hub];
    
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
        
    }
    if (indexPath.row== 3) {
        cell.profisionTextField.delegate = self;
    }
    
    cell.profesionNameLable.text = self.nameArray[indexPath.row];
    cell.profisionTextField.placeholder= self.holderArray[indexPath.row];
    cell.logoImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    [self.jobCellArr addObject:cell];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
