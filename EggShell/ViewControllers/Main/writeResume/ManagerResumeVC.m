//
//  ManagerResumeVC.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ManagerResumeVC.h"
#import "TH_ResumePreviewVC.h"
#import "WriteResumeViewController.h"
@interface ManagerResumeVC ()
{
    UIView * _alertView;
    UIView * bgView;
}

@end

@implementation ManagerResumeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"简历管理";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)createNewResume:(UIButton *)sender {
    
    WriteResumeViewController * write = [[WriteResumeViewController alloc] init];
    [self.navigationController pushViewController:write animated:YES];
}
- (IBAction)previewresume:(id)sender {
    TH_ResumePreviewVC  * presum = [[TH_ResumePreviewVC alloc] init];
    presum.title = @"简历预览";
    [self.navigationController pushViewController:presum animated:YES];
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

- (IBAction)createNewResumeClick:(UIButton *)sender {
}
- (IBAction)editClick:(UIButton *)sender {
}
- (IBAction)userResume:(UIButton *)sender {
    [self addAlertView];
}

- (void)addAlertView
{
    bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.5;
    [self.view addSubview:bgView];
    CGFloat margin = 10;
    
    UIImage *bgimg = [UIImage imageNamed:@"shenqing"];
    CGFloat alertViewX = (WIDETH - bgimg.size.width) / 2;
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(alertViewX, -bgimg.size.height, bgimg.size.width, bgimg.size.height)];
    alertView.backgroundColor = [UIColor colorWithPatternImage:bgimg];
    [self.view addSubview:alertView];
    _alertView = alertView;
    
    
    
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.text = @"申请职位";
    lab1.textColor =[UIColor whiteColor];
    lab1.font = [UIFont systemFontOfSize:13];
    CGSize labSize = [lab1.text sizeWithFont:lab1.font];
    lab1.frame = CGRectMake(margin, margin, labSize.width, labSize.height);
    [alertView addSubview:lab1];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    CGFloat closeWith = 10;
    closeBtn.frame = CGRectMake(alertView.frame.size.width - margin - closeWith, margin, closeWith, closeWith);
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    UITextView *jianliBtn = [[UITextView alloc]init];
    jianliBtn.text = [NSString stringWithFormat:@"使用"];
    jianliBtn.font = [UIFont systemFontOfSize:13];
    jianliBtn.frame = CGRectMake(margin, 40, 300, 50);
    [alertView addSubview:jianliBtn];
    
    UILabel * lab3 = [ZCControl createLabelWithFrame:CGRectMake(31, 1, 120, 30) Font:13 Text:@"简历001"];
    lab3.textColor = [UIColor redColor];
    [jianliBtn addSubview:lab3];
    
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = color(63, 172, 241);
    CGFloat okBtnW =( 1- 0.34 * 2) * alertView.frame.size.width;
    okBtn.frame = CGRectMake(0.34 * alertView.frame.size.width, 100 , okBtnW, 30);
    okBtn.clipsToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    [okBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:okBtn];
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        alertView.frame = CGRectMake(alertViewX, 145, bgimg.size.width, bgimg.size.height);
        alertView.transform = CGAffineTransformMakeRotation((45.0 * M_PI)/180.0f);
        
        [UIView animateWithDuration:0.1 delay:0.05 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            alertView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
    } completion:^(BOOL finished) {
        
        

    }];
    
    
    
}

-(void)okBtn
{
    [_alertView removeFromSuperview];
    [bgView removeFromSuperview];
}

-(void)closeBtn
{
    [_alertView removeFromSuperview];
    [bgView removeFromSuperview];
}


- (IBAction)delete:(id)sender {
    
}
@end
