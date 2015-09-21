//
//  WorkExReadingVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkExReadingVC.h"
#import "WorkExReadingView.h"
#import "WriteResumeVC2.h"
#import "ResumeModel.h"
#import "WorkingExperienceVC.h"
@interface WorkExReadingVC ()
{
    ResumeModel * _resume_model;
    
    
}

@end

@implementation WorkExReadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _resume_model = [ResumeModel sharedResume];
    WorkExReadingView * workingView =[WorkExReadingView setView];
    workingView.frame = CGRectMake(0, 0, WIDETH, 317);
    workingView.resumTitle.text = [NSString stringWithFormat:@"%@-证书",_resume_model.resumeName];
    workingView.descriptionTextView.userInteractionEnabled = NO;
    //发送网络请求，配置根据数组的[i]配置数据，布局。
    [workingView config:self.model];
    [self.view addSubview:workingView];
    
    UIButton * addButtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH - 150)/2.0, 317, 150, 30)];
   
    [addButtn setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    addButtn.titleLabel.font =[UIFont  systemFontOfSize:13];
    [addButtn setTitle:@"继续添加" forState:UIControlStateNormal];
    addButtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButtn];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
    // Do any additional setup after loading the view.
}
-(void)backToResume
{
    [self.navigationController popViewControllerAnimated:NO];
    for(UIViewController *controller in self.navigationController.viewControllers) {
        if([controller isKindOfClass:[WriteResumeVC2 class]]){
            WriteResumeVC2*owr = (WriteResumeVC2 *)controller;
            [self.navigationController popToViewController:owr animated:YES];
            
        }
//    [self.navigationController popViewControllerAnimated:NO];
//    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
//    [self.navigationController popToViewController:write animated:YES];
//    
//    [self.navigationController pushViewController:write animated:YES];
    }
}
#pragma mark --继续添加
-(void)addClick
{   [self.navigationController popViewControllerAnimated:YES];
//    WorkingExperienceVC * working = [[WorkingExperienceVC alloc] init];
////    [self.navigationController popToViewController:working animated:YES];
//    [self.navigationController pushViewController:working animated:YES];
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
