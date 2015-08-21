//
//  TH_LoginVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_LoginVC.h"
#import "LoginView.h"
#import "TH_RegisterVC.h"
#import "TH_ForgotPasswordVC.h"
#import "AppDelegate.h"
#import "TH_HomeVC.h"
@interface TH_LoginVC ()<UITextFieldDelegate>
@property (strong,nonatomic)UIButton * loginBtn;
@property(nonatomic,strong)UITextField * phonetextField;
@property(nonatomic,strong)UITextField * passwordTextFiled;
@end

@implementation TH_LoginVC
@synthesize loginBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.view.backgroundColor = color(243, 243, 241);
    [self loginView];
    // Do any additional setup after loading the view.
}
-(void)loginView
{
    //    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0)];
    //    bgView.backgroundColor = color(243, 243, 241);
    //    [self.view addSubview:bgView];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-72, 15, 72, 90)];
    imageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:imageView];
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        imageView.frame = CGRectMake((WIDETH-72)/2.0, 10, 72,90);
    } completion:nil];
    
    UIView * loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, WIDETH, 90)];
    loginView.backgroundColor = color(255, 255, 255);
    [self.view addSubview:loginView];
    UIView * linefirstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0.5)];
    linefirstView.backgroundColor = color(221, 221, 221);
    [loginView addSubview:linefirstView];
    UIView * loginSencondView = [[UIView alloc] initWithFrame:CGRectMake(15, 45, WIDETH, 0.5)];
    loginSencondView.backgroundColor =color(221, 221, 221);
    [loginView addSubview:loginSencondView];
    
    UIView * loginThreeView = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5, WIDETH, 0.5)];
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
    [self.view addSubview:loginBtn];
    
    [UIView animateWithDuration:3 delay:0.85 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        loginBtn.frame = CGRectMake(15, 215, WIDETH - 30, 45);
        self.loginBtn.alpha = 1;
        
    } completion:nil];
    
    UILabel * registerLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 275, 70, 12)];
    registerLable.text = @"还没有账号?";
    registerLable.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:registerLable];
    UIButton * registBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 275, 60, 12)];
    [registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setTitle:@"立即注册!" forState:UIControlStateNormal];
    [registBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:registBtn];
    
    //忘记密码
    UIButton * forgetBtn =[[UIButton alloc] initWithFrame:CGRectMake(WIDETH-70, 275, 55, 12)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [forgetBtn addTarget:self action:@selector(ForgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _passwordTextFiled) {
        [self loginBtbClick];
    }
    else if (textField == _phonetextField)
    {
        [_passwordTextFiled becomeFirstResponder];
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
}
-(void)loginBtbClick
{
    NSLog(@"登录");
    self.navigationController.navigationBarHidden = YES;
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.mainTabBar = [[TH_MainTabBarController alloc] init];
    
    appDelegate.mainTabBar.modalTransitionStyle = UIModalPresentationPageSheet;
    [self presentViewController:appDelegate.mainTabBar animated:YES completion:nil];
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
