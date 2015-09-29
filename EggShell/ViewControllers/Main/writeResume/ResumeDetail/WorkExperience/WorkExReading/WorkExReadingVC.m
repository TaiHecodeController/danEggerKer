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
@property(nonatomic,strong)NSArray * dataArray;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation WorkExReadingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
    [self.view addSubview:scro];
    [self loadData];
    
    // Do any additional setup after loading the view.
}
-(void)loadData
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    NSDictionary * param = @{@"eid":[AppDelegate instance].resumeId, @"uid":userUid ,@"token":tokenStr};
    [WriteResumeRequest resumeWritingPreviewWithSucc:^(NSDictionary *dataDic) {
        self.dataArray = [NSArray arrayWithArray:dataDic[@"data"]];
        [self createView];
        
    } resumeWritingPreviewParam:param];
}

-(void)createView
{
    for (int i = 0; i< self.dataArray.count; i++) {
        _resume_model = [ResumeModel sharedResume];
        WorkExReadingView * workingView =[WorkExReadingView setView];
        workingView.frame = CGRectMake(0, 215*i, WIDETH, 215);
        workingView.resumTitle.text = [NSString stringWithFormat:@"%@-工作经历%d",_resume_model.resumeName,i+1];
        [workingView.descriptionTextView setEditable:NO];
        workingView.descriptionTextView.showsVerticalScrollIndicator  = NO;
        workingView.descriptionTextView.scrollEnabled = YES;
        
        [workingView config:self.dataArray[i]];
        [self.scro addSubview:workingView];
        if (i>0) {
            workingView.workBtn.hidden = YES;
        }
        UIButton * addButtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH - 150)/2.0, 215*self.dataArray.count+35, 150, 30)];
        [addButtn setBackgroundImage:[UIImage imageNamed:@"lanniu"] forState:UIControlStateNormal];
        addButtn.titleLabel.font =[UIFont  systemFontOfSize:13];
        [addButtn setTitle:@"继续添加" forState:UIControlStateNormal];
        addButtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [addButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        [self.scro addSubview:addButtn];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backToResume) name:@"writeresum" object:nil];
        
        self.scro.contentSize = CGSizeMake(WIDETH, self.dataArray.count*215+150);
    }
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
