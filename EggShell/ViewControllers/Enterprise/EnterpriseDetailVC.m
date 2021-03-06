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
#import "TH_LoginVC.h"
#import "enterPriseRequest.h"
@interface EnterpriseDetailVC ()<THEnterprisedDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)EnterpriseView  * enterPrise;




@end

@implementation EnterpriseDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationItem.hidesBackButton = YES;
    
    [self querData];
}

- (void)querData
{
     [enterPriseRequest requestGetResumeNumberWithSucc:^(NSDictionary *DataDic) {
         
         NSLog(@"%@",DataDic);
         _enterPrise.ResumeLab.text = [NSString stringWithFormat:@"已收到%@个", DataDic[@"data"][@"resume"]];
//         NSMutableAttributedString *markLabelStr = [[NSMutableAttributedString alloc] initWithString:_enterPrise.ResumeLab.text];
//         [markLabelStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xF44336) range:NSMakeRange(3,4)];
//         _enterPrise.ResumeLab.attributedText = markLabelStr;
//
         
    } uid:@"1869"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color(240, 240, 237);
    self.scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-64)];
    self.scro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scro];
    /*去个人**/
    UIButton * perseonBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 67, 44)];
    [perseonBtn setTitle:@"去个人" forState:UIControlStateNormal];
    
    [perseonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [perseonBtn addTarget:self action:@selector(perseonBtn) forControlEvents:UIControlEventTouchUpInside];
    perseonBtn.titleLabel.font = [UIFont systemFontOfSize:14];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:perseonBtn];
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(62, 17, 5, 10)];
    backImageView.image = [UIImage imageNamed:@"qugeren"];
    [perseonBtn addSubview:backImageView];
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
    enterPrise.frame = CGRectMake(0, 0, WIDETH, 430);
    [enterPrise setEnterpriseValue];
    enterPrise.enterDelegate = self;
    self.enterPrise = enterPrise;
    [enterPrise.ExitSignBtn addTarget:self action:@selector(ExitSignBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.scro addSubview:enterPrise];
    self.scro.contentSize = CGSizeMake(WIDETH, 480);


}
-(void)ExitSignBtn:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.enterPrise.headPortraitImageView.image = [UIImage imageNamed:@"dashi"];
self.enterPrise.companyNameLable.hidden = NO;
        self.enterPrise.companyNameLable.text = @"北京太和天下投资控股有限公司";
        self.enterPrise.CheckStatusImageView.image = [UIImage imageNamed:@"yishenhe"];
    }else
    {
        self.enterPrise.headPortraitImageView.image = [UIImage imageNamed:@"touxiang1"];
        self.enterPrise.companyNameLable.hidden = YES;        self.enterPrise.CheckStatusImageView.image = [UIImage imageNamed:@"daishenhe"];
    }
//    TH_LoginVC * login = [[TH_LoginVC alloc] init];
//    [self.navigationController pushViewController:login animated:YES];

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
        {
            [self.navigationController pushViewController:[[TH_TalentPoolVC alloc]init] animated:YES];
            
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
