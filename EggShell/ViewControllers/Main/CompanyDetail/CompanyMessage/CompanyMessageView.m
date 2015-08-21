//
//  CompanyMessageView.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CompanyMessageView.h"
@interface CompanyMessageView ()
{
    UILabel * industryLab;
    UILabel * natureLab;
    UILabel * scaleLab;
    UILabel * addressLab;
    UILabel * companyIntroduce;
    CGRect record_Message;
    CGRect record_ShowAll;
    CGRect record_SelfView;
    
}
@end

@implementation CompanyMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    industryLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 240, 15)];
    [self addSubview:industryLab];
    industryLab.text = @"行业：计算机软件，IT服务，系统集成";
    industryLab.font = [UIFont systemFontOfSize:14];
    
    natureLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 240, 15)];
    natureLab.text = @"性质：中外合资";
    natureLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:natureLab];
    
    scaleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 240, 15)];
    scaleLab.text = @"规模：100人以上";
    scaleLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:scaleLab];
    
    addressLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, WIDETH - 30, 15)];
    addressLab.text = @"地址：北京市朝阳区建国路112号中国惠普大厦";
    addressLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:addressLab];
    
    companyIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(18, 120, WIDETH - 15, 15)];
    companyIntroduce.text = @"公司介绍";
    companyIntroduce.font = [UIFont systemFontOfSize:14];
    [self addSubview:companyIntroduce];
    
    self.companyMessage = [[UILabel alloc] initWithFrame:CGRectMake(15, 132, WIDETH - 30, 80)];
    self.companyMessage.numberOfLines = 5;
    self.companyMessage.text = @"根据项目的需求，项目经理要求完成相关应用系统设计和系统开发，我当前的1大的多说的随处可见哈上帝对撒旦科技和打卡的期待和萨看到很多期待打可视电话期望的大都会区看万家灯火请问大家活动看得起万家灯火的简单好看却觉得好奇我看见的话去外地回去我看到机会去外地客户期望的借口";
    self.textSize = [self.companyMessage.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
    self.companyMessage.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.companyMessage];
    
    self.showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showAllBtn.frame = CGRectMake((WIDETH -100)/2, 218, 100, 30);
    [self.showAllBtn setBackgroundImage:[UIImage imageNamed:@"showallBtn"] forState:UIControlStateNormal];
    [self.showAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.showAllBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.showAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.showAllBtn setTitle:@"点击收起" forState:UIControlStateSelected];
    [self.showAllBtn setImage:[UIImage imageNamed:@"chakan"] forState:UIControlStateNormal ];
    [self.showAllBtn setImage:[UIImage imageNamed:@"shouqi"] forState:UIControlStateSelected];
    self.showAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-115);
    self.showAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
    [self.showAllBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [self.showAllBtn addTarget:self action:@selector(showAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showAllBtn];
    
}

-(void)showAllClick:(UIButton *)sender
{
    self.showAllClick(sender);
    
}
@end
