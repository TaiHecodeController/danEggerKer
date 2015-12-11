//
//  FamousRecommendedView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "FamousRecommendedView.h"

@implementation FamousRecommendedView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

-(void)makeUI
{
    //
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 10)];
    lineView.backgroundColor = UIColorFromRGB(0XF3F3F1);
    [self addSubview:lineView];
    //白标题
    UILabel * titleLable  =[[UILabel alloc] initWithFrame:CGRectMake(15, 20, 100, 15)];
    titleLable.text = @"名企推荐";
    titleLable.font = [UIFont systemFontOfSize:15];
    titleLable.textColor = UIColorFromRGB(0x323232);
    [self addSubview:titleLable];
    //第一lingeView
    UIView * firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, WIDETH, .5)];
    firstView.backgroundColor = UIColorFromRGB(0xE6E6E6);
    [self addSubview:firstView];
    
    NSArray * imageCount = @[@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu"];
    
    for (int i = 0; i < imageCount.count; i++) {
        UIView *  famoutsRecruitBgView   = [[UIView alloc] initWithFrame:CGRectMake(15*MyWideth+80*MyWideth*(i%3)+(((WIDETH-30*MyWideth-240*MyWideth)/2)*MyWideth)*(i%3), 70+30*(i/3)+25*(i/3), 80*MyWideth, 30)];
        [self addSubview:famoutsRecruitBgView];
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
//        [button setImage:[UIImage imageNamed:imageCount[i]] forState:UIControlStateNormal];
        [famoutsRecruitBgView addSubview:button];
        UIImageView * famoutsRecruitImageView   =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        self.famoutsRecruitImageView = famoutsRecruitImageView;
       famoutsRecruitImageView.image =[UIImage imageNamed:imageCount[i]];
        [famoutsRecruitBgView addSubview:famoutsRecruitImageView];
        
        if (i ==0) {
            self.first = button;
            self.firstImageView = famoutsRecruitImageView;
            
        }
        if (i ==1) {
            self.second = button;
            self.secondImageView = famoutsRecruitImageView;
        }
        if (i ==2) {
            self.three = button;
            self.threeImageView = famoutsRecruitImageView;
        }
        if (i ==3) {
            self.fourth = button;
            self.fourthImageView = famoutsRecruitImageView;
        }
        if (i ==4) {
            self.five = button;
            self.fiveImageView = famoutsRecruitImageView;
        }
        if (i ==5) {
            self.six = button;
            self.sixImageView = famoutsRecruitImageView;
        }
        if (i ==6) {
            self.seven = button;
            self.sevenImageView = famoutsRecruitImageView;
        }
        if (i ==7) {
            self.eight = button;
            self.eightImageView = famoutsRecruitImageView;
        }
        if (i ==8) {
            self.nine = button;
            self.nineImageView = famoutsRecruitImageView;
        }
        
    }
    
}
-(void)btnClick:(UIButton * )sender
{
    int tag = (int)sender.tag;
    if ([self.famousRecommendedViewDelegate respondsToSelector:@selector(FamousRecommendedViewJob:DidClickButton:)]) {
        [self.famousRecommendedViewDelegate FamousRecommendedViewJob:self DidClickButton:tag];
    }

}
-(void)configValue:(NSArray*)array
{
    
//    [self.first setButtonImageWithUrl:array[0][@"hot_pic"]];
//   [self.second setButtonImageWithUrl:array[1][@"hot_pic"]];
//  [self.three setButtonImageWithUrl:array[2][@"hot_pic"]];
//    [self.fourth setButtonImageWithUrl:array[3][@"hot_pic"]];
//    [self.five setButtonImageWithUrl:array[4][@"hot_pic"]];
//    [self.six setButtonImageWithUrl:array[5][@"hot_pic"]];
//    [self.seven setButtonImageWithUrl:array[6][@"hot_pic"]];
//    [self.eight setButtonImageWithUrl:array[7][@"hot_pic"]];
//    [self.nine setButtonImageWithUrl:array[8][@"hot_pic"]];
    
    [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:array[0][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:array[1][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:array[2][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.fourthImageView sd_setImageWithURL:[NSURL URLWithString:array[3][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.fiveImageView sd_setImageWithURL:[NSURL URLWithString:array[4][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.sixImageView sd_setImageWithURL:[NSURL URLWithString:array[5][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.sevenImageView sd_setImageWithURL:[NSURL URLWithString:array[6][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.eightImageView sd_setImageWithURL:[NSURL URLWithString:array[7][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
    [self.nineImageView sd_setImageWithURL:[NSURL URLWithString:array[8][@"hot_pic"]] placeholderImage:[UIImage imageNamed:@"qiyemorentu"]];
}
@end
