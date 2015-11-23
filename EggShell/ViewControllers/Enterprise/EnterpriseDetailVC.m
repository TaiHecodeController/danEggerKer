//
//  EnterpriseDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/19.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EnterpriseDetailVC.h"
#import "EnterpriseView.h"
@interface EnterpriseDetailVC ()<THEnterprisedDelegate>

@end

@implementation EnterpriseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"蛋壳招聘";
    [self createEnterView];

}
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
        
            NSLog(@"收到简历个数");
        
            break;
        }
        case THEnterpriseTypeTalentPoolBtn:
        {
            
            NSLog(@"人才库");
            
            break;
        }
        case THEnterpriseTypeAllPositionBtn:
        {
            
            NSLog(@"所有职位");
            
            break;
        }
        case THEnterpriseTypeRecruitmentPositionBtn:
        {
            
            NSLog(@"招聘中职位");
            
            break;
        }
        case THEnterpriseTypeOutDatePosionBtn:
        {
            
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
