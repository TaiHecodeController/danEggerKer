//
//  TH_ForgotPasswordVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ForgotPasswordVC.h"
#import "TH_getCodeNextVC.h"
#import "AccountRequest.h"
#import "LoginAndRegisterRequest.h"
@interface TH_ForgotPasswordVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UIButton * securityCodeBtn;
@property(nonatomic,strong)UITextField * phoneTextField;
@property(nonatomic,strong)UITextField * securiedTextField;
@property(nonatomic,assign)int count;
@property (nonatomic, strong) NSTimer *paintingTimer;

@end

@implementation TH_ForgotPasswordVC



- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"forgotpasswordvc"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color(243, 243, 241);
    self.count = 60;
    [self createScro];
    // Do any additional setup after loading the view.
}
-(void)createScro
{
    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 241);
    //手机号码
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
    phoneTextField.textColor  = [UIColor blackColor];
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.font = [UIFont systemFontOfSize:13];
    self.phoneTextField = phoneTextField;
    phoneTextField.delegate = self;
    [phoneBgView addSubview:phoneTextField];
    [self.scro addSubview:phoneBgView];
    //验证码
    UIView *securityCodeBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 70, (WIDETH - 40)/4.0*3-10, 45)];
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
    securiedTextField.keyboardType = UIKeyboardTypeNumberPad;
    securiedTextField.textColor = [UIColor blackColor];
    securiedTextField.font =[UIFont systemFontOfSize:13];
    securiedTextField.delegate = self;
    self.securiedTextField = securiedTextField;

    [securityCodeBgView addSubview:securiedTextField];
    
    [self.scro addSubview:securityCodeBgView];
    //获取验证码
    UIView * getCodeRightBgView = [[UIView alloc] initWithFrame:CGRectMake(WIDETH-((WIDETH - 40)/4.0+25), 70, (WIDETH - 40)/4.0*1+10, 45)];
    getCodeRightBgView.backgroundColor = UIColorFromRGB(0xf44336);
    getCodeRightBgView.layer.cornerRadius = 3;
    getCodeRightBgView.layer.masksToBounds = YES;
    UIButton * securityCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (WIDETH - 40)/4.0*1+10, 45)];
    [securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [securityCodeBtn setBackgroundImage:[UIImage imageNamed:@"hongniu2"] forState:UIControlStateNormal];
    
    securityCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    securityCodeBtn.titleLabel.textColor = color(255, 255, 255);
    [securityCodeBtn addTarget:self action:@selector(securityCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.securityCodeBtn = securityCodeBtn;
    
    [getCodeRightBgView addSubview:securityCodeBtn];
    [self.scro addSubview:getCodeRightBgView];
    //下一步
    UIButton * nextButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 130, WIDETH -30, 45)];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
     [nextButton setBackgroundImage:[UIImage imageNamed:@"hongniu"] forState:UIControlStateNormal];
    nextButton.titleLabel.textColor = color(255, 255, 255);
    nextButton.titleLabel.font = [UIFont systemFontOfSize:19];
    nextButton.layer.cornerRadius = 3;
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(getCodeNextClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:nextButton];
   
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField == self.phoneTextField) {
//        [self.securiedTextField becomeFirstResponder];
//    }
//    
//    [self loginRequest];
//    return YES;
//}
//-(void)loginRequest{
//    
//
//}
#pragma mark -- 获取验证码
-(void)securityCodeBtnClick:(UIButton *)sender
{
   
    if ([self.phoneTextField.text length]!=11) {
        [MBProgressHUD creatembHub:@"电话号码不合法" ControllerView:self];
        return;
    }
    
    [[LoginAndRegisterRequest forgitRequestWithPhoneNum:self.phoneTextField.text withSucc:^(NSDictionary * dic) {
         NSLog(@"获取验证码成功");
        [self.securityCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒重发",(long)self.count] forState:UIControlStateNormal];
        self.securityCodeBtn.userInteractionEnabled = NO;
        self.securityCodeBtn.alpha = 0.5;
        self.paintingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(reduceTime) userInfo:nil repeats:YES];
    [MBProgressHUD creatembHub:@"获取验证码成功" ControllerView:self];
    }] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    }

- (void)reduceTime
{
    self.count--;
    [self.securityCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)self.count] forState:UIControlStateNormal];
    if (self.count == 0)
    {
        [self.paintingTimer invalidate];
        self.count = nil;
        [self.securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
       
        self.securityCodeBtn.userInteractionEnabled = YES;
        self.count = 60;
    }
}

-(void)getCodeNextClick
{
//    [AccountRequest forgitNextRequestWithPhoneNum:self.phoneTextField.text withSecurityCode:self.securiedTextField.text withSucc:^(NSDictionary * dic) {
//        
//        if ([dic[@"code"] integerValue]==0) {
//            TH_getCodeNextVC * getNext = [[TH_getCodeNextVC alloc] init];
//            getNext.title = @"找回密码";
//            getNext.phoneNum = self.phoneTextField.text;
//            [self.navigationController pushViewController:getNext animated:YES];
//        }
//
//    }];
     THMBProgressHubView * hub = [MBProgressHUD mbHubShowMBProgressHubView:self];
    [[LoginAndRegisterRequest forgitNextRequestWithPhoneNum:self.phoneTextField.text withSecurityCode:self.securiedTextField.text withSucc:^(NSDictionary * dic) {
        if ([dic[@"code"] integerValue]==0) {
            [MBProgressHUD creatembHub:@"点击下一步重置密码" ControllerView:self];
            TH_getCodeNextVC * getNext = [[TH_getCodeNextVC alloc] init];
            getNext.title = @"找回密码";
            getNext.forgetPhoneNum = self.phoneTextField.text;
            
            [self.navigationController pushViewController:getNext animated:YES];
        }

    }] addNotifaction:hub];

    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
