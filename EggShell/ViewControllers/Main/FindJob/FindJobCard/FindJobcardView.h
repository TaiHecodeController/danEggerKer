//
//  FindJobcardView.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/8.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "findJobModel.h"

@interface FindJobcardView : UIView
+(FindJobcardView*)setFindJobcardView;

@property (weak, nonatomic) IBOutlet UIImageView *JobLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *JobNameLable;
@property (weak, nonatomic) IBOutlet UILabel *companyNnameLable;
@property (weak, nonatomic) IBOutlet UILabel *salaryLable;
@property (weak, nonatomic) IBOutlet UILabel *workYearLable;
@property (weak, nonatomic) IBOutlet UILabel *educationalLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *natureLable;
@property (weak, nonatomic) IBOutlet UILabel *recruitmentLable;
@property (weak, nonatomic) IBOutlet UILabel *genderLable;
@property (weak, nonatomic) IBOutlet UILabel *marriageLable;
@property (weak, nonatomic) IBOutlet UILabel *dutyLable;
-(void)setValues:(findJobModel *)model;
@end
