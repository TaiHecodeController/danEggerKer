//
//  FindJobcardView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/8.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "FindJobcardView.h"

@implementation FindJobcardView
+(FindJobcardView*)setFindJobcardView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FindJobcardViews" owner:self options:nil] lastObject];
}

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

}
-(void)setValues:(findJobModel *)model
{
    //职位图片
    [self.JobLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.com_logo] placeholderImage:[UIImage  imageNamed:@""]];
    //职位
    self.JobNameLable.text = model.job_name;
    //公司名称
    self.companyNnameLable.text = model.com_name;
    //薪水
    self.salaryLable.text = model.salary;
    //工作年限
    self.workYearLable.text = model.exp;
    //学历
    self.educationalLable.text = model.edu;
    //地点
    self.addressLable.text = model.provinceid;
    //性质
    self.natureLable.text = model.type;
    //招聘
    self.recruitmentLable.text = model.number;
    //性别
    self.genderLable.text = model.sex;
    //婚姻
    self.marriageLable.text = model.marriage;
    //到岗
    self.dutyLable.text = model.report;
}
@end
