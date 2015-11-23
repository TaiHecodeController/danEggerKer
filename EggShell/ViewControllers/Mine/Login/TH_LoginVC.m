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


@property(nonatomic,strong)UITextField * passwordTextFiled;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)NSString * phoneNum;

@property (nonatomic, strong) UIButton *personBtn;
@property (nonatomic, strong) UIButton *companyBtn;


@property (nonatomic, strong) UILabel *phoneLable;
@property(nonatomic,strong)UITextField * phonetextField;

//切换用户时，需要隐藏的视图
@property (nonatomic, strong) UILabel *registerLable;
@property (nonatomic, strong) UIButton *registBtn;
@property (nonatomic, strong) UILabel *wwwLab;

//判断个人或是企业 0 个人 1 企业
@property (nonatomic) int personOrCompany;

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
    
    UILabel *pingtaiLab = [[UILabel alloc]init];
    pingtaiLab.text = @"一个具有圈子的就业规划平台";
    pingtaiLab.font = [UIFont systemFontOfSize:13];
    pingtaiLab.textColor = color(102, 102, 102);
    CGSize pingtaiSize = [pingtaiLab.text sizeWithFont:pingtaiLab.font];
    pingtaiLab.frame = CGRectMake((WIDETH - pingtaiSize.width) / 2, CGRectGetMaxY(imageView.frame) + 10, pingtaiSize.width, pingtaiSize.height);
    [self.view addSubview:pingtaiLab];
    
    
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
//    NSArray *arr = @[@"个人用户",@"企业用户"];
//    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:arr];
//    
//    seg.layer.borderColor = [color(102, 102, 102) CGColor];
//    [self.view addSubview:seg];
//    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
//    _seg = seg;
    
//    _seg = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"个人用户", @"企业用户"]  IconNames:nil delegate:self] ;
////    _seg.frame = CGRectMake(0, CGRectGetMaxY(pingtaiLab.frame) + 20, WIDETH - 2 * 52, 45);
//    [self.view addSubview:_seg];

    UIButton *personBtn = [[UIButton alloc]init];
    [personBtn setTitle:@"个人用户" forState:UIControlStateNormal];
    [personBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [personBtn setBackgroundColor:[UIColor whiteColor]];
    personBtn.layer.borderColor = [UIColorFromRGB(0xDDDDDD) CGColor];
    personBtn.frame = CGRectMake(53, CGRectGetMaxY(pingtaiLab.frame) + 20, (WIDETH - 2 * 53) / 2, 45) ;
    personBtn.layer.borderWidth = 1;
    [personBtn addTarget:self action:@selector(personClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:personBtn];
    _personBtn = personBtn;
    
    UIButton *companyBtn = [[UIButton alloc]init];
    [companyBtn setTitle:@"企业用户" forState:UIControlStateNormal];
    [companyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [companyBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
     companyBtn.layer.borderColor = [UIColorFromRGB(0xDDDDDD) CGColor];
    companyBtn.layer.borderWidth = 1;
    companyBtn.frame = CGRectMake(CGRectGetMaxX(personBtn.frame), CGRectGetMaxY(pingtaiLab.frame) + 20, (WIDETH - 2 * 53) / 2, 45);
     [companyBtn addTarget:self action:@selector(companyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:companyBtn];
    _companyBtn = companyBtn;
    
    UIView * loginView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(personBtn.frame) + 15, WIDETH, 90)];
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
    _phoneLable = phoneLable;
    
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
    loginBtn =[[UIButton alloc] initWithFrame:CGRectMake(15,CGRectGetMaxY(loginView.frame) + 15, WIDETH - 30, 45)];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"hongniu"] forState:UIControlStateNormal];
    loginBtn.titleLabel.textColor = color(255, 255, 255);
    [loginBtn addTarget:self action:@selector(loginBtbClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.alpha = 0;
    [self.scro addSubview:loginBtn];
    
    [UIView animateWithDuration:3 delay:0.85 usingSpringWithDamping:0.1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        loginBtn.frame = CGRectMake(15, CGRectGetMaxY(loginView.frame) + 15, WIDETH - 30, 45);
        self.loginBtn.alpha = 1;
        
    } completion:nil];
    
    UILabel * registerLable = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(loginBtn.frame) + 15, 70, 12)];
    registerLable.text = @"还没有账号?";
    registerLable.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:registerLable];
    _registerLable = registerLable;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"访问eggker.cn注册企业账号"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 10)];
    _wwwLab = [[UILabel alloc]init];
    _wwwLab.frame = CGRectMake(15, CGRectGetMaxY(loginBtn.frame) + 15, 200, 12);
    _wwwLab.attributedText = str;
    _wwwLab.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:_wwwLab];
    _wwwLab.hidden = YES;
    _wwwLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wwwClick)];
    [_wwwLab addGestureRecognizer:tap];
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(loginBtn.frame) + 15, 60, 12)];
    [registBtn addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    [registBtn setTitle:@"立即注册!" forState:UIControlStateNormal];
    [registBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:registBtn];
    _registBtn = registBtn;
    
    //忘记密码
    UIButton * forgetBtn =[[UIButton alloc] initWithFrame:CGRectMake(WIDETH-70, CGRectGetMaxY(loginBtn.frame) + 15, 55, 12)];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:color(244, 67, 54) forState:UIControlStateNormal];
    forgetBtn.titleLabel.font =[UIFont systemFontOfSize:12];
    [forgetBtn addTarget:self action:@selector(ForgotPasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:forgetBtn];
    self.scro.contentSize = CGSizeMake(WIDETH, HEIGHT+10);
    
    
    
}

- (void)personClick
{
    self.personOrCompany = 0;
    
    [_personBtn setBackgroundColor:[UIColor whiteColor]];
    [_personBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_companyBtn setBackgroundColor:[UIColor clearColor]];
    [_companyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _phoneLable.text = @"手机号";
    _phonetextField.placeholder = @"请输入用手机号";
    
    _registerLable.hidden = NO;
    _registBtn.hidden = NO;
    _wwwLab.hidden = YES;
}

- (void)companyClick
{
    self.personOrCompany = 1;
    
    [_companyBtn setBackgroundColor:[UIColor whiteColor]];
    [_companyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_personBtn setBackgroundColor:[UIColor clearColor]];
    [_personBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //用户名 请输入用户名
    _phoneLable.text = @"用户名";
    _phonetextField.placeholder = @"请输入用户名";
    
    _registerLable.hidden = YES;
    _registBtn.hidden = YES;
    _wwwLab.hidden = NO;

}

- (void)wwwClick
{
    NSURL *url = [NSURL URLWithString:@"http://www.eggker.cn/"];
    [[UIApplication sharedApplication] openURL:url];
    
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
{
    NSLog(@"登录");

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
    if (self.personOrCompany == 0)
    {
        NSLog(@"个人登录");
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
    else
    {
        NSLog(@"企业登录");
        
    }
    
    
}
-(void)ForgotPasswordClick
{
    
    if (self.personOrCompany == 0)
    {
        TH_ForgotPasswordVC * forgot = [[TH_ForgotPasswordVC alloc] init];
        forgot.title = @"找回密码";
        [self.navigationController pushViewController:forgot animated:YES];
    }
    else
    {
        EnterpriseFoegetVC * enterpriseFoeget = [[EnterpriseFoegetVC alloc] init];
        [self.navigationController pushViewController:enterpriseFoeget animated:YES];
    }
   
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
