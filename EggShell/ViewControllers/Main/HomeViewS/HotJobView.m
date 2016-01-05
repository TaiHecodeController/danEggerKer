//
//  HotJobView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "HotJobView.h"

@implementation HotJobView
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
    titleLable.text = @"热门职位";
    titleLable.font = [UIFont systemFontOfSize:16];
    titleLable.textColor = UIColorFromRGB(0x323232);
    [self addSubview:titleLable];
    //第一lingeView
    UIView * firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, WIDETH, .5)];
    firstView.backgroundColor = UIColorFromRGB(0xE6E6E6);
    [self addSubview:firstView];
    //教育培训
    UIView * educationTraiBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, WIDETH/4.0, 80)];
    [self addSubview:educationTraiBGView];
    //分割线
    UIView * lineLevelView = [[UIView alloc] initWithFrame:CGRectMake(educationTraiBGView.frame.size.width -.5, 0, .5, educationTraiBGView.frame.size.height)];
    lineLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [educationTraiBGView addSubview:lineLevelView];
    UIView * lineVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, educationTraiBGView.frame.size.height - 0.5, educationTraiBGView.frame.size.width, 0.5)];
    lineVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [educationTraiBGView addSubview:lineVertailvie];
    UIButton * educationTrainBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDETH/4.0, 80)];
    [educationTrainBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.educationTrainBtn = educationTrainBtn;
    [educationTraiBGView addSubview:educationTrainBtn];
    UIImageView * bgsImageView  = [[UIImageView alloc] initWithFrame:CGRectMake((educationTraiBGView.frame.size.width-23)/2.0, 16, 23, 23)];
    bgsImageView.image = [UIImage imageNamed:@"jiaoyupeixun1"];
    [educationTraiBGView addSubview:bgsImageView];
    UILabel *educationTrainLable =[[UILabel alloc] initWithFrame:CGRectMake(0, 48,educationTraiBGView.frame.size.width, 13)];
    educationTrainLable.text = @"教育培训";
    educationTrainLable.textColor = UIColorFromRGB(0x646464);
    educationTrainLable.textAlignment = NSTextAlignmentCenter;
    educationTrainLable.font = [UIFont systemFontOfSize:13];
    [educationTraiBGView addSubview:educationTrainLable];
    //市场专员
    UIButton * marketingSpecialistBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH/4.0, 45, WIDETH/4.0, 40)];
    [marketingSpecialistBtn setTitle:@"市场专员" forState:UIControlStateNormal];
    [marketingSpecialistBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    marketingSpecialistBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [marketingSpecialistBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.marketingSpecialistBtn = marketingSpecialistBtn;
    [self addSubview:marketingSpecialistBtn];
    //分割线
    UIView * marketLevelView = [[UIView alloc] initWithFrame:CGRectMake(marketingSpecialistBtn.frame.size.width -.5, 0, .5, marketingSpecialistBtn.frame.size.height)];
    marketLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [marketingSpecialistBtn addSubview:marketLevelView];
    UIView * marketVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, marketingSpecialistBtn.frame.size.height - 0.5, marketingSpecialistBtn.frame.size.width, 0.5)];
   marketVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [marketingSpecialistBtn addSubview:marketVertailvie];
    //咨询销售
    UIButton * onsultingSaleBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*2, 45, WIDETH/4.0, 40)];
    [onsultingSaleBtn setTitle:@"咨询销售" forState:UIControlStateNormal];
    [onsultingSaleBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    onsultingSaleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [onsultingSaleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.onsultingSaleBtn = onsultingSaleBtn;
    [self addSubview:onsultingSaleBtn];
    //分割线
    UIView * onsultingLevelView = [[UIView alloc] initWithFrame:CGRectMake(onsultingSaleBtn.frame.size.width -.5, 0, .5, onsultingSaleBtn.frame.size.height)];
    onsultingLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [onsultingSaleBtn addSubview:onsultingLevelView];
    UIView * onsultingVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, onsultingSaleBtn.frame.size.height - 0.5, onsultingSaleBtn.frame.size.width, 0.5)];
    onsultingVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [onsultingSaleBtn addSubview:onsultingVertailvie];

    //培训讲师
    UIButton * trainTeacherBtn =[[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*3, 45, WIDETH/4.0, 40)];
    [trainTeacherBtn setTitle:@"培训讲师" forState:UIControlStateNormal];
    [trainTeacherBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    trainTeacherBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [trainTeacherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.trainTeacherBtn = trainTeacherBtn;
    [self addSubview:trainTeacherBtn];
    //分割线
    UIView * trainLevelView = [[UIView alloc] initWithFrame:CGRectMake(trainTeacherBtn.frame.size.width -.5, 0, .5, trainTeacherBtn.frame.size.height)];
    trainLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [trainTeacherBtn addSubview:trainLevelView];
    UIView * trainVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, trainTeacherBtn.frame.size.height - 0.5, trainTeacherBtn.frame.size.width, 0.5)];
    trainVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [trainTeacherBtn addSubview:trainVertailvie];
    //教学管理
    UIButton * teachManagerBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH/4.0, 85, WIDETH/4.0, 40)];
    [teachManagerBtn setTitle:@"教学管理" forState:UIControlStateNormal];
    [teachManagerBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    teachManagerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [teachManagerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.teachManagerBtn = teachManagerBtn;
    [self addSubview:teachManagerBtn];
    //分割线
    UIView * teachManagerLevelView = [[UIView alloc] initWithFrame:CGRectMake(teachManagerBtn.frame.size.width -.5, 0, .5, teachManagerBtn.frame.size.height)];
    teachManagerLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [teachManagerBtn addSubview:teachManagerLevelView];
    UIView * teachManagerVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, teachManagerBtn.frame.size.height - 0.5, teachManagerBtn.frame.size.width, 0.5)];
    teachManagerVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [teachManagerBtn addSubview:teachManagerVertailvie];
    //教质管理
    UIButton  *  teachqualitBtn =[[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*2, 85, WIDETH/4.0, 40)];
    [teachqualitBtn setTitle:@"教质管理" forState:UIControlStateNormal];
    [teachqualitBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    teachqualitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [teachqualitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.teachqualitBtn = teachqualitBtn;
    [self addSubview:teachqualitBtn];
    //分割线
    UIView * teachqualitLevelView = [[UIView alloc] initWithFrame:CGRectMake(teachqualitBtn.frame.size.width -.5, 0, .5, teachqualitBtn.frame.size.height)];
    teachqualitLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [teachqualitBtn addSubview:teachqualitLevelView];
    UIView * teachqualitVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, teachqualitBtn.frame.size.height - 0.5, teachqualitBtn.frame.size.width, 0.5)];
    teachqualitVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [teachqualitBtn addSubview:teachqualitVertailvie];

    //就业专员
    UIButton * employmentCommissionerBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*3, 85, WIDETH/4.0, 40)];
    [employmentCommissionerBtn setTitle:@"就业专员" forState:UIControlStateNormal];
    [employmentCommissionerBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    employmentCommissionerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [employmentCommissionerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.employmentCommissionerBtn = employmentCommissionerBtn;
    [self addSubview:employmentCommissionerBtn];
    //分割线
    UIView * employmentCommissionerLevelView = [[UIView alloc] initWithFrame:CGRectMake(employmentCommissionerBtn.frame.size.width -.5, 0, .5, employmentCommissionerBtn.frame.size.height)];
    employmentCommissionerLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [employmentCommissionerBtn addSubview:employmentCommissionerLevelView];
    UIView * employmentCommissionerVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, employmentCommissionerBtn.frame.size.height - 0.5, employmentCommissionerBtn.frame.size.width, 0.5)];
    employmentCommissionerVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [employmentCommissionerBtn addSubview:employmentCommissionerVertailvie];
    //综合类
    UIView * ComplexTraiBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 125, WIDETH/4.0, 80)];
    [self addSubview:ComplexTraiBGView];
    //分割线
    UIView * ComplexLevelView = [[UIView alloc] initWithFrame:CGRectMake(ComplexTraiBGView.frame.size.width -.5, 0, .5, ComplexTraiBGView.frame.size.height)];
    ComplexLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [ComplexTraiBGView addSubview:ComplexLevelView];
    UIView * ComplexVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, ComplexTraiBGView.frame.size.height - 0.5, ComplexTraiBGView.frame.size.width, 0.5)];
    ComplexVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [ComplexTraiBGView addSubview:ComplexVertailvie];
    UIButton * ComplexTrainBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDETH/4.0, 80)];
    [ComplexTrainBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.ComplexBtn = ComplexTrainBtn;
    [ComplexTraiBGView addSubview:ComplexTrainBtn];
    UIImageView * ComplexImageView  = [[UIImageView alloc] initWithFrame:CGRectMake((ComplexTraiBGView.frame.size.width - 26)/2.0, 16, 26, 24)];
    ComplexImageView.image = [UIImage imageNamed:@"wallet"];
    [ComplexTraiBGView addSubview:ComplexImageView];
    UILabel *ComplexTrainLable =[[UILabel alloc] initWithFrame:CGRectMake(0, 48, ComplexTraiBGView.frame.size.width, 13)];
    ComplexTrainLable.text = @"综合类";
    ComplexTrainLable.font =[UIFont systemFontOfSize:13];
    ComplexTrainLable.textColor = UIColorFromRGB(0x646464);
    ComplexTrainLable.textAlignment  = NSTextAlignmentCenter;
    [ComplexTraiBGView addSubview:ComplexTrainLable];

        //网站策划
    UIButton * sitePlanBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH/4.0, 125, WIDETH/4.0, 40)];
    [sitePlanBtn setTitle:@"互联网" forState:UIControlStateNormal];
    [sitePlanBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    sitePlanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [sitePlanBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sitePlanBtn = sitePlanBtn;
    [self addSubview:sitePlanBtn];
    //分割线
    UIView * sitePlanLevelView = [[UIView alloc] initWithFrame:CGRectMake(sitePlanBtn.frame.size.width -.5, 0, .5, sitePlanBtn.frame.size.height)];
    sitePlanLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [sitePlanBtn addSubview:sitePlanLevelView];
    UIView * sitePlanVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, sitePlanBtn.frame.size.height - 0.5, sitePlanBtn.frame.size.width, 0.5)];
    sitePlanVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [sitePlanBtn addSubview:sitePlanVertailvie];
    //网站编辑
    UIButton * websiteEditorBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0*2), 125, WIDETH/4.0, 40)];
    [websiteEditorBtn setTitle:@"金融证券" forState:UIControlStateNormal];
    [websiteEditorBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    websiteEditorBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [websiteEditorBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.websiteEditorBtn = websiteEditorBtn;
    [self addSubview:websiteEditorBtn];
    //分割线
    UIView * websiteEditLevelView = [[UIView alloc] initWithFrame:CGRectMake(websiteEditorBtn.frame.size.width -.5, 0, .5, websiteEditorBtn.frame.size.height)];
    websiteEditLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [websiteEditorBtn addSubview:websiteEditLevelView];
    UIView * websiteEditVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, websiteEditorBtn.frame.size.height - 0.5, websiteEditorBtn.frame.size.width, 0.5)];
    websiteEditVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [websiteEditorBtn addSubview:websiteEditVertailvie];
    //运营专员
    UIButton * operationsCommissionerBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*3, 125, WIDETH/4.0, 40)];
    [operationsCommissionerBtn setTitle:@"公关媒介" forState:UIControlStateNormal];
    [operationsCommissionerBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    operationsCommissionerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [operationsCommissionerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.operationsCommissionerBtn= operationsCommissionerBtn;
    [self addSubview:operationsCommissionerBtn];
    //分割线
    UIView * operationsCommisLevelView = [[UIView alloc] initWithFrame:CGRectMake(operationsCommissionerBtn.frame.size.width -.5, 0, .5, operationsCommissionerBtn.frame.size.height)];
    operationsCommisLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [operationsCommissionerBtn addSubview:operationsCommisLevelView];
    UIView * operationsCommisVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, operationsCommissionerBtn.frame.size.height - 0.5, operationsCommissionerBtn.frame.size.width, 0.5)];
    operationsCommisVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [operationsCommissionerBtn addSubview:operationsCommisVertailvie];
    //银行柜员
    UIButton * bankTellerBtn = [[UIButton alloc] initWithFrame:CGRectMake(WIDETH/4.0, 165, WIDETH/4.0, 40)];
    [bankTellerBtn setTitle:@"市场营销" forState:UIControlStateNormal];
    [bankTellerBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    bankTellerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [bankTellerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.bankTellerBtn = bankTellerBtn;
    [self addSubview:bankTellerBtn];
    //分割线
    UIView * bankTellerLevelView = [[UIView alloc] initWithFrame:CGRectMake(bankTellerBtn.frame.size.width -.5, 0, .5, bankTellerBtn.frame.size.height)];
    bankTellerLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [bankTellerBtn addSubview:bankTellerLevelView];
    UIView * bankTellerVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, bankTellerBtn.frame.size.height - 0.5, bankTellerBtn.frame.size.width, 0.5)];
    bankTellerVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [bankTellerBtn addSubview:bankTellerVertailvie];

    //会计
    UIButton *accountingBtn =[[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*2, 165, WIDETH/4.0, 40)];
    [accountingBtn setTitle:@"销售管理" forState:UIControlStateNormal];
    [accountingBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    accountingBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [accountingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.accountingBtn = accountingBtn;
    [self addSubview:accountingBtn];
    //分割线
    UIView * accountingLevelView = [[UIView alloc] initWithFrame:CGRectMake(accountingBtn.frame.size.width -.5, 0, .5, accountingBtn.frame.size.height)];
    accountingLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [accountingBtn addSubview:accountingLevelView];
    UIView * accountingVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, accountingBtn.frame.size.height - 0.5, accountingBtn.frame.size.width, 0.5)];
    accountingVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [accountingBtn addSubview:accountingVertailvie];
    //出那员
      UIButton *tellerBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH/4.0)*3, 165, WIDETH/4.0, 40)];
    [tellerBtn setTitle:@"人事管理" forState:UIControlStateNormal];
    [tellerBtn setTitleColor:UIColorFromRGB(0x646464) forState:UIControlStateNormal];
    tellerBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [tellerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.tellerBtn = tellerBtn;
    [self addSubview:tellerBtn];
    //分割线
    UIView * tellerLevelView = [[UIView alloc] initWithFrame:CGRectMake(tellerBtn.frame.size.width -.5, 0, .5, tellerBtn.frame.size.height)];
    tellerLevelView.backgroundColor = UIColorFromRGB(0XE6E6E6);
    [tellerBtn addSubview:tellerLevelView];
    UIView * tellerVertailvie = [[UIView alloc] initWithFrame:CGRectMake(0, tellerBtn.frame.size.height - 0.5, tellerBtn.frame.size.width, 0.5)];
    tellerVertailvie.backgroundColor =UIColorFromRGB(0XE6E6E6);
    [tellerBtn addSubview:tellerVertailvie];
}
-(void)setBtnTag
{
     self.educationTrainBtn.tag = HotJobViewButtonTypeeducationTrainBtn;
    self.marketingSpecialistBtn.tag = HotJobViewButtonTypemarketingSpecialistBtn;
    self.onsultingSaleBtn.tag =  HotJobViewButtonTypeonsultingSaleBtn;
    self.trainTeacherBtn.tag = HotJobViewButtonTypetrainTeacherBtn;
    self.teachManagerBtn.tag = HotJobViewButtonTypeteachManagerBtn;
    self.teachqualitBtn.tag = HotJobViewButtonTypeteachqualitBtn;
    self.employmentCommissionerBtn.tag = HotJobViewButtonTypeemploymentCommissionerBtn;
    self.ComplexBtn.tag = HotJobViewButtonTypeComplexBtn;
    self.sitePlanBtn.tag = HotJobViewButtonTypesitePlanBtn;
    self.websiteEditorBtn.tag = HotJobViewButtonTypewebsiteEditorBtn;
    self.operationsCommissionerBtn.tag = HotJobViewButtonTypeoperationsCommissionerBtn;
    self.bankTellerBtn.tag = HotJobViewButtonTypebankTellerBtn;
    self.accountingBtn.tag = HotJobViewButtonTypeaccountingBtn;
    self.tellerBtn.tag = HotJobViewButtonTypetellerBtn;
}
-(void)btnClick:(UIButton*)sender
{
    
    if ([self.HotJobViewDelegate respondsToSelector:@selector(HotJobViewJob:DidClickButton:)]) {

        [self.HotJobViewDelegate HotJobViewJob:self DidClickButton:(HotJobViewButtonType)sender.tag];
    }

}
@end
