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
        
        [button setImage:[UIImage imageNamed:imageCount[i]] forState:UIControlStateNormal];
        [famoutsRecruitBgView addSubview:button];
//        UIImageView * famoutsRecruitImageView   =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
//        self.famoutsRecruitImageView = famoutsRecruitImageView;
//        famoutsRecruitImageView.image =[UIImage imageNamed:imageCount[i]];
//        [famoutsRecruitBgView addSubview:famoutsRecruitImageView];
        
        if (i ==0) {
            self.first = button;
        }
        if (i ==1) {
            self.second = button;
        }
        if (i ==2) {
            self.three = button;
        }
        if (i ==3) {
            self.fourth = button;
        }
        if (i ==4) {
            self.five = button;
        }
        if (i ==5) {
            self.six = button;
        }
        if (i ==6) {
            self.seven = button;
        }
        if (i ==7) {
            self.eight = button;
        }
        if (i ==8) {
            self.nine = button;
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
    
    [self.first setButtonImageWithUrl:array[0][@"hot_pic"]];
    [self.second setButtonImageWithUrl:array[1][@"hot_pic"]];
    [self.three setButtonImageWithUrl:array[2][@"hot_pic"]];
    [self.fourth setButtonImageWithUrl:array[3][@"hot_pic"]];
    [self.five setButtonImageWithUrl:array[4][@"hot_pic"]];
    [self.six setButtonImageWithUrl:array[5][@"hot_pic"]];
    [self.seven setButtonImageWithUrl:array[6][@"hot_pic"]];
    [self.eight setButtonImageWithUrl:array[7][@"hot_pic"]];
    [self.nine setButtonImageWithUrl:array[8][@"hot_pic"]];
////    NSArray * imageCount = @[@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu",@"qiyemorentu"];
////    
//    for (int i = 0; i < array.count; i++) {
//                [self.button setButtonImageWithUrl:array[i][@"hot_pic"]];
//
//
//        
//    }
    
   
    
    
  
}
@end
