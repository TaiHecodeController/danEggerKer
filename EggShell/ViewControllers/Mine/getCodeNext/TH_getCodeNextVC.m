//
//  TH_getCodeNextVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_getCodeNextVC.h"
#import "TH_MainTabBarController.h"
#import "AppDelegate.h"
@interface TH_getCodeNextVC ()
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation TH_getCodeNextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color(243, 243, 243);
    [self createScro];
    [self createView]
    ;    // Do any additional setup after loading the view.
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
    newPasswordTextFied.textColor = color(200, 200, 200);
    newPasswordTextFied.font = [UIFont systemFontOfSize:13];
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
    confirmPasswordTextField.textColor = color(200, 200, 200);
    confirmPasswordTextField.font = [UIFont systemFontOfSize:13];
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
-(void)resetpasswordClick
{
    self.navigationController.navigationBarHidden =  YES ;
    TH_MainTabBarController * home = [[TH_MainTabBarController alloc] init];
   
    home.modalTransitionStyle = UIModalPresentationPageSheet;
    [self presentViewController:home animated:YES completion:nil];
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
