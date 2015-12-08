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
-(void)setValues:(NSDictionary*)dic
{
    //职位图片
    [self.JobLogoImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage  imageNamed:@""]];
    //职位
    self.JobNameLable.text = @"";
    //公司名称
    self.companyNnameLable.text = @"";
    //薪水
    self.salaryLable.text = @"";
    //工作年限
    self.workYearLable.text = @"";
    //学历
    self.educationalLable.text = @"";
    //地点
    self.addressLable.text = @"";
    //性质
    self.natureLable.text = @"";
    //招聘
    self.recruitmentLable.text = @"";
    //性别
    self.genderLable.text = @"";
    //婚姻
    self.marriageLable.text = @"";
    //到岗
    self.dutyLable.text = @"";
}
@end
