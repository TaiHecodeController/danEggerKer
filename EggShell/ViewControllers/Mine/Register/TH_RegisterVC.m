//
//  TH_RegisterVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_RegisterVC.h"
#import "LoginAndRegisterRequest.h"
#import "TH_LoginVC.h"
#import "AccountRequest.h"
@interface TH_RegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UIButton * securityCodeBtn;
@property(nonatomic,strong)UITextField * phoneTextField;
@property(nonatomic,strong)UITextField * passwordTextField;
@property(nonatomic,strong)UITextField * securiedTextField;
@property(nonatomic,assign)int count;
@property (nonatomic, strong) NSTimer *paintingTimer;
@property(nonatomic,strong)NSMutableDictionary * registDic;
@end

@implementation TH_RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
       self.count = 60;
    self.view.backgroundColor = color(243, 243, 241);
    [self createScro];
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /*显示键盘**/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    
    //    /*收回键盘**/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    }
#pragma mark -- 创建UI
-(void)createScro{
    UIScrollView * scro= [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro.backgroundColor = color(243, 241, 241);
    self.scro = scro;
    
    UIView  * phoneBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, WIDETH - 30, 45)];
    phoneBgView.backgroundColor = color(255, 255, 255);
    phoneBgView.layer.borderWidth = 0.5;
    phoneBgView.layer.borderColor = color(221, 221, 221).CGColor;
    phoneBgView.layer.cornerRadius = 3;
    phoneBgView.layer.masksToBounds = YES;
   UILabel * phoneLalbe = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 45,15)];
    phoneLalbe.text = @"手机号";
    phoneLalbe.font = [UIFont systemFontOfSize:15];
    [phoneBgView addSubview:phoneLalbe];
    
    
    UIView * phoneLineView = [[UIView alloc] initWithFrame:CGRectMake(70, 14, 1, 16)];
    phoneLineView.backgroundColor = color(221, 221, 221);
    [phoneBgView addSubview:phoneLineView];
    
    
    UITextField * phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, WIDETH - 30-80, 45)];
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.textColor = color(200, 200, 200);
    phoneTextField.font = [UIFont systemFontOfSize:13];
    phoneTextField.textColor =[UIColor blackColor];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.returnKeyType = UIReturnKeyNext;
    phoneTextField.delegate = self;
    [phoneBgView addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;

    [self.scro addSubview:phoneBgView];
    //密码
    UIView * passwordBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 70, WIDETH- 30, 45)];
    passwordBgView.backgroundColor = color(255, 255, 255);
    passwordBgView.layer.borderWidth = 0.5;
    passwordBgView.layer.borderColor = color(221, 221, 221).CGColor;
    passwordBgView.layer.cornerRadius = 3;
    passwordBgView.layer.masksToBounds = YES;
    UILabel * passeordLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 45, 15)];
    passeordLable.text = @"密码";
    passeordLable.font = [UIFont systemFontOfSize:15];
    [passwordBgView addSubview:passeordLable];
    
    UIView * passwordLineView = [[UIView alloc] initWithFrame:CGRectMake(70, 14, 1, 16)];
    passwordLineView.backgroundColor = color(221, 221, 221);
    [passwordBgView addSubview:passwordLineView];
    
    UITextField * passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, WIDETH-30-80, 45)];
    passwordTextField.placeholder  = @"请输入密码";
    passwordTextField.textColor = color(200, 200, 200);
    passwordTextField.font = [UIFont systemFontOfSize:13];
    passwordTextField.secureTextEntry = YES;
    passwordTextField.delegate = self;
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passwordTextField  = passwordTextField;
    [passwordBgView addSubview:passwordTextField];
    
    [self.scro addSubview:passwordBgView];
    
    /*验证码**/
    UIView *securityCodeBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 125, (WIDETH - 40)/4.0*3-10, 45)];
    securityCodeBgView.backgroundColor = color(255, 255, 255);
    securityCodeBgView.layer.borderColor = color(221, 221, 221).CGColor;
    securityCodeBgView.layer.borderWidth = 0.5;
    securityCodeBgView.layer.cornerRadius = 3;
    securityCodeBgView.layer.masksToBounds = YES;
    
    UILabel * securityLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 45, 15)];
    securityLable.text = @"验证码";
    securityLable.font = [UIFont systemFontOfSize:15];
    [securityCodeBgView addSubview:securityLable];
    UIView * securityLineView = [[UIView alloc] initWithFrame:CGRectMake(70, 14, 1, 16)];
    securityLineView.backgroundColor = color(221, 221, 221);
    [securityCodeBgView addSubview:securityLineView];
    
    UITextField * securiedTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 0, WIDETH- 30 - 80-10, 45)];
    securiedTextField.placeholder = @"请输入验证码";
    securiedTextField.font =[UIFont systemFontOfSize:13];
    securiedTextField.textColor  = color(200, 200, 200);
    securiedTextField.textColor = [UIColor blackColor];
    securiedTextField.delegate = self;
   securiedTextField.keyboardType = UIKeyboardTypeNumberPad;
    securiedTextField.returnKeyType  = UIReturnKeyGo;
    self.securiedTextField = securiedTextField;
    [securityCodeBgView addSubview:securiedTextField];
    
    [self.scro addSubview:securityCodeBgView];
    
    UIView * securityCodeRightBgView = [[UIView alloc] initWithFrame:CGRectMake(WIDETH-((WIDETH - 40)/4.0+25), 125, (WIDETH - 40)/4.0*1+10, 45)];
    securityCodeRightBgView.backgroundColor = UIColorFromRGB(0xf44336);
    securityCodeRightBgView.layer.cornerRadius = 3;
    securityCodeRightBgView.layer.masksToBounds = YES;
    UIButton * securityCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (WIDETH - 40)/4.0*1+10, 45)];
     [securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
   
    [securityCodeBtn setBackgroundImage:[UIImage imageNamed:@"hongniu"] forState:UIControlStateNormal];

    securityCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    securityCodeBtn.titleLabel.textColor = color(255, 255, 255);
    [securityCodeBtn addTarget:self action:@selector(securityCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.securityCodeBtn = securityCodeBtn;
 
    [securityCodeRightBgView addSubview:securityCodeBtn];
    [self.scro addSubview:securityCodeRightBgView];
    
    UIButton * registerBtn =[[UIButton alloc] initWithFrame:CGRectMake(15, 185, WIDETH - 30, 45)];
    [registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"lane"] forState:UIControlStateNormal];
    registerBtn.titleLabel.textColor = color(255, 255, 255);
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    registerBtn.layer.cornerRadius = 3;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:registerBtn];
    self.scro.contentSize = CGSizeMake(WIDETH, HEIGHT);
}
#pragma mark -- 获取验证码
-(void)securityCodeBtnClick:(UIButton *)sender
{
    [LoginAndRegisterRequest registerWithSucc:^(NSDictionary *DataDic) {
        
        NSLog(@"获取验证码");
    } Withphonenumber:self.phoneTextField.text WithPassword:self.passwordTextField.text withSecurityCode:@""];
    [self.securityCodeBtn setTitle:[NSString stringWithFormat:@"%ld'后重发",(long)self.count] forState:UIControlStateNormal];
    self.securityCodeBtn.userInteractionEnabled = NO;
    self.securityCodeBtn.alpha = 0.5;
    self.paintingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
    
}
#pragma mark - 注册
-(void)registerClick
{
    if ([self.phoneTextField.text length]==0) {
        [MBProgressHUD creatembHub:@"电话号码为空"];
        return;
    }else if([self.passwordTextField.text length]==0)
    {
        [MBProgressHUD creatembHub:@"密码不能够为空"];
        return;
    }else if ([self.securiedTextField.text length]==0)
    {
        [MBProgressHUD creatembHub:@"验证码不能为空"];
        return;
    }
    [self loginRequest];
    

    
//
//    [AccountRequest RegisterRequestWithUserName:self.phoneTextField.text PassWord:self.passwordTextField.text withAccountName:self.securiedTextField.text succ:^(NSDictionary * dic) {
//        if ([dic[@"code"] integerValue]==0) {
//            
//            NSUserDefaults * userId =[NSUserDefaults standardUserDefaults];
//            [userId setObject:@"ligin" forKey:@"UserName"];
//                  [MBProgressHUD creatembHub:dic[@"message"]];
//                   [self.navigationController popViewControllerAnimated:YES];
////            NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
////            [userInfo setValue:self.phoneTextField.text forKey:@"phoneText"];
////            [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSuccesNotification" object:self userInfo:userInfo];
// 
//        }
//        
//    }];
    
    }
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self.securiedTextField becomeFirstResponder];
    }
    [self loginRequest];
    return YES;
}
-(void)loginRequest
{
    self.registDic =[NSMutableDictionary dictionaryWithCapacity:0];
    
    if ([self.phoneTextField.text length]!=0&&[self.securiedTextField.text length]!=0&&[self.passwordTextField.text length]!=0) {
        [LoginAndRegisterRequest registerWithSucc:^(NSDictionary *DataDic) {
            [self.registDic setDictionary:DataDic];
            NSLog(@"%@",DataDic);
            NSString * num = [NSString stringWithFormat:@"%d",0];
            if ([self.registDic[@"code"] isEqualToString:num]) {
                NSLog(@"%@",self.registDic);
                [MBProgressHUD creatembHub:self.registDic[@"message"]];
                NSUserDefaults * userId =[NSUserDefaults standardUserDefaults];
                [userId setObject:self.registDic[@"data"][@"telphone"] forKey:@"moblie"];
                [userId synchronize];
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                [userInfo setValue:self.phoneTextField.text forKey:@"phoneText"];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"registerSuccesNotification" object:self userInfo:userInfo];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } Withphonenumber:self.phoneTextField.text WithPassword:self.passwordTextField.text withSecurityCodee:self.securiedTextField.text];
        
        
        
    }

}
- (void)reduceTime
{
    self.count--;
    [self.securityCodeBtn setTitle:[NSString stringWithFormat:@"%ld'后重发",(long)self.count] forState:UIControlStateNormal];
    if (self.count == 0)
    {
        [self.paintingTimer invalidate];
        self.count = nil;
        [self.securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.securityCodeBtn.alpha = 1;
        self.securityCodeBtn.userInteractionEnabled = YES;
        self.count = 60;
    }
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}

-(void)showKeyBoard:(NSNotification*)notification
{
    
    /*获取键盘的高度**/
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    self.scro.contentSize = CGSizeMake(WIDETH, 450+height);
    [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT+40) animated:YES];
    
    
    
    
}
-(void)hideKeyBoard:(NSNotification*)notification
{
    self.scro.contentSize = CGSizeMake(WIDETH, 450);
    [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
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
