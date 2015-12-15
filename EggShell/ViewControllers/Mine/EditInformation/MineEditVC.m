//
//  MineEditVC.m
//  EggShell
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MineEditVC.h"
#import "EditAddressVC.h"
#import "MineEditInfoCell.h"
#import "AFAppRequest.h"
#import "LoginAndRegisterRequest.h"

@interface MineEditVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIScrollView * backView;
    UITextField * recordTextField;
    //是否是编辑资料
    BOOL isEdit;
}
@property (strong,nonatomic)NSArray * nameArray;
@property (strong,nonatomic)NSArray * holderArray;

@property (strong,nonatomic)NSArray * nameArray2;
@property (strong,nonatomic)NSArray * holderArray2;
@property (strong,nonatomic)NSMutableArray * jobCellArray2;

@property (strong,nonatomic)NSArray * nameArray3;
@property (strong,nonatomic)NSArray * holderArray3;
@property (strong,nonatomic)NSMutableArray * jobCellArray3;
@property(strong,nonatomic)UITableView * tableView1;
@property(strong,nonatomic)UITableView * tableView2;
@property(strong,nonatomic)UITableView * tableView3;
@property(copy,nonatomic)NSString * NicknameCell;
@property(assign,nonatomic)NSString * SexCell;
@property(nonatomic,assign)NSInteger * jobtag;
@property(nonatomic,strong)NSDictionary * dic;
@end

@implementation MineEditVC
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"mineeditvc"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"mineeditvc"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑资料";
    self.dic = [NSDictionary dictionary];
    self.jobCellArray = [NSMutableArray arrayWithCapacity:0];
    self.birthdayCellArray = [NSMutableArray arrayWithCapacity:0];
    self.jobCellArray3 = [NSMutableArray arrayWithCapacity:0];
    [self addNotifacation];
    
    [self createUI];
    [self createNav];
    [self createData];
    [self loadData];
    /*加载保存到网络的数据**/
    if (self.isEdit) {
        [self loadData];
    }
}

-(void)addNotifacation
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHide) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyBoardHide
{
    backView.contentSize = CGSizeMake(WIDETH / 2, HEIGHT + 60);
    [backView scrollRectToVisible:[UIScreen mainScreen].bounds animated:YES];
}
#pragma mark -- 加载网络数据
-(void )loadData{
    
    NSUserDefaults * uid =[NSUserDefaults standardUserDefaults];
    NSString  * token  =  [uid objectForKey:@"md5_token"];
    NSString * uisStr = [uid objectForKey:@"uid"];
    NSDictionary * dic = @{@"uid":uisStr,@"token":token};
    [LoginAndRegisterRequest EditInformationWithSucc:^(NSDictionary * succ) {
        self.dic = succ[@"data"];
      
        if(self.tableView1.tag == 1222)
        {
            
            for (int i =0; i < self.jobCellArray.count; i++) {
                MineEditInfoCell * cell = self.jobCellArray[i];
                switch (i) {
                    case 0:
                    {
                        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
                        if  ([userDefault objectForKey:@"uid"] ) {
                            cell.contentTextField.text = [userDefault objectForKey:@"loginPhone"];
                            //                        cell.contentTextField.text = self.dic[@"telphone"];
                        }
                        break;
                        
                        
                    }
                    case 1:
                    {
                        cell.contentTextField.text = self.dic[@"name"];
                        break;
                    }
                    case 2:
                    {
                        if ([self.dic[@"sex"] isEqualToString:[NSString stringWithFormat:@"%d",7]]) {
                            cell.contentTextField.text = @"女";
                        }else
                        {
                            cell.contentTextField.text = @"男";
                        }
                        break;
                        
                    }
                    case 3:
                    {
                        cell.contentTextField.text = self.dic[@"address"];
                        break;
                    }
                    case 4:
                    {
                        
                        cell.contentTextField.text = self.dic[@"description"];
                        break;
                    }
                    default:
                        break;
                }
                
            }
        }
        if (self.tableView2.tag == 1223)
        {
            for (int i=0; i < self.birthdayCellArray.count; i++) {
                MineEditInfoCell * cell1 = self.birthdayCellArray[i];
                switch (i) {
                    case 0:
                    {
                        cell1.contentTextField.text = self.dic[@"birthday"];
                        break;
                   
                    
                    }
                    case 1:
                    {
                        
                    cell1.contentTextField.text = self.dic[@"email"];
                        break;
                    }
                    default:
                        break;
                }
            }
            
        }
          if (self.tableView3.tag == 1224) {
            for (int i = 0; i < self.jobCellArray3.count; i++) {
                MineEditInfoCell * cell = self.jobCellArray3[i];
           cell.contentTextField.text = self.dic[@"reg_date"];
            }
        }
        
    } withuid:dic];
}
#pragma mark -- 加载本地数据
-(void)createData
{
    self.nameArray = @[@"登陆账号",@"昵称",@"性别",@"所在地",@"简介"];
    self.holderArray = @[@"18800006666",@"",@"男",@"北京",@"学习是一种信仰"];
    
    self.nameArray2 = @[@"生日",@"邮箱",];
    self.holderArray2 = @[@"2015-7-10",@""];
    
    self.nameArray3 = @[@"注册时间"];
    self.holderArray3 = @[@"2015-8-2"];
    
}

-(void)createUI
{
    backView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.contentSize = CGSizeMake(WIDETH / 2, HEIGHT + 60);
    backView.backgroundColor = [UIColor colorWithRed:243 / 255.0 green:243 / 255.0 blue:241 / 255.0 alpha:1];
    //    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    backView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:backView];
    
    //上方tableView
    UITableView * tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 210)];
    tableView1.tag = 1222;
    tableView1.scrollEnabled = NO;
    tableView1.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView1.layer.borderWidth = 0.5;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    self.tableView1 = tableView1;
    [backView addSubview:tableView1];
    
    //中间tableView
    UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 230, WIDETH, 126-42)];
    tableView2.tag = 1223;
    tableView2.scrollEnabled = NO;
    tableView2.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView2.layer.borderWidth = 0.5;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    self.tableView2 = tableView2;
    [backView addSubview:tableView2];
    
    //底部tableView
    UITableView * tableView3 = [[UITableView alloc] initWithFrame:CGRectMake(0, 376-42, WIDETH, 84-42)];
    tableView3.tag = 1224;
    tableView3.scrollEnabled = NO;
    tableView3.layer.borderColor = [UIColor colorWithRed:221 / 255.0 green:221 / 255.0 blue:221 / 255.0 alpha:1].CGColor;
    tableView3.layer.borderWidth = 0.5;
    tableView3.delegate = self;
    tableView3.dataSource = self;
    self.tableView3 = tableView3;
    [backView addSubview:tableView3];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [recordTextField resignFirstResponder];
}
-(void)createNav
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 1222)
    {
        return 5;
    }
    if(tableView.tag == 1223)
    {
        return 2;
    }
    return 1;
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 1222)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.delegate = self;
            cell.contentTextField.userInteractionEnabled = YES;
            cell.contentBtn.hidden = YES;
            cell.keyBordHideBlock = ^
            {
                [recordTextField resignFirstResponder];
            };
        }
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.Controller = self;
        if(indexPath.row == 0)
        {
            cell.contentTextField.enabled = NO;
            
            //            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            //            if  ([userDefault objectForKey:@"uid"] ) {
            //                cell.contentTextField.text = [userDefault objectForKey:@"loginPhone"];
            //             cell.contentTextField.text = self.dic[@"telphone"];
            //            }
        }
        //        if (indexPath.row==1) {
        //            if (self.dic[@"name"])
        //            {
        //                cell.contentTextField.text = self.dic[@"name"];
        //            }
        //
        //        }
        if(indexPath.row == 2)
        {
            cell.showAllBtn.hidden = NO;
            cell.contentBtn.tag = 200 + 2;
            cell.contentTextField.enabled = NO;
            cell.contentBtn.hidden = NO;
            //            if ([self.dic[@"sex"] isEqualToString:[NSString stringWithFormat:@"%d",7]]) {
            //                cell.contentTextField.text = @"女";
            //            }else
            //            {
            //                cell.contentTextField.text = @"男";
            //            }
        }
        if(indexPath.row == 3)
        {
            //            cell.nextBtn.hidden = NO;
            //            cell.contentBtn.hidden = NO;
            //          cell.contentBtn.tag = 200 + 5;
            //            cell.contentTextField.enabled = YES;
            //            cell.contentTextField.text = self.dic[@"address"];
        }
        if(indexPath.row == 4)
        {
            cell.moreLab.hidden = NO;
            isEdit = YES;
            cell.contentTextField.delegate = self;
            //            cell.contentTextField.text = self.dic[@"description"];
            
        }
        cell.nameLab.text = self.nameArray[indexPath.row];
        cell.contentTextField.placeholder = self.holderArray[indexPath.row];
        [self.jobCellArray addObject:cell];
        return cell;
    }
    
    if(tableView.tag == 1223)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.delegate = self;
            cell.contentTextField.tag = 400 + indexPath.row;
            cell.contentBtn.hidden = YES;
            cell.keyBordHideBlock = ^
            {
                [recordTextField resignFirstResponder];
            };
        }
        cell.Controller = self;
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.nameLab.text = self.nameArray2[indexPath.row];
        cell.contentTextField.placeholder = self.holderArray2[indexPath.row];
        if(indexPath.row == 0)
        {
            cell.showAllBtn.hidden = NO;
            cell.contentBtn.tag = 200;
            cell.contentTextField.enabled = NO;
            cell.contentBtn.hidden = NO;
            //            cell.contentTextField.text = self.dic[@"reg_date"];
        }
        //        if (indexPath.row==1) {
        //            cell.contentTextField.text = self.dic[@"email"];
        //        }
        [self.birthdayCellArray addObject:cell];
        cell.contentTextField.placeholder = self.holderArray2[indexPath.row];
        return cell;
        
    }
    if(tableView.tag == 1224)
    {
        MineEditInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID3"];
        if(!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MineEditInfoCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentTextField.enabled = NO;
            cell.contentBtn.hidden = YES;
        }
        cell.Controller = self;
        cell.nextBtn.hidden = YES;
        cell.showAllBtn.hidden = YES;
        cell.moreLab.hidden = YES;
        cell.nameLab.text = self.nameArray3[indexPath.row];
        cell.contentTextField.text = self.holderArray3[indexPath.row];
        [self.jobCellArray3 addObject:cell];
        //        if (indexPath.row==0) {
        //            //            cell.contentTextField.text = self.dic[@"reg_date"];
        //        }
//        if (indexPath.row==1) {
//            cell.contentTextField.text = self.dic[@"reg_date"];
//        }
        return cell;
    }
    
    
    return nil;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if(tableView.tag == 1222)
////    {
////        if (indexPath.row ==1) {
////             MineEditInfoCell * cell = self.jobCellArray[indexPath.row];
////            self.NicknameCell = cell.contentTextField.text ;
////            NSLog(@"%@",self.NicknameCell);
////
////        }
////
////    }
//
//}
//开始编辑，向上滚动
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag >= 400)
    {
        if(HEIGHT == 480)
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 280);
            [backView scrollRectToVisible:CGRectMake(0, 280, WIDETH, HEIGHT) animated:YES];
        }else
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 210);
            [backView scrollRectToVisible:CGRectMake(0, 210, WIDETH, HEIGHT) animated:YES];
        }
        
    }
    recordTextField = textField;
}
//结束编辑，恢复原位
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag >= 400)
    {
        if(HEIGHT == 480)
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 60);
            [backView scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
        }else
        {
            backView.contentSize = CGSizeMake(WIDETH, HEIGHT + 60);
            [backView scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
        }
        
    }
}
////限定输入字数
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (range.location>=15)
//    {
//        [MBProgressHUD creatembHub:@"简介不能超过15字"];
//        return  NO;
//    }
//    else
//    {
//        return YES;
//    }
//
//}
#pragma mark - - 完成提交
-(void)rightClick:(UIButton *)sender
{
    
   //    NSArray * keyArray = [ NSArray arrayWithObjects:@"telphone",@"name",@"sex",@"address",@"description", nil];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * uisStr = [user objectForKey:@"uid"];
    NSString  * token  =  [user objectForKey:@"md5_token"];
    
    if (!self.isEdit)
    {
        if(self.tableView1.tag == 1222)
        {
            
            for (int i = 0; i < self.jobCellArray.count; i ++) {
                
                self.telphone = ((MineEditInfoCell*)self.jobCellArray[0]).contentTextField.text;
                if([((MineEditInfoCell*)self.jobCellArray[1]).contentTextField.text length]>16)
                {
                    [MBProgressHUD creatembHub:@"昵称不能超过16字" ControllerView:self];
                    return;
                }
                {
                
                self.name = ((MineEditInfoCell*)self.jobCellArray[1]).contentTextField.text;
                }
                
                
                if ([((MineEditInfoCell*)self.jobCellArray[2]).contentTextField.text isEqualToString:@"男"]) {
                    self.sex = 6;
                    
                    
                }if ([((MineEditInfoCell*)self.jobCellArray[2]).contentTextField.text isEqualToString:@"女"]) {
                    
                    self.sex = 7;
                }
                
        
                self.address = ((MineEditInfoCell*)self.jobCellArray[3]).contentTextField.text;
                if ([((MineEditInfoCell*)self.jobCellArray[4]).contentTextField.text length]>15) {
                    [MBProgressHUD creatembHub:@"简介不能超过15字" ControllerView:self];
                    return;
                }else
                {
                
                self.descriptions = [NSString stringWithFormat:@"%@",((MineEditInfoCell*)self.jobCellArray[4]).contentTextField.text];

                }
            }
            
        }
        if (self.tableView2.tag == 1223)
        {
            for (int i = 0; i < self.birthdayCellArray.count; i ++)
            {
                self.birthday = ((MineEditInfoCell*)self.birthdayCellArray[0]).contentTextField.text;
                if (![self isValidateEmail:((MineEditInfoCell*)self.birthdayCellArray[1]).contentTextField.text]) {
                    [MBProgressHUD creatembHub:@"请输入正确的邮箱" ControllerView:self];
                    return;
                }else
                {
                self.email =   ((MineEditInfoCell*)self.birthdayCellArray[1]).contentTextField.text;
                }
            }
            
            NSNumber *sexNum = [NSNumber numberWithInt:self.sex];
            NSDictionary * param = @{@"token":token ,@"uid":uisStr,@"telphone":self.telphone,@"name":self.name,@"sex":sexNum,@"address":self.address,@"description":self.descriptions,@"birthday":self.birthday,@"email":self.email};
            [LoginAndRegisterRequest EditInformationWithSucc:^(NSDictionary * dic) {
                
                [MBProgressHUD creatembHub:@"编辑资料成功" ControllerView:self];
//                [self.navigationController popToRootViewControllerAnimated:YES];
                
            } withParam:param];
            
        }
    }
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
