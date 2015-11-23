//
//  EnterpriseDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/19.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EnterpriseDetailVC.h"
#import "EnterpriseView.h"
#import "TH_ReceiveResumeVC.h"
#import "TH_TalentPoolVC.h"
#import "TH_AllPositionVC.h"
#import "TH_RecruitmentPositionVC.h"
#import "TH_OutDatePosionVC.h"
@interface EnterpriseDetailVC ()<THEnterprisedDelegate>

@end

@implementation EnterpriseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    /*去个人**/
    
    UIButton * perseonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 64, 44)];
    [perseonBtn setTitle:@"去个人" forState:UIControlStateNormal];
    [perseonBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [perseonBtn addTarget:self action:@selector(perseonBtn) forControlEvents:UIControlEventTouchUpInside];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:perseonBtn];
   self.title = @"蛋壳招聘";
    [self createEnterView];

}
-(void)perseonBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --  enterPrese相应事件
-(void)createEnterView
{
    EnterpriseView  * enterPrise =[EnterpriseView setEnterpriseView];
    [enterPrise setEnterpriseValue];
    enterPrise.enterDelegate = self;
    [self.view addSubview:enterPrise];


}

-(void)enterprise:(EnterpriseView *)Enterprise DidClickButton:(THEnterpriseType)buttonType
{
    switch (buttonType) {
        case THEnterpriseTypeReceiveResumeLable:
        {
            [self.navigationController pushViewController:[[TH_ReceiveResumeVC alloc]init] animated:YES];
        
            NSLog(@"收到简历个数");
            break;
        }
        case THEnterpriseTypeTalentPoolBtn:
        {[self.navigationController pushViewController:[[TH_TalentPoolVC alloc]init] animated:YES];
            
            NSLog(@"人才库");
            
            break;
        }
        case THEnterpriseTypeAllPositionBtn:
        {
            [self.navigationController pushViewController:[[TH_AllPositionVC alloc]init] animated:YES];
            NSLog(@"所有职位");
            
            break;
        }
        case THEnterpriseTypeRecruitmentPositionBtn:
        {
            [self.navigationController pushViewController:[[TH_RecruitmentPositionVC alloc]init] animated:YES];
            NSLog(@"招聘中职位");
            
            break;
        }
        case THEnterpriseTypeOutDatePosionBtn:
        {
            [self.navigationController pushViewController:[[TH_OutDatePosionVC alloc]init] animated:YES];
            NSLog(@"过期职位");
            
            break;
        }
        default:
            break;
    }

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
