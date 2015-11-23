//
//  TH_LoginVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//  登录

#import "TH_LoginVC.h"
#import "LoginView.h"
#import "TH_RegisterVC.h"
#import "TH_ForgotPasswordVC.h"
#import "AppDelegate.h"
#import "TH_HomeVC.h"
#import "AccountRequest.h"
#import "LoginAndRegisterRequest.h"
#import "TH_MineVC.h"
#import "TH_JobWishlistVC.h"
#import "TH_FindJobVC.h"
#import "EnterpriseFoegetVC.h"
@interface TH_LoginVC ()<UITextFieldDelegate>
@property (strong,nonatomic)UIButton * loginBtn;
@property(nonatomic,strong)UITextField * phonetextField;
@property(nonatomic,strong)UITextField * passwordTextFiled;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)NSString * phoneNum;
@end

@implementation TH_LoginVC
@synthesize loginBtn;
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults * userId = [NSUserDefaults standardUserDefaults];
   self.phonetextField.text = [userId objectForKey:@"loginPhone"];
    [MobClick beginLogPageView:@"loginvc"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"loginvc"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = color(243, 243, 241);
    [self createScro];
    [self loginView];
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
//    /*显示键盘**/
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
//    
//    //    /*收回键盘**/
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
//
    
    
    // Do any additional setup after loading the view.
}

-(void)createScro
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    
}
-(void)loginView
{
   
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-72, 15, 80, 90)];
    imageView.image = [UIImage imageNamed:@"logo"];
    [self.scro addSubview:imageView];
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        imageView.frame = CGRectMake((WIDETH-80)/2.0, 10, 80,90);
    } completion:nil];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    UIView * loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, WIDETH, 90)];
    loginView.backgroundColor = color(255, 255, 255);
    [self.scro addSubview:loginView];
    UIView * linefirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0.5)];
    linefirstView.backgroundColor = color(221, 221, 221);
    [loginView addSubview:linefirstView];
    UIView * loginSencondView = [[UIView alloc] initWithFrame:CGRectMake(15, 45, WIDETH, 0.5)];
    loginSencondView.backgroundColor =color(221, 221, 221);
    [loginView addSubview:loginSencondView];
    
    UIView * loginThreeView = [[UIView alloc] initWithFrame:CGRectMake(0, 89.6, WIDETH, 0.4)];
    loginThreeView.backgroundColor = color(221, 221, 221);
    [loginView addSubview:loginThreeView];
    
    
    UILabel * phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(-45, 16, 45, 15)];
    phoneLable.text = @"手机号";
    phoneLable.textColor = [UIColor blackColor];
    phoneLable.font = [UIFont systemFontOfSize:15];
    [loginView addSubview:phoneLable];
    
    [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        phoneLable.frame = CGRectMake(15, 16, 45, 15);
        
    } completion:nil];
    
    UILabel * passwordLable = [[UILabel alloc] initWithFrame:CGRectMake(-55, 16+45, 40, 15)];
    passwordLable.text = @"密码";
    passwordLable.font = [UIFont systemFontOfSize:15];
    [loginView addSubview:passwordLable];
    
    [UIView animateWithDuration:1 delay:0.65 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        passwordLable.frame = CGRectMake(15, 16+45, 40, 15);
    } completion:nil];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * userName = [user objectForKey:@"username"];
    NSString * userPassword = [user objectForKey:@"userPassword"];
    UITextField * phonetextField = [[UITextField alloc] initWithFrame:CGRectMake(-WIDETH - 80, 0, WIDETH - 80, 45)];
    phonetextField.placeholder = @"请输入手机号码";
    phonetextField.keyboardType = UIKeyboardTypeNumberPad;
    phonetextField.delegate = self;
    phonetextField.returnKeyType = UIReturnKeyNext;
    phonetextField.textColor = color(200, 200, 200);
    phonetextField.textColor = UIColorFromRGB(0x000000);
    phonetextField.font = [UIFont systemFontOfSize:13];
    self.phonetextField = phonetextField;
    [loginView addSubview:phonetextField];
    [UIView animateWithDuration:1 delay:0.6 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        phonetextField.frame = CGRectMake(80, 0, WIDETH - 80, 45);
    } completion:nil];
    
    UITextField * passwordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(-WIDETH - 80, 45, WIDETH - 80, 45)];
    passwordTextFiled.placeholder =  @"请输入密码";
    passwordTextFiled.font =[UIFont systemFontOfSize:13];
    passwordTextFiled.textColor = color(200, 200, 200);
    passwordTextFiled.returnKeyType = UIReturnKeyGo;
    passwordTextFiled.delegate = self;
    passwordTextFiled.secureTextEntry = YES;
    passwordTextFiled.textColor = UIColorFromRGB(0x000000);
    [loginView addSubview:passwordTextFiled];
    self.passwordTextFiled = passwordTextFiled;
    [UIView animateWithDuration:1 delay:0.75 usingSpringWithDamping:1 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        passwordTextFiled.frame = CGRectMake(80, 45, WIDETH - 80, 45);
    } completion:nil];
    
    /*手机号密码逻辑处理**/
    if (userName == nil) {
        _phonetextField.placeholder = @"请输入账号";
    }
    else
    {
        _phonetextField.text = userName;
        
    }
    if (userPassword == nil) {
        _passwordTextFiled.placeholder = @"请输入密码";
    }
    else
    {
        
        _passwordTextFiled.text = userPassword;
    }
    //登录
    loginBtn =[[UIButton alloc] initWithFrame:CGRectMake(15,215 + 30, WIDETH - 30, 45)];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"hongniu"] forState:UIControlStateNormal];
    loginBtn.titleLabel.textColor = color(255, 255, 255);
    [loginBtn addTarget:self action:@selector(loginBtbClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.alpha = 0;
    [self.scro addSubview:loginBtn];
    
    [UIView animateWithDuration:3 delay:0.85 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        loginBtn.frame = CGRectMake(15, 215, WIDETH - 30, 45);
        self.loginBtn.alpha = 1;
        
    } completion:nil];
    
    UILabel * registerLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 275, 70, 12)];
    registerLable.text = @"还没有账号?";
    registerLable.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:registerLable];
    UIButton * registBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 275, 60, 12)];
    [registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setTitle:@"立即注册!" forState:UIControlStateNormal];
    [registBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:registBtn];
    
    //忘记密码
    UIButton * forgetBtn =[[UIButton alloc] initWithFrame:CGRectMake(WIDETH-70, 275, 55, 12)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [forgetBtn addTarget:self action:@selector(ForgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:forgetBtn];
    self.scro.contentSize = CGSizeMake(WIDETH, HEIGHT+10);
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
   
    if (textField == _phonetextField)
    {
        [_passwordTextFiled becomeFirstResponder];
    }else if (textField == _passwordTextFiled) {
        [self loginRequest];
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
}

#pragma mark-- 登录
-(void)loginBtbClick
{NSLog(@"登录");

      [[NSNotificationCenter defaultCenter] postNotificationName:@"loginNotice" object:self];
    if ([self.phonetextField.text length]==0) {
        [MBProgressHUD creatembHub:@"电话号码为空"];
        return;
    }else if([self.passwordTextFiled.text length]==0)
    {
        [MBProgressHUD creatembHub:@"密码不能够为空"];
        return;
    }
    [self loginRequest];
}
-(void)loginRequest
{
    MBProgressHUD * hub = [MBProgressHUD mbHubShow];
    [[LoginAndRegisterRequest loginRequestWithusername:self.phonetextField.text WithPassword:self.passwordTextFiled.text  withSucc:^(NSDictionary * dic) {
        if ([dic[@"code"] integerValue]==0) {
            [MBProgressHUD creatembHub:dic[@"message"]];
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:dic[@"data"] forKey:@"uidAndToken"];
            [user setObject:dic[@"data"][@"telphone"] forKey:@"loginPhone"];
            [user setObject:dic[@"data"][@"uid"] forKey:@"uid"];
            NSString * uid = dic[@"data"][@"uid"];
            NSString * token = dic[@"data"][@"token"];
            NSString * tokenSerit = [NSString stringWithFormat:@"%@%@",token,uid];
            NSString* mymd5_token  = [MyMD5 md5:tokenSerit];
            [user setObject:mymd5_token forKey:@"md5_token"];
            
            
            [user synchronize];
            
            if ([self.jobWilstRegist isEqualToString:@"jobWilstRegist"]) {
             [self.navigationController popViewControllerAnimated:YES];
                
            }else if ([self.findJobApplications isEqualToString:@"findJobApplications"]) {
                self.loginBlock();
                  [self.navigationController popViewControllerAnimated:YES];
            }else if ([self.findJobDetailApplication isEqualToString:@"findJobDetailApplication"])
            {
                self.loginBlock();
                [self.navigationController popViewControllerAnimated:YES];
            }else
              {
            self.navigationController.navigationBarHidden = YES;
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.mainTabBar = [[TH_MainTabBarController alloc] init];
            appDelegate.mainTabBar.modalTransitionStyle = UIModalPresentationPageSheet;
//           appDelegate.userId = dic[@"data"][@"uid"];
            [self presentViewController:appDelegate.mainTabBar animated:YES completion:nil];
            }
        }
    } ] addNotifaction:hub];
}
-(void)ForgotPasswordClick
{
    TH_ForgotPasswordVC * forgot = [[TH_ForgotPasswordVC alloc] init];
    forgot.title = @"找回密码";
    [self.navigationController pushViewController:forgot animated:YES];
}
-(void)registClick
{
    TH_RegisterVC * regist = [[TH_RegisterVC alloc] init];
    regist.title = @"注册";
    [self.navigationController pushViewController:regist animated:YES];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
//开始编辑，向上滚动
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag >= 400)
    {
        if(HEIGHT == 480)
        {
            self.scro.contentSize = CGSizeMake(WIDETH, 400+ 64 + 150);
            [self.scro scrollRectToVisible:CGRectMake(0, 450, WIDETH, HEIGHT) animated:YES];
        }else
        {
            self.scro.contentSize = CGSizeMake(WIDETH, 400+ 64 + 150);
            [self.scro scrollRectToVisible:CGRectMake(0, 450, WIDETH, HEIGHT) animated:YES];
        }
        
    }
   }
//结束编辑，恢复原位
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.tag >= 400)
    {
        if(HEIGHT == 480)
        {
            self.scro.contentSize = CGSizeMake(WIDETH / 2, 400+ 64 + 150);
            [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
        }else
        {
            self.scro.contentSize = CGSizeMake(WIDETH / 2, 400+ 64 + 150);
            [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
