//
//  findJobCarViewS.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/10.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "findJobCarViewS.h"

@implementation findJobCarViewS
-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
    //职位图片
    self.JobLogoImageView  =[[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 100*MyWideth)/2.0, 30*MyWideth, 100*MyWideth, 90*MyWideth)];
    self.JobLogoImageView.image = [UIImage imageNamed:@"tu"];
    [self addSubview:self.JobLogoImageView];
    //职位
    self.JobNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*MyWideth+90*MyWideth+15*MyWideth, self.frame.size.width, 19)];
    self.JobNameLable.text = @"大数据分析";
    self.JobNameLable.font =[UIFont systemFontOfSize:19];
    self.JobNameLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.JobNameLable];
    //公司名称
    self.companyNnameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 35*MyWideth+90*MyWideth+15*MyWideth+10*MyWideth+19, self.frame.size.width, 16)];
    self.companyNnameLable.text = @"苏宁消费金融公司";
    self.companyNnameLable.textAlignment = NSTextAlignmentCenter;
    self.companyNnameLable.textColor = UIColorFromRGB(0x646464);
    [self addSubview:self.companyNnameLable];
    UIView * bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 45*MyWideth+90*MyWideth+15*MyWideth+10*MyWideth+19+20*MyWideth, self.frame.size.width, 90*MyWideth)];
    [self addSubview:bgView];
    
    UIView * topView =[[UIView alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width-30, 1.5)];
    topView.backgroundColor = UIColorFromRGB(0xE3E3E3);
    [bgView addSubview:topView];
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(15, bgView.frame.size.height-1.5, self.frame.size.width - 30, 1.5)];
    bottomView.backgroundColor = UIColorFromRGB(0xE3E3E3);
    [bgView addSubview:bottomView];
    
    for (int i =0; i < 4; i++) {
        UIView * detailView =[[UIView alloc] initWithFrame:CGRectMake(15*MyWideth+((self.frame.size.width-30*MyWideth)/4.0)*i, 0, (self.frame.size.width-30*MyWideth)/4.0, 90*MyWideth)];
        [bgView addSubview:detailView];
        
        if (i==0) {
            
            UIImageView * firstView =[[UIImageView alloc] initWithFrame:CGRectMake(((self.frame.size.width-15*MyWideth)/4.0 -30*MyWideth)/2.0, 22*MyWideth, 15*MyWideth, 22*MyWideth)];
            firstView.image = [UIImage imageNamed:@"工资"];
            [detailView addSubview:firstView];
            //薪水
            self.salaryLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 22*MyWideth+22*MyWideth+14*MyWideth, (self.frame.size.width-30*MyWideth)/4.0, 15*MyWideth)];
            self.salaryLable.text = @"10-15k";
            self.salaryLable.textAlignment = NSTextAlignmentCenter;
            self.salaryLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.salaryLable.textColor = UIColorFromRGB(0xF44336);
            [detailView addSubview:self.salaryLable];
            
            UIView * lineViw =[[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-30*MyWideth)/4.0-0.5, 20*MyWideth,0.5, detailView.frame.size.height - 40*MyWideth)];
            lineViw.backgroundColor = UIColorFromRGB(0xE3E3E3);
            [detailView addSubview:lineViw];
        }
        if (i==1) {
            
            UIImageView * secondView =[[UIImageView alloc] initWithFrame:CGRectMake(((self.frame.size.width-17*MyWideth)/4.0 -30*MyWideth)/2.0, 22*MyWideth, 17*MyWideth, 22*MyWideth)];
            secondView.image = [UIImage imageNamed:@"经验"];
            [detailView addSubview:secondView];
            //薪水
            self.workYearLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 22*MyWideth+22*MyWideth+14*MyWideth, (self.frame.size.width-30*MyWideth)/4.0, 15*MyWideth)];
            self.workYearLable.text = @"10年以上";
            self.workYearLable.textAlignment = NSTextAlignmentCenter;
            self.workYearLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.workYearLable.textColor = UIColorFromRGB(0x646464);
            [detailView addSubview:self.workYearLable];
            
            UIView * secondViw =[[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-30*MyWideth)/4.0-0.5, 20*MyWideth,0.5, detailView.frame.size.height - 40*MyWideth)];
            secondViw.backgroundColor = UIColorFromRGB(0xE3E3E3);
            [detailView addSubview:secondViw];
        }
        if (i==2) {
            
            UIImageView * threeView =[[UIImageView alloc] initWithFrame:CGRectMake(((self.frame.size.width-22*MyWideth)/4.0 -30*MyWideth)/2.0, 22*MyWideth,22*MyWideth, 22*MyWideth)];
            threeView.image = [UIImage imageNamed:@"学历"];
            [detailView addSubview:threeView];
            //薪水
            self.educationalLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 22*MyWideth+22*MyWideth+14*MyWideth, (self.frame.size.width-30*MyWideth)/4.0, 15*MyWideth)];
            self.educationalLable.text = @"本科";
            self.educationalLable.textAlignment = NSTextAlignmentCenter;
            self.educationalLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.educationalLable.textColor = UIColorFromRGB(0x646464);
            [detailView addSubview:self.educationalLable];
            
            UIView * threeViw =[[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-30*MyWideth)/4.0-0.5, 20*MyWideth,0.5, detailView.frame.size.height - 40*MyWideth)];
            threeViw.backgroundColor = UIColorFromRGB(0xE3E3E3);
            [detailView addSubview:threeViw];
        }
        
        if (i==3) {
            
            UIImageView * fourthView =[[UIImageView alloc] initWithFrame:CGRectMake(((self.frame.size.width-16.5*MyWideth)/4.0 -30*MyWideth)/2.0, 22*MyWideth, 16.5*MyWideth, 22*MyWideth)];
            fourthView.image = [UIImage imageNamed:@"地址"];
            [detailView addSubview:fourthView];
            //工作年限
            self.addressLable= [[UILabel alloc] initWithFrame:CGRectMake(0, 22*MyWideth+22*MyWideth+14*MyWideth, (self.frame.size.width-30*MyWideth)/4.0, 15*MyWideth)];
            self.addressLable.text = @"北京";
            self.addressLable.textAlignment = NSTextAlignmentCenter;
            self.addressLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.addressLable.textColor = UIColorFromRGB(0x646464);
            [detailView addSubview:self.addressLable];
            
            UIView * fourthViw =[[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-30*MyWideth)/4.0-0.5, 20*MyWideth,0.5, detailView.frame.size.height - 40*MyWideth)];
            fourthViw.backgroundColor = UIColorFromRGB(0xE3E3E3);
            [detailView addSubview:fourthViw];
        }
        
        
    }
    
    NSArray * titleArray = @[@"性质:",@"招聘:",@"性别:",@"婚姻:",@"到岗:"];
    for (int i =0; i < 5; i++) {
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(15*MyWideth+85*MyWideth*(i%3)+((self.frame.size.width - 30*MyWideth-85*MyWideth*3)/2.0)*(i%3), (45*MyWideth+90*MyWideth+15*MyWideth+10*MyWideth+19+20*MyWideth+90*MyWideth+15*MyWideth)+27*MyWideth*(i/3)+10*MyWideth*(i/3), 85*MyWideth, 27*MyWideth)];
        [self addSubview:bgView];
        bgView.backgroundColor = UIColorFromRGB(0xF0F8FA);
        UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 27)];
        titleLable.text = titleArray[i];
        titleLable.font =[UIFont systemFontOfSize:15*MyWideth];
        titleLable.textColor = UIColorFromRGB(0x646464);
        [bgView addSubview:titleLable];
        if (i==0) {
            //性质
            self.natureLable =[[UILabel alloc] initWithFrame:CGRectMake(40*MyWideth, 0, 45*MyWideth, 27*MyWideth)];
            self.natureLable.text = @"全职";
            self.natureLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.natureLable.textColor = UIColorFromRGB(0x646464);
            [bgView addSubview:self.natureLable];
        }
        if (i==1) {
            //招聘
            self.recruitmentLable =[[UILabel alloc] initWithFrame:CGRectMake(40*MyWideth, 0, 45*MyWideth, 27*MyWideth)];
            self.recruitmentLable.text = @"若干";
            self.recruitmentLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.recruitmentLable.textColor = UIColorFromRGB(0x646464);
            [bgView addSubview:self.recruitmentLable];
        }
        if (i==2) {
            //性别
            self.genderLable =[[UILabel alloc] initWithFrame:CGRectMake(40*MyWideth, 0, 45*MyWideth, 27*MyWideth)];
            self.genderLable.text = @"男";
            self.genderLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.genderLable.textColor = UIColorFromRGB(0x646464);
            [bgView addSubview:self.genderLable];
        }
        if (i==3) {
            //婚姻
            self.marriageLable =[[UILabel alloc] initWithFrame:CGRectMake(40*MyWideth, 0, 45*MyWideth, 27*MyWideth)];
            self.marriageLable.text = @"已婚";
            self.marriageLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.marriageLable.textColor = UIColorFromRGB(0x646464);
            [bgView addSubview:self.marriageLable];
        }
        if (i==4) {
            //到岗
            self.dutyLable =[[UILabel alloc] initWithFrame:CGRectMake(40*MyWideth, 0, 45*MyWideth, 27*MyWideth)];
            self.dutyLable.text = @"立即";
            self.dutyLable.font =[UIFont systemFontOfSize:15*MyWideth];
            self.dutyLable.textColor = UIColorFromRGB(0x646464);
            [bgView addSubview:self.dutyLable];
        }
    }
    
}
-(void)setValueCar:(findJobModel *)model
{
    //职位图片
    [self.JobLogoImageView sd_setImageWithURL:[NSURL URLWithString:model.com_logo] placeholderImage:[UIImage  imageNamed:@"tu"]];
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
