//
//  findJobCarViewS.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/10.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "findJobModel.h"

@interface findJobCarViewS : UIView
@property (strong, nonatomic)  UIImageView *JobLogoImageView;
@property (strong, nonatomic)  UILabel *JobNameLable;
@property (strong, nonatomic)  UILabel *companyNnameLable;
@property (strong, nonatomic)  UILabel *salaryLable;
@property (strong, nonatomic)  UILabel *workYearLable;
@property (strong, nonatomic)  UILabel *educationalLable;
@property (strong, nonatomic)  UILabel *addressLable;
@property (strong, nonatomic)  UILabel *natureLable;
@property (strong, nonatomic)  UILabel *recruitmentLable;
@property (strong, nonatomic)  UILabel *genderLable;
@property (strong, nonatomic)  UILabel *marriageLable;
@property (strong, nonatomic)  UILabel *dutyLable;
@property(nonatomic,strong)UILabel * releaseLable;
@property(nonatomic,strong)UIView * bgView;
-(void)setValueCar:(findJobModel *)model;

@end
