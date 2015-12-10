//
//  FindjobView.m
//  maishipei
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 XH. All rights reserved.
//

#import "FindjobView.h"

@implementation FindjobView

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
    //社交圈
    UIButton * findjobBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth, 10*MyWideth,40.5*MyWideth ,46.5*MyWideth)];
    findjobBtn.tag = THHomeViewButtonTypeFindJob;
    [findjobBtn setImage:[UIImage imageNamed:@"shejiaoquan2.0"] forState:UIControlStateNormal];
    self.findjobBtn = findjobBtn;
    [findjobBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:findjobBtn];
    UILabel * findjobLable =[[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth-5, 10*MyWideth+46.5*MyWideth+7*MyWideth, 40.5*MyWideth+10, 12)];
    findjobLable.text = @"社交圈";
    findjobLable.font = [UIFont systemFontOfSize:12];
    findjobLable.textColor = UIColorFromRGB(0x646464);
    findjobLable.textAlignment = NSTextAlignmentCenter;
    self.findjobLable = findjobLable;
    [self addSubview:findjobLable];
    //玩出范
    UIButton * FindPartTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+40.5*MyWideth+53*MyWideth, 10*MyWideth, 40.5*MyWideth, 46.5*MyWideth)];
    FindPartTimeBtn.tag = THHomeViewButtonTypeFindPartTime;
    [FindPartTimeBtn setImage:[UIImage imageNamed:@"wanchufan2.0"] forState:UIControlStateNormal];
    self.FindPartTimeBtn = FindPartTimeBtn;
    [FindPartTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:FindPartTimeBtn];
    UILabel * FindPartTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+40.5*MyWideth+53*MyWideth-5,10*MyWideth+46.5*MyWideth+7*MyWideth, 40.5*MyWideth+10, 12)];
    FindPartTimeLable.text = @"玩出范";
    FindPartTimeLable.textColor = UIColorFromRGB(0x646464);
    FindPartTimeLable.font = [UIFont systemFontOfSize:12];
    FindPartTimeLable.textAlignment = NSTextAlignmentCenter;
    self.FindPartTimeLable = FindPartTimeLable;
    [self addSubview:FindPartTimeLable];
//    V达人
    UIButton * InternshipSearchBtn =[[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*2+(53*MyWideth)*2, 10*MyWideth, 40.5*MyWideth, 46.5*MyWideth)];
    [InternshipSearchBtn setImage:[UIImage imageNamed:@"vdaren2.0"] forState:UIControlStateNormal];
    InternshipSearchBtn.tag = THHomeViewButtonTypeInternshipSearch;
    self.InternshipSearchBtn = InternshipSearchBtn;
    [InternshipSearchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:InternshipSearchBtn];
    
    UILabel * InternshipSearchLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*2+(53*MyWideth)*2-5, 10*MyWideth+46.5*MyWideth+7*MyWideth, 40.5*MyWideth+10, 12)];
    InternshipSearchLable.text = @"V达人";
    InternshipSearchLable.textColor = UIColorFromRGB(0x646464);
    InternshipSearchLable.font = [UIFont systemFontOfSize:12];
    InternshipSearchLable.textAlignment = NSTextAlignmentCenter;
    self.InternshipSearchLable = InternshipSearchLable;
    
    [self addSubview:InternshipSearchLable];
    // 去学习
    UIButton * InformationDeskBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*3+(53*MyWideth)*3, 10*MyWideth, 40.5*MyWideth, 46.5*MyWideth)];
    [InformationDeskBtn setImage:[UIImage imageNamed:@"qvxuexi2.0"] forState:UIControlStateNormal];
    self.InformationDeskBtn = InformationDeskBtn;
    InformationDeskBtn.tag = THHomeViewButtonTypeInformationDesk;
    [InformationDeskBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:InformationDeskBtn];
    UILabel * InformationDeskLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*3+(53*MyWideth)*3-5,10*MyWideth+46.5*MyWideth+7*MyWideth, 40.5*MyWideth+10, 12)];
    InformationDeskLable.text = @"去学习";
    InformationDeskLable.textColor = UIColorFromRGB(0x646464);

    InformationDeskLable.font =  [UIFont systemFontOfSize:12];
    InformationDeskLable.textAlignment = NSTextAlignmentCenter;
    self.InformationDeskLable = InformationDeskLable;
    [self addSubview:InformationDeskLable];


//    找工作
    UIButton * fesumeWritingBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth, 10*MyWideth+46.5*MyWideth+7*MyWideth+15*MyWideth+12, 40.5*MyWideth, 46.5*MyWideth)];
    
    [fesumeWritingBtn setImage:[UIImage imageNamed:@"zhaogongzuo2.0"] forState:UIControlStateNormal];
    self.fesumeWritingBtn  = fesumeWritingBtn;
    fesumeWritingBtn.tag = THHomeViewButtonTypeResumeWriting;
    [fesumeWritingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fesumeWritingBtn];
    UILabel * fesumeWritingLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth-5, 10*MyWideth+(46.5*MyWideth)*2+(7*MyWideth)*2+15*MyWideth+12, 40.5*MyWideth+10, 12)];
    fesumeWritingLable.text = @"找工作";
   
    fesumeWritingLable.textColor = UIColorFromRGB(0x646464);
    fesumeWritingLable.textAlignment = NSTextAlignmentCenter;
    fesumeWritingLable.font = [UIFont systemFontOfSize:12];
    self.fesumeWritingLable = fesumeWritingLable;
    [self addSubview:fesumeWritingLable];
    
    //找兼职
    UIButton * PlayFanBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+40.5*MyWideth+53*MyWideth, 10*MyWideth+46.5*MyWideth+7*MyWideth+15*MyWideth+12, 40.5*MyWideth ,46.5*MyWideth)];
    [PlayFanBtn setImage:[UIImage imageNamed:@"zhaojianzhi2.0"] forState:UIControlStateNormal];
    self.PlayFanBtn = PlayFanBtn;
    PlayFanBtn.tag = THHomeViewButtonTypePlayFan;
    [PlayFanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:PlayFanBtn];
    
    UILabel * PlayFanLable =[[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+40.5*MyWideth+53*MyWideth-5, 10*MyWideth+(46.5*MyWideth)*2+(7*MyWideth)*2+15*MyWideth+12, 40.5*MyWideth+10, 12)];
    PlayFanLable.text = @"找兼职";
    PlayFanLable.textColor = UIColorFromRGB(0x646464);
    PlayFanLable.textAlignment = NSTextAlignmentCenter;
    
    PlayFanLable.font = [UIFont systemFontOfSize:12];
    self.PlayFanLable = PlayFanLable;
    [self addSubview:PlayFanLable];
    
   //找实习
    UIButton * MicroSocialBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*2+(53*MyWideth)*2, 10*MyWideth+46.5*MyWideth+7*MyWideth+15*MyWideth+12, 40.5*MyWideth, 46.5*MyWideth)];
    [MicroSocialBtn setImage:[UIImage imageNamed:@"zhaoshixi2.0"] forState:UIControlStateNormal];
    self.MicroSocialBtn = MicroSocialBtn;
    MicroSocialBtn.tag = THHomeViewButtonTypeMicroSocial;
    [MicroSocialBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:MicroSocialBtn];
    UILabel * MicroSocialLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*2+(53*MyWideth)*2-5,10*MyWideth+(46.5*MyWideth)*2+(7*MyWideth)*2+15*MyWideth+12, 40.5*MyWideth+10, 12)];
    MicroSocialLable.text = @"找实习";
    MicroSocialLable.textColor = UIColorFromRGB(0x646464);
    MicroSocialLable.textAlignment= NSTextAlignmentCenter;
    MicroSocialLable.font = [UIFont systemFontOfSize:12];
    self.MicroSocialLable = MicroSocialLable;
    [self addSubview:MicroSocialLable];
    //写简历
    UIButton * openClassBtn = [[UIButton alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*3+(53*MyWideth)*3, 10*MyWideth+46.5*MyWideth+7*MyWideth+15*MyWideth+12, 40.5*MyWideth, 46.5*MyWideth)];
    [openClassBtn setImage:[UIImage imageNamed:@"xiejianli2.0"] forState:UIControlStateNormal];
    self.openClassBtn = openClassBtn;
    openClassBtn.tag = THHomeViewButtonTypeOpenClass;
    [openClassBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:openClassBtn];
    UILabel * openClassLable = [[UILabel alloc] initWithFrame:CGRectMake(27*MyWideth+(40.5*MyWideth)*3+(53*MyWideth)*3-5, 10*MyWideth+(46.5*MyWideth)*2+(7*MyWideth)*2+15*MyWideth+12, 40.5*MyWideth+10, 12)];
    openClassLable.text = @"写简历";
     openClassLable.textColor = UIColorFromRGB(0x646464);
    openClassLable.textAlignment= NSTextAlignmentCenter;
    openClassLable.font = [UIFont systemFontOfSize:12];
    self.openClassLable = openClassLable;
    [self addSubview:openClassLable];
}
-(void)btnClick:(UIButton*)sender
{
    if ([self.homeViewDelegate respondsToSelector:@selector(findViewFindJob:DidClickButton:)]) {
        [self.homeViewDelegate findViewFindJob:self DidClickButton:(THHomeViewButtonType)sender.tag];
    }

}
@end
