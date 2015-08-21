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
//    //宽高
//    static CGFloat wideth;
//    static CGFloat height;
    //找工作btn
    static CGFloat findjobBtnX;
    static CGFloat findjobBtnY;
    static CGFloat findjobBtnWideth;
    static CGFloat findjobBtnHeight;
    //找工作ab
    static CGFloat findjobLableX;
    static CGFloat findjobLableY;
    static CGFloat findjobLableWideth;
    static CGFloat findjobLableHeight;
    //找兼职btn
    static CGFloat FindPartTimeBtnX;
    static CGFloat FindPartTimeBtnY;
    static CGFloat FindPartTimeBtnWideth;
    static CGFloat FindPartTimeBtnHeight;
    //找兼职lab
    static CGFloat FindPartTimeLableX;
    static CGFloat FindPartTimeLableY;
    static CGFloat FindPartTimeLableWideth;
    static CGFloat FindPartTimeLableHeight;
    //找实习btn
    static CGFloat InternshipSearchBtnX;
    static CGFloat InternshipSearchBtnY;
    static CGFloat InternshipSearchBtnWideth;
    static CGFloat InternshipSearchBtnHeight;
    //找实习lab
    static CGFloat  InternshipSearchLableX;
    static CGFloat  InternshipSearchLableY;
    static CGFloat  InternshipSearchLableWideth;
    static CGFloat  InternshipSearchLableHeight;
    //信息台btn
    static CGFloat InformationDeskBtnX;
    static CGFloat InformationDeskBtnY;
    static CGFloat InformationDeskBtnWideth;
    static CGFloat InformationDeskBtnHeight;
    //信息台lab
    static CGFloat InformationDeskLableX;
    static CGFloat InformationDeskLableY;
    static CGFloat InformationDeskLableWideth;
    static CGFloat InformationDeskLableHeight;
    //写简历btn
    static CGFloat fesumeWritingBtnX;
    static CGFloat fesumeWritingBtnY;
    static CGFloat fesumeWritingBtnWideth;
    static CGFloat fesumeWritingBtnHeight;
    //写简历lab
    static CGFloat fesumeWritingLableX;
    static CGFloat fesumeWritingLableY;
    static CGFloat fesumeWritingLableWideth;
    static CGFloat fesumeWritingLableHeight;
    //玩出范btn
    static CGFloat PlayFanBtnX;
    static CGFloat PlayFanBtnY;
    static CGFloat PlayFanBtnWideth;
    static CGFloat PlayFanBtnHeight;
    //玩出范lab
    static CGFloat PlayFanLableX;
    static CGFloat PlayFanLableY;
    static CGFloat PlayFanLableWideth;
    static CGFloat PlayFanLableHeight;
    //wei社交btn
    static CGFloat MicroSocialBtnX;
    static CGFloat MicroSocialBtnY;
    static CGFloat MicroSocialBtnWideth;
    static CGFloat MicroSocialBtnHeight;
    //wei社交了lab
    static CGFloat MicroSocialLableX;
    static CGFloat MicroSocialLableY;
    static CGFloat MicroSocialLableWideth;
    static CGFloat MicroSocialLableHeight;
    //功开课btn
    static CGFloat openClassBtnX;
    static CGFloat openClassBtnY;
    static CGFloat openClassBtnWideth;
    static CGFloat openClassBtnHeight;
    //公开课lab
    static CGFloat openClassLableX;
    static CGFloat openClassLableY;
    static CGFloat openClassLableWideth;
    static CGFloat openClassLableHeight;

//        //宽高
//        wideth = 375;
//        height = 667;
        //找工作btn
        findjobBtnX = 25;
        findjobBtnY = 8;
        findjobBtnWideth = 45;
        findjobBtnHeight = 45;
        //找工作ab
        findjobLableX = 25;
        findjobLableY = 62;
        findjobLableWideth = 45;
        findjobLableHeight = 12;
        //找兼职btn
        FindPartTimeBtnX = 118.5;
        FindPartTimeBtnY = 8;
        FindPartTimeBtnWideth = 45;
        FindPartTimeBtnHeight = 45;
        //找兼职lab
        FindPartTimeLableX = 118.5;
        FindPartTimeLableY = 62;
        FindPartTimeLableWideth = 45;
        FindPartTimeLableHeight = 12;
        //找实习btn
        InternshipSearchBtnX = 213;
        InternshipSearchBtnY = 8;
        InternshipSearchBtnWideth = 45;
        InternshipSearchBtnHeight = 45;
        //找实习lab
        InternshipSearchLableX = 213;
        InternshipSearchLableY = 62;
        InternshipSearchLableWideth = 45;
        InternshipSearchLableHeight = 12;
        //信息台btn
        InformationDeskBtnX = 305;
        InformationDeskBtnY = 8;
        InformationDeskBtnWideth = 45;
        InformationDeskBtnHeight = 45;
        //信息台lab
        InformationDeskLableX = 305;
        InformationDeskLableY = 62;
        InformationDeskLableWideth = 45;
        InformationDeskLableHeight = 12;
        //写简历btn
        fesumeWritingBtnX = 26;
        fesumeWritingBtnY = 87;
        fesumeWritingBtnWideth = 45;
        fesumeWritingBtnHeight = 45;
        //写简历lab
        fesumeWritingLableX = 26;
        fesumeWritingLableY = 142;
        fesumeWritingLableWideth = 45;
        fesumeWritingLableHeight  = 12;
        //玩出范btn
        PlayFanBtnX = 118.5;
        PlayFanBtnY = 87;
        PlayFanBtnWideth = 45;
        PlayFanBtnHeight  = 45;
        //玩出范lab
        PlayFanLableX = 118.5;
        PlayFanLableY = 142;
        PlayFanLableWideth = 45;
        PlayFanLableHeight = 12;
        //wei社交btn
        MicroSocialBtnX = 212;
        MicroSocialBtnY = 87;
        MicroSocialBtnWideth = 45;
        MicroSocialBtnHeight = 45;
        //wei社交了lab
        MicroSocialLableX  = 212;
        MicroSocialLableY = 142;
        MicroSocialLableWideth = 45;
        MicroSocialLableHeight = 12;
        //功开课btn
        openClassBtnX = 305;
        openClassBtnY = 87;
        openClassBtnWideth = 45;
        openClassBtnHeight = 45;
        //公开课lab
        openClassLableX = 305;
        openClassLableY = 142;
        openClassLableWideth = 45;
        openClassLableHeight = 12;

    //找工作
    UIButton * findjobBtn = [[UIButton alloc] initWithFrame:CGRectMake(findjobBtnX*MyWideth, findjobBtnY*MyHeight, findjobBtnWideth*MyWideth , findjobBtnHeight*MyWideth)];
    findjobBtn.tag = THHomeViewButtonTypeFindJob;
    [findjobBtn setImage:[UIImage imageNamed:@"job"] forState:UIControlStateNormal];
    self.findjobBtn = findjobBtn;
    [findjobBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:findjobBtn];
    UILabel * findjobLable =[[UILabel alloc] initWithFrame:CGRectMake(findjobLableX*MyWideth, findjobLableY*MyHeight, findjobLableWideth*MyWideth, findjobLableHeight)];
    findjobLable.text = @"找工作";
    findjobLable.font = [UIFont systemFontOfSize:12];
    findjobLable.textColor = UIColorFromRGB(0x646464);
    findjobLable.textAlignment = NSTextAlignmentCenter;
    self.findjobLable = findjobLable;
    [self addSubview:findjobLable];
    //找兼职
    UIButton * FindPartTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(FindPartTimeBtnX*MyWideth, FindPartTimeBtnY*MyHeight, FindPartTimeBtnWideth*MyWideth, FindPartTimeBtnHeight*MyWideth)];
    FindPartTimeBtn.tag = THHomeViewButtonTypeFindPartTime;
    [FindPartTimeBtn setImage:[UIImage imageNamed:@"jianzhi"] forState:UIControlStateNormal];
    self.FindPartTimeBtn = FindPartTimeBtn;
    [FindPartTimeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:FindPartTimeBtn];
    UILabel * FindPartTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(FindPartTimeLableX*MyWideth, FindPartTimeLableY*MyHeight, FindPartTimeLableWideth*MyWideth, FindPartTimeLableHeight)];
    FindPartTimeLable.text = @"找兼职";
    FindPartTimeLable.textColor = UIColorFromRGB(0x646464);
    FindPartTimeLable.font = [UIFont systemFontOfSize:12];
    FindPartTimeLable.textAlignment = NSTextAlignmentCenter;
    self.FindPartTimeLable = FindPartTimeLable;
    [self addSubview:FindPartTimeLable];
    //找实习
    UIButton * InternshipSearchBtn =[[UIButton alloc] initWithFrame:CGRectMake(InternshipSearchBtnX*MyWideth, InternshipSearchBtnY*MyHeight, InformationDeskBtnWideth *MyWideth, InformationDeskBtnHeight*MyWideth)];
    [InternshipSearchBtn setImage:[UIImage imageNamed:@"shixi"] forState:UIControlStateNormal];
    InternshipSearchBtn.tag = THHomeViewButtonTypeInternshipSearch;
    self.InternshipSearchBtn = InternshipSearchBtn;
    [InternshipSearchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:InternshipSearchBtn];
    
    UILabel * InternshipSearchLable = [[UILabel alloc] initWithFrame:CGRectMake(InternshipSearchLableX*MyWideth, InternshipSearchLableY*MyHeight, InternshipSearchLableWideth*MyWideth, InternshipSearchLableHeight)];
    InternshipSearchLable.text = @"找实习";
    InternshipSearchLable.textColor = UIColorFromRGB(0x646464);
    InternshipSearchLable.font = [UIFont systemFontOfSize:12];
    InternshipSearchLable.textAlignment = NSTextAlignmentCenter;
    self.InternshipSearchLable = InternshipSearchLable;
    
    [self addSubview:InternshipSearchLable];
    //信息台
    UIButton * InformationDeskBtn = [[UIButton alloc] initWithFrame:CGRectMake(InformationDeskBtnX*MyWideth, InformationDeskBtnY*MyHeight, InformationDeskBtnWideth*MyWideth   , InformationDeskBtnHeight*MyWideth)];
    [InformationDeskBtn setImage:[UIImage imageNamed:@"xinxitai"] forState:UIControlStateNormal];
    self.InformationDeskBtn = InformationDeskBtn;
    InformationDeskBtn.tag = THHomeViewButtonTypeInformationDesk;
    [InformationDeskBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:InformationDeskBtn];
    UILabel * InformationDeskLable = [[UILabel alloc] initWithFrame:CGRectMake(InformationDeskLableX*MyWideth, InformationDeskLableY*MyHeight, InformationDeskLableWideth*MyWideth, InformationDeskLableHeight)];
    InformationDeskLable.text = @"信息台";
    InformationDeskLable.textColor = UIColorFromRGB(0x646464);

    InformationDeskLable.font =  [UIFont systemFontOfSize:12];
    InformationDeskLable.textAlignment = NSTextAlignmentCenter;
    self.InformationDeskLable = InformationDeskLable;
    [self addSubview:InformationDeskLable];
    
    //写简历
    UIButton * fesumeWritingBtn = [[UIButton alloc] initWithFrame:CGRectMake(fesumeWritingBtnX*MyWideth, fesumeWritingBtnY*MyHeight, fesumeWritingBtnWideth*MyWideth, fesumeWritingBtnHeight*MyWideth)];
    
    [fesumeWritingBtn setImage:[UIImage imageNamed:@"xiejianli"] forState:UIControlStateNormal];
    self.fesumeWritingBtn  = fesumeWritingBtn;
    fesumeWritingBtn.tag = THHomeViewButtonTypeResumeWriting;
    [fesumeWritingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:fesumeWritingBtn];
    UILabel * fesumeWritingLable = [[UILabel alloc] initWithFrame:CGRectMake(fesumeWritingLableX*MyWideth, fesumeWritingLableY*MyHeight, fesumeWritingLableWideth*MyWideth, fesumeWritingLableHeight)];
    fesumeWritingLable.text = @"写简历";
    fesumeWritingLable.textColor = UIColorFromRGB(0x646464);
    fesumeWritingLable.textAlignment = NSTextAlignmentCenter;
    fesumeWritingLable.font = [UIFont systemFontOfSize:12];
    self.fesumeWritingLable = fesumeWritingLable;
    [self addSubview:fesumeWritingLable];
    //玩出范
    UIButton * PlayFanBtn = [[UIButton alloc] initWithFrame:CGRectMake(PlayFanBtnX*MyWideth, PlayFanBtnY*MyHeight, PlayFanBtnWideth *MyWideth  , PlayFanBtnHeight*MyWideth)];
    [PlayFanBtn setImage:[UIImage imageNamed:@"wanchufan03"] forState:UIControlStateNormal];
    self.PlayFanBtn = PlayFanBtn;
    PlayFanBtn.tag = THHomeViewButtonTypePlayFan;
    [PlayFanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:PlayFanBtn];
    
    UILabel * PlayFanLable =[[UILabel alloc] initWithFrame:CGRectMake(PlayFanLableX*MyWideth, PlayFanLableY*MyHeight, PlayFanLableWideth*MyWideth, PlayFanLableHeight)];
    PlayFanLable.text = @"玩出范";
    PlayFanLable.textColor = UIColorFromRGB(0x646464);
    PlayFanLable.textAlignment = NSTextAlignmentCenter;
    
    PlayFanLable.font = [UIFont systemFontOfSize:12];
    self.PlayFanLable = PlayFanLable;
    [self addSubview:PlayFanLable];
    
   //微社交
    UIButton * MicroSocialBtn = [[UIButton alloc] initWithFrame:CGRectMake(MicroSocialBtnX*MyWideth, MicroSocialBtnY*MyHeight, MicroSocialBtnWideth*MyWideth, MicroSocialBtnHeight*MyWideth)];
    [MicroSocialBtn setImage:[UIImage imageNamed:@"weishejiao"] forState:UIControlStateNormal];
    self.MicroSocialBtn = MicroSocialBtn;
    MicroSocialBtn.tag = THHomeViewButtonTypeMicroSocial;
    [MicroSocialBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:MicroSocialBtn];
    UILabel * MicroSocialLable = [[UILabel alloc] initWithFrame:CGRectMake(MicroSocialLableX*MyWideth, MicroSocialLableY*MyHeight, MicroSocialLableWideth*MyWideth, MicroSocialLableHeight)];
    MicroSocialLable.text = @"微社交";
    MicroSocialLable.textColor = UIColorFromRGB(0x646464);
    MicroSocialLable.textAlignment= NSTextAlignmentCenter;
    MicroSocialLable.font = [UIFont systemFontOfSize:12];
    self.MicroSocialLable = MicroSocialLable;
    [self addSubview:MicroSocialLable];
    //公开课
    UIButton * openClassBtn = [[UIButton alloc] initWithFrame:CGRectMake(openClassBtnX*MyWideth, openClassBtnY*MyHeight, openClassBtnWideth*MyWideth, openClassBtnHeight*MyWideth)];
    [openClassBtn setImage:[UIImage imageNamed:@"gongkaike"] forState:UIControlStateNormal];
    self.openClassBtn = openClassBtn;
    openClassBtn.tag = THHomeViewButtonTypeOpenClass;
    [openClassBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:openClassBtn];
    UILabel * openClassLable = [[UILabel alloc] initWithFrame:CGRectMake(openClassLableX*MyWideth, openClassLableY*MyHeight, openClassLableWideth*MyWideth, openClassLableHeight)];
    openClassLable.text = @"公开课";
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
