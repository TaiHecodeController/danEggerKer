//
//  TH_ResumePreviewVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ResumePreviewVC.h"
#import "Basicnformation.h"
@interface TH_ResumePreviewVC ()
@property(nonatomic,strong)UIScrollView *scro;
@end

@implementation TH_ResumePreviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    [self.view addSubview:scro];
    [self createTilteView];
    [self createView];
}
-(void)createTilteView
{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 42)];
    titleView.backgroundColor = UIColorFromRGB(0xf3f3f1);
    [self.scro addSubview:titleView];
    
    UILabel * myLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 13)];
    myLable.text = @"个人简历001";
    myLable.font =[UIFont systemFontOfSize:13];
    [titleView addSubview:myLable];
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 165, 16, 150, 11)];
    timeLable.text = @"创建于2015-08-03";
    timeLable.font =[UIFont systemFontOfSize:11];
    timeLable.textColor = UIColorFromRGB(0x646464);
    timeLable.textAlignment = NSTextAlignmentRight;
    [titleView addSubview:timeLable];
}

-(void)createView
{
    Basicnformation * baseInformation =[Basicnformation setBaseView];
    baseInformation.frame = CGRectMake(0, 42, WIDETH, 158);
    [self.scro addSubview:baseInformation];
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
