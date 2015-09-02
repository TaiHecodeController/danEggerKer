//
//  WriteResumeViewController.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeViewController.h"
#import "WriteResumeCell.h"
#import "ExceptCityCell.h"
#import "NameAndSexCell.h"
#import "WriteResumeVC2.h"
#import "WriteJLChooseVC.h"
#import "ZCControl.h"
#import "ResumeModel.h"
#import "WriteResumeRequest.h"

@interface WriteResumeViewController ()<UITableViewDelegate,UITableViewDataSource,writeJLChooseVCDelegate,UITextFieldDelegate>
{
    UITableView * jobTableView;
    UITableView * userTableView;
    UIScrollView * back_sv;
    UITextField * recordTextField;
    ResumeModel * _model;
}
@property (strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;
@property (strong,nonatomic)NSMutableArray * jobCellArray;

@property (strong,nonatomic)NSArray * nameArray2;
@property (strong,nonatomic)NSArray * holderArray2;
@property (strong,nonatomic)NSMutableArray * jobCellArray2;
@property (nonatomic, strong)UIDatePicker *datePick;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *ok;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic,strong)NSDictionary * dataDic;

@end

@implementation WriteResumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [ResumeModel sharedResume];
    
    self.title = @"写简历";
    self.jobCellArray = [NSMutableArray arrayWithCapacity:0];
    self.jobCellArray2 = [NSMutableArray arrayWithCapacity:0];
    [self createData];
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [_backView removeFromSuperview];
    
    [self.datePick removeFromSuperview];
    
    [_ok removeFromSuperview];
}

-(void)loadData
{
    [WriteResumeRequest getResumeMessageListWithSucc:^(NSDictionary *DataDic) {
        self.dataDic = DataDic[@"data"];
    }];
}

-(void)createData
{
    self.nameArray = @[@"简历名称",@"从事行业",@"期望职位",@"期望薪资",@"期望城市",@"工作性质",@"到岗时间",@"求职状态"];
    self.holderArray = @[@"请填写您的简历名称",@"请选择您的从事行业",@"请选择您的期望职位",@"请选择您的期望薪资",@"",@"请选择您的工作性质",@"请选择您的到岗时间",@"请选择您的求职状态"];
    self.nameArray2 = @[@"",@"出生年月",@"最高学历",@"工作经验",@"手机号码",@"联系邮箱",@"现居住地"];
    self.holderArray2 = @[@"",@"请填写您的出生年月",@"请填写您的最高学历",@"请填写您的工作经验",@"请填写您的手机号码",@"请填写您的联系邮箱",@"请填写您的现居住地"];
    
}

-(void)createUI
{
    //最底层ScrollView
    back_sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    back_sv.contentSize = CGSizeMake(WIDETH, 754 + 64);
    back_sv.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    [self.view addSubview:back_sv];
    
    UILabel * startLab = [ZCControl createLabelWithFrame:CGRectMake(15, 10, WIDETH / 1.5, 20) Font:12 Text:@"好的简历能帮助你更快的找到好工作!"];
    [back_sv addSubview:startLab];
    
    UIButton * mustWrite = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 1.5 + 5, 9.5, 53, 23) ImageName:@"hongniu2" Target:self Action:@selector(mustClick) Title:@"必填"];
    [mustWrite setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    mustWrite.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [back_sv addSubview:mustWrite];
    
    //中间tabelview
    jobTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, WIDETH, 336)];
    jobTableView.delegate = self;
    jobTableView.dataSource = self;
    jobTableView.scrollEnabled = NO;
    jobTableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    jobTableView.layer.borderWidth = 0.5;
    jobTableView.tag = 1555;
    [back_sv addSubview:jobTableView];
    
    //下方tableView
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 399, WIDETH, 294)];
    userTableView.delegate = self;
    userTableView.dataSource = self;
    userTableView.scrollEnabled = NO;
    userTableView.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    userTableView.layer.borderWidth = 0.5;
    userTableView.tag = 1999;
    [back_sv addSubview:userTableView];
    
    //保存按钮
    UIButton * nextBtn = [ZCControl createButtonWithFrame:CGRectMake(WIDETH / 2 - 75, 709, 150, 30) ImageName:@"lanniu2" Target:self Action:@selector(nextClick) Title:@"保存"];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [back_sv addSubview:nextBtn];
    
}

-(void)nextClick
{
    NSMutableArray * modelNameArr = [self propertyKeys];
    for(int i = 0;i < self.jobCellArray.count;i++)
    {
        if(i != 4)
        {
            WriteResumeCell * cell = self.jobCellArray[i];
            
            if([cell.contentTextField.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请填写您的%@",cell.resumeName.text]];
                return;
            }else
            {
                [_model setValue:cell.userId forKey:modelNameArr[i]];
            }
        }else
        {
            ExceptCityCell * cell = self.jobCellArray[i];
            if(!cell.proviceBtn.selected)
            {
                [MBProgressHUD creatembHub:@"请填写省份"];
                return;
            }
            if (!cell.cityBtn.selected)
            {
                [MBProgressHUD creatembHub:@"请填写城市"];
                return;
            }
            if(!cell.countyBtn.selected)
            {
                [MBProgressHUD creatembHub:@"请填写县区"];
                return;
            }
            NSString * cityStr = [NSString stringWithFormat:@"%@%@",cell.proviceBtn.titleLabel.text,cell.countyBtn.titleLabel.text];
            [_model setValue:cityStr forKey:modelNameArr[i]];
        }
        
    }
    
    for(int i = 0;i < self.jobCellArray2.count;i++)
    {
        if(i == 0)
        {
            NameAndSexCell * cell = self.jobCellArray2[i];
            if([cell.contentTextField.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:@"请填写您的姓名"];
                return;
            }else
            {
                
                [_model setValue:cell.contentTextField.text forKey:modelNameArr[i + 8]];
                //性别
                if(cell.womenBtn.selected)
                {
                    [_model setValue:@"女" forKey:modelNameArr[i + 9]];
                }else
                {
                    [_model setValue:@"男" forKey:modelNameArr[i + 9]];
                }
                
            }
        }else
        {
            WriteResumeCell * cell = self.jobCellArray2[i];
            if([cell.contentTextField.text isEqualToString:@""])
            {
                [MBProgressHUD creatembHub:[NSString stringWithFormat:@"请填写您的%@",cell.resumeName.text]];
                return;
            }else
            {
                if(i == 4)
                {
                    if(![Utils checkTel:cell.contentTextField.text])
                    {
                        [MBProgressHUD creatembHub:@"请输入正确的手机号"];
                        return;
                    }
                }
                
                if(i == 5)
                {
                    if(![Utils validateEmail:cell.contentTextField.text])
                    {
                        [MBProgressHUD creatembHub:@"邮箱格式不正确"];
                        return;
                    }
                }
                
                if(i == 1||i == 2||i == 3)
                {
                    [_model setValue:cell.userId forKey:modelNameArr[i + 9]];
                }else
                {
                    [_model setValue:cell.contentTextField.text forKey:modelNameArr[i + 9]];
                }

                
            }
        }
        
    }
    NSDictionary * param = @{@"uid":@"uid",@"name":_model.resumeName,@"hy":_model.industry,@"job_classid":_model.exceptJob,@"salary":_model.exceptSalary,@"provinceid":_model.exceptCity,@"type":_model.jobNature,@"report":_model.arriveTime,@"jobstatus":_model.findState,@"uname":_model.userName,@"birthday":_model.userBirthday,@"edu":_model.academic,@"exp":_model.workExperience,@"telphone":_model.phoneNum,@"email":_model.email,@"address":_model.address};
    
    
    WriteResumeVC2 * wrvc2 = [[WriteResumeVC2 alloc] init];
    [self.navigationController pushViewController:wrvc2 animated:YES];
}

//反射
-(NSMutableArray *)propertyKeys
{
    unsigned int outCount,i;
    objc_property_t * properties = class_copyPropertyList([ResumeModel class], &outCount);
    NSMutableArray * keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for(i = 0;i < outCount;i++)
    {
        objc_property_t propery = properties[i];
        NSString * properyName = [[NSString alloc] initWithCString:property_getName(propery) encoding:NSUTF8StringEncoding];
        [keys addObject:properyName];
    }
    free(properties);
    return keys;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1555)
    {
        return 8;
    }
    return 7;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1555)
    {
        
        if(indexPath.row != 4)
        {
            WriteResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            if(!cell)
            {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell" owner:self options:nil] firstObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentTextField.delegate = self;
                if (indexPath.row != 0)
                {
                    cell.contentTextField.enabled = NO;
                }
            }
            cell.resumeName.text = self.nameArray[indexPath.row];
            cell.contentTextField.placeholder = self.holderArray[indexPath.row];
            cell.showMessageBtn.tag = 100 + indexPath.row;
            if(indexPath.row == 0)
            {
                cell.showMessageBtn.hidden = YES;
            }
            [self.jobCellArray addObject:cell];
            return cell;
            
        }else
        {
            ExceptCityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CityCell"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ExceptCityCell" owner:self options:nil] firstObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            cell.Controller = self;
            [self.jobCellArray addObject:cell];
            return cell;
        }
        
    }else
    {
        if(indexPath.row == 0)
        {
            NameAndSexCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"NameAndSexCell" owner:self options:nil] firstObject];
                //                cell.contentTextField.enabled = NO;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentTextField.delegate = self;
            }
            [self.jobCellArray2 addObject:cell];
            return cell;
        }else
        {
            WriteResumeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
            if(!cell)
            {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"WriteResumeCell" owner:self options:nil] firstObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.contentTextField.delegate = self;
            }
            if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 4)
            {
                if(indexPath.row == 4)
                {
                    cell.contentTextField.keyboardType = UIKeyboardTypeNumberPad;
                }
                if(indexPath.row == 5)
                {
                    cell.contentTextField.keyboardType = UIKeyboardTypeEmailAddress;
                }
                
                cell.showMessageBtn.hidden = YES;
                cell.contentTextField.tag = 600 + indexPath.row;
                
                if (indexPath.row != 4) {
                    cell.contentTextField.enabled = YES;
                }
            }
            else
            {
                cell.contentTextField.enabled = NO;
            }
            cell.resumeName.text = self.nameArray2[indexPath.row];
            cell.contentTextField.placeholder = self.holderArray2[indexPath.row];
            [self.jobCellArray2 addObject:cell];
            return cell;
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

//点击事件，在此写跳转页面，注意判断tableview的tag
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    WriteJLChooseVC *vc = [[WriteJLChooseVC alloc]init];
    
    if (tableView.tag == 1555)
    {
        THLog(@"工作选项列表");
        if (indexPath.row == 1)
        {
            THLog(@"从事行业");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"从事行业";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
             _writeJLChooseVC.DataArray = self.dataDic[@"hy"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            
        }
        else if (indexPath.row == 2)
        {
            THLog(@"期望职位");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"期望职位";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.dataDic[@"hy"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
            
        }
        else if (indexPath.row == 3)
        {
            THLog(@"期望薪资");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"期望薪资";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.dataDic[@"pay"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        else if (indexPath.row == 5)
        {
            THLog(@"工作性质");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"工作性质";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.dataDic[@"type"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        else if (indexPath.row == 6)
        {
            THLog(@"到岗时间");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"到岗时间";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.dataDic[@"dgtime"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        else if (indexPath.row == 7)
        {
            THLog(@"求职状态");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"求职状态";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1555;
            _writeJLChooseVC.DataArray = self.dataDic[@"jobstatus"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        else
        {
            return;
        }
        
    }
    else
    {
        THLog(@"个人信息选项列表");
        if (indexPath.row == 1)
        {
            THLog(@"出生年月");
            [self createDataPickView];
            
            
            
            return;
            
        }
        else if (indexPath.row == 2)
        {
            THLog(@"最高学历");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"最高学历";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1999;
            _writeJLChooseVC.DataArray = self.dataDic[@"education"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
            THLog(@"工作经验");
            WriteJLChooseVC * _writeJLChooseVC = [[WriteJLChooseVC alloc] init];
            _writeJLChooseVC.delegete = self;
            _writeJLChooseVC.titleText = @"最高学历";
            _writeJLChooseVC.cellIndex = indexPath;
            _writeJLChooseVC.tableViewTagIndex = 1999;
            _writeJLChooseVC.DataArray = self.dataDic[@"experience"];
            [self.navigationController pushViewController:_writeJLChooseVC animated:YES];
        }
        //        else if (indexPath.row == 4)
        //        {
        //            THLog(@"手机号码");
        //        }
        else
        {
            return;
        }
        
        
    }
    
}

//- (void)createDatePicker
//{
////    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, HEIGHT - 200, WIDETH, 200)];
////    datePicker.datePickerMode = UIDatePickerModeDate;
////    [self.view addSubview:datePicker];
////    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
////    _datePick = datePicker;
//}

#pragma mark -- creatDatePickView
-(void)createDataPickView
{
    _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.3;
    [self.navigationController.view addSubview:_backView];
    //创建picker
    self.datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    self.datePick.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self
     .navigationController.view addSubview:self.datePick];
    [self.datePick addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置显示为中文
    self.datePick.locale = locale;
    self.datePick.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    NSDate * minDate = [dateFormatt dateFromString:@"1910-1-1"];
    
    //设置属性
    self.datePick.maximumDate = localDate;
    self.datePick.minimumDate = minDate;
    
    _ok = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(okClick) Title:@"确定"];
    self.datePick.userInteractionEnabled = YES;
    [_ok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:_ok];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.datePick.frame = CGRectMake(0, HEIGHT / 2 + 80 + 40, WIDETH, HEIGHT / 2 - 80);
        _ok.frame = CGRectMake(WIDETH - 40, HEIGHT - 80, 40, 30);
        [back_sv scrollRectToVisible:CGRectMake(0, 500, WIDETH, HEIGHT) animated:YES];
    
    } completion:^(BOOL finished) {
        
    }];
}

-(void)okClick
{
    [_backView removeFromSuperview];
    
    [self.datePick removeFromSuperview];
    
    [_ok removeFromSuperview];
    
    NSIndexPath *cellIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    WriteResumeCell *cell = (WriteResumeCell *)[userTableView cellForRowAtIndexPath:cellIndex];
    if(_dateString == nil)
    {
        NSDate * localDate = [NSDate date];
        //设置时间
        NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
        [dateFormatt setDateFormat:@"yyyy-MM-dd"];
        _dateString = [dateFormatt stringFromDate:localDate];
    }
    
    cell.contentTextField.text = _dateString;
    
    [back_sv scrollRectToVisible:CGRectMake(0, 220, WIDETH, HEIGHT) animated:YES];

}

-(void)dataChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    _dateString = [dateFormatt stringFromDate:sender.date];
}


//-(void)dateChanged:(id)sender
//{
//    UIDatePicker *control = (UIDatePicker*)sender;
//    NSDate* mydate = control.date;
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"yyyy年MM月"];
//    NSString *timeStr = [dateFormatter stringFromDate:mydate];
//    //    NSLog(@"mydate%@",mydate);
//    NSIndexPath *cellIndex = [NSIndexPath indexPathForRow:1 inSection:0];
//    WriteResumeCell *cell = (WriteResumeCell *)[userTableView cellForRowAtIndexPath:cellIndex];
//    cell.contentTextField.text = timeStr;
//}

-(void)mustClick
{
    
}

- (void)chooseWord:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id
{
    if (tableViewTagIndex == 1555)
    {
        WriteResumeCell *cell = (WriteResumeCell *)[jobTableView cellForRowAtIndexPath:cellIndex];
        cell.contentTextField.text = keyWord;
        cell.userId = Id;
    }
    else
    {
        WriteResumeCell *cell = (WriteResumeCell *)[userTableView cellForRowAtIndexPath:cellIndex];
        cell.contentTextField.text = keyWord;
        cell.userId = Id;
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_datePick)
    {
        [_datePick resignFirstResponder];
        [_datePick removeFromSuperview];
        _datePick = nil;
    }
    [recordTextField resignFirstResponder];
    //    [((WriteResumeCell *)[jobTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).contentTextField resignFirstResponder];
    //
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag >= 600)
    {
        if(HEIGHT == 480)
        {
            back_sv.contentSize = CGSizeMake(WIDETH, 754 + 64 + 220);
            [back_sv scrollRectToVisible:CGRectMake(0, 500, WIDETH, HEIGHT) animated:YES];
        }else
        {
            back_sv.contentSize = CGSizeMake(WIDETH, 754 + 64 + 240);
            [back_sv scrollRectToVisible:CGRectMake(0, 500, WIDETH, HEIGHT) animated:YES];
        }
        
    }
    recordTextField = textField;
    NSLog(@"%ld",(long)textField.tag);
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag >= 600)
    {
        if(HEIGHT == 480)
        {
            back_sv.contentSize = CGSizeMake(WIDETH / 2, 754 + 64);
            [back_sv scrollRectToVisible:CGRectMake(0, 220, WIDETH, HEIGHT) animated:YES];
        }
        else
        {
            back_sv.contentSize = CGSizeMake(WIDETH / 2, 754 + 64);
            [back_sv scrollRectToVisible:CGRectMake(0, 200, WIDETH, HEIGHT) animated:YES];
        }
        
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
