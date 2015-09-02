//
//  WorkExReadingVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkExReadingVC.h"
#import "WorkExReadingView.h"
@interface WorkExReadingVC ()

@end

@implementation WorkExReadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WorkExReadingView * workingView =[WorkExReadingView setView];
    workingView.frame = CGRectMake(0, 0, 302, WIDETH);
    workingView.descriptionTextView.userInteractionEnabled = NO;
    [self.view addSubview:workingView];
    
    UIButton * addButtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH - 150)/2.0, 302, 150, 30)];
    [addButtn setImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
    [addButtn setTitle:@"继续添加" forState:UIControlStateNormal];
    [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}
#pragma mark --继续添加
-(void)addClick
{

    
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
