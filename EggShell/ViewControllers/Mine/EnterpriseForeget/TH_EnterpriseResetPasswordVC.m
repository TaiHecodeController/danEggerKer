//
//  TH_EnterpriseResetPasswordVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_EnterpriseResetPasswordVC.h"
#import "LoginAndRegisterRequest.h"
#import "TH_MainTabBarController.h"
#import "AppDelegate.h"
#import "AccountRequest.h"
#import "TH_LoginVC.h"
@interface TH_EnterpriseResetPasswordVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITextField  * confirmPasswordTextField;
@property(nonatomic,strong)UITextField * newsPasswordTextFied;

@end

@implementation TH_EnterpriseResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color(243, 243, 243);
    [self createScro];
    [self createView]
    ;
    }
-(void)createView
{
    UIView * newPassworBgView= [[UIView alloc] initWithFrame:CGRectMake(15, 15, WIDETH - 30, 45)];
    newPassworBgView.backgroundColor = color(255, 255, 255);
    newPassworBgView.layer.borderWidth = 0.5;
    newPassworBgView.layer.borderColor = color(221, 221, 221).CGColor;
    newPassworBgView.layer.cornerRadius = 3;
    newPassworBgView.layer.masksToBounds = YES;
    [self.scro addSubview: newPassworBgView];
    UILabel * newPasswordLalbe = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 45, 15)];
    newPasswordLalbe.text = @"新密码";
    newPasswordLalbe.font = [UIFont systemFontOfSize:15];
    [newPassworBgView addSubview:newPasswordLalbe];
    UIView * newPasswordLineView =[[UIView alloc] initWithFrame:CGRectMake(85, 14, 1, 15)];
    newPasswordLineView.backgroundColor = color(221, 221, 221);
    [newPassworBgView addSubview:newPasswordLineView];
    
    UITextField * newPasswordTextFied = [[UITextField alloc] initWithFrame:CGRectMake(95, 0, WIDETH - 95, 45)];
    newPasswordTextFied.placeholder = @"请输入新密码";
    newPasswordTextFied.secureTextEntry = YES;
    newPasswordTextFied.textColor = [UIColor blackColor];
    newPasswordTextFied.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    newPasswordTextFied.font = [UIFont systemFontOfSize:13];
    newPasswordTextFied.delegate = self;
    self.newsPasswordTextFied = newPasswordTextFied;
    [newPassworBgView addSubview:newPasswordTextFied];
    
    //确认密码
    UIView * confirmPassWordBgView = [[UIView alloc] initWithFrame:CGRectMake(15, 70, WIDETH - 30, 45)];
    confirmPassWordBgView.backgroundColor = color(255, 255, 255);
    confirmPassWordBgView.layer.borderWidth = 0.5;
    confirmPassWordBgView.layer.borderColor = color(221, 221, 221).CGColor;
    confirmPassWordBgView.layer.cornerRadius = 3;
    confirmPassWordBgView.layer.masksToBounds = YES;
    [self.scro addSubview:confirmPassWordBgView];
    UILabel * confirmPassWordLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 60, 15)];
    confirmPassWordLable.text = @"确认密码";
    confirmPassWordLable.font = [UIFont systemFontOfSize:15];
    [confirmPassWordBgView addSubview:confirmPassWordLable];
    UIView * confirmPasswordLineView =[[UIView alloc] initWithFrame:CGRectMake(85, 14, 1, 16)];
    confirmPasswordLineView.backgroundColor = color(221, 221, 221);
    [confirmPassWordBgView addSubview:confirmPasswordLineView];
    UITextField  * confirmPasswordTextField =[[UITextField alloc] initWithFrame:CGRectMake(95, 0, WIDETH - 95, 45)];
    confirmPasswordTextField.placeholder = @"请输入确认密码";
    
    confirmPasswordTextField.textColor =[UIColor blackColor];
    confirmPasswordTextField.secureTextEntry = YES;
    confirmPasswordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    confirmPasswordTextField.font = [UIFont systemFontOfSize:13];
    confirmPasswordTextField.delegate = self;
    self.confirmPasswordTextField = confirmPasswordTextField;
    [confirmPassWordBgView addSubview:confirmPasswordTextField];
    
    UIButton *  resetpassword = [[UIButton alloc] initWithFrame:CGRectMake(15, 125, WIDETH - 30, 45)];
    [resetpassword setBackgroundImage:[UIImage imageNamed:@"lane"] forState:UIControlStateNormal];
    [resetpassword setTitle:@"重置密码" forState:UIControlStateNormal];
    resetpassword.titleLabel.textColor = color(255, 255, 255);
    resetpassword.titleLabel.font = [UIFont systemFontOfSize:19];
    resetpassword.layer.cornerRadius = 3;
    resetpassword.layer.masksToBounds = YES;
    [resetpassword addTarget:self action:@selector(resetpasswordClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:resetpassword];
    
    
}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    if (textField == self.newsPasswordTextFied) {
//        [self.confirmPasswordTextField becomeFirstResponder];
//
//    }
//
//       return YES;
//}
//-(void)loginRequest
//{
//
//}
#pragma mark--重置密码
-(void)resetpasswordClick
{
    
    //    NSUserDefaults * phone = [NSUserDefaults standardUserDefaults];
    
    if ([self.newsPasswordTextFied .text length]<6||[self.confirmPasswordTextField.text length]<6) {
        [MBProgressHUD creatembHub:@"密码不能少于6位" ControllerView:self];
        return;
    }
    if(![self.newsPasswordTextFied .text isEqualToString:self.confirmPasswordTextField.text])
    {
        [MBProgressHUD creatembHub:@"两次密码不一致" ControllerView:self];
        return;
    }
    else
    {
//        [[LoginAndRegisterRequest resetPasswordRequestWithPhoneNum:self.forgetPhoneMailBox withNewCode:self.newsPasswordTextFied.text withSucc:^(NSDictionary * dic) {
//            if ([dic[@"code"] integerValue]==0) {
//                TH_LoginVC * login = [[TH_LoginVC alloc] init];
//                [MBProgressHUD creatembHub:@"重置密码成功"];
//                //             self.navigationController.navigationBarHidden =  YES ;
//                //                TH_MainTabBarController * home = [[TH_MainTabBarController alloc] init];
//                //                home.modalTransitionStyle = UIModalPresentationPageSheet;
//                //                [self presentViewController:login animated:YES completion:nil];
//                [self.navigationController pushViewController:login animated:YES];
//            }
//        }] addNotifaction:[MBProgressHUD mbHubShow]];
        NSDictionary * param = @{@"mailbox":self.forgetPhoneMailBox,@"newpwd":self.newsPasswordTextFied.text};
        [[LoginAndRegisterRequest enterpriseResetPasswordRequestWithResumeParam:param withSucc:^(NSDictionary * dic ) {
            
        }] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
        
    }
    
}

-(void)createScro
{
    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro = scro;
    self.scro.backgroundColor = color(243, 243, 241);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
