//
//  ComPanyProfileView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ComPanyProfileView.h"
@interface ComPanyProfileView()
@end
@implementation ComPanyProfileView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{

    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 2, 13)];
    lineView.backgroundColor = UIColorFromRGB(0xF44336);
    self.lineView = lineView;
    [self addSubview:lineView];
    UILabel * compayFile = [[UILabel alloc] initWithFrame:CGRectMake(22, 16, 52, 13)];
    compayFile.text = @"公司简介";
    compayFile.font =[UIFont systemFontOfSize:13];
    compayFile.textColor = UIColorFromRGB(0x646464);
    [self addSubview:compayFile];
    
    UILabel * detailLalbe = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, WIDETH-30, 68)];
    detailLalbe.text = @"根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发根据项目需求，项目经理要求完成相关应用的就与开发，保证IFA质量，并且在用和开发的";
    self.textSize = [self.detailLable.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
    self.detailLable = detailLalbe;
    detailLalbe.font = [UIFont systemFontOfSize:13];
    detailLalbe.numberOfLines = 6;
//    detailLalbe.backgroundColor =[UIColor redColor];
    [self addSubview:detailLalbe];
    
    UIButton * selectBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH-100)/2.0, self.height-45, 100, 30)];
    [selectBtn setBackgroundImage:[UIImage imageNamed:@"anniukuang"] forState:UIControlStateNormal];
    [selectBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [selectBtn setTitle:@"点击收起" forState:UIControlStateSelected];
    [selectBtn setImage:[UIImage imageNamed:@"chakan"] forState:UIControlStateNormal ];
    [selectBtn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateSelected];
     selectBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-108);
    selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
    [selectBtn setTitleColor:UIColorFromRGB(0xF44336) forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [selectBtn addTarget:self action:@selector(btncompanyClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.selectBtn = selectBtn;
    [self addSubview:selectBtn];
}
-(void)btncompanyClick
{
    if ([self.delegate respondsToSelector:@selector(CompanyProfilView:)]) {
        [self.delegate CompanyProfilView:self];
    }
    NSLog(@"skdb");
}
-(void)config:(NSString *)str
{
    self.detailLable.text = str;
}

@end
