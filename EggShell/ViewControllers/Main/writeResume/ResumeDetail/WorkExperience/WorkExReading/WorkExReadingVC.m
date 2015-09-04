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
@interface WorkExReadingVC ()

@end

@implementation WorkExReadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WorkExReadingView * workingView =[WorkExReadingView setView];
    workingView.frame = CGRectMake(0, 0, WIDETH, 317);
    workingView.descriptionTextView.userInteractionEnabled = NO;
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
    WriteResumeVC2 * write = [[WriteResumeVC2 alloc] init];
    [self.navigationController popToViewController:write animated:YES];
    
//    [self.navigationController pushViewController:write animated:YES];
}
#pragma mark --继续添加
-(void)addClick
{

    [self.navigationController popViewControllerAnimated:YES];
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
