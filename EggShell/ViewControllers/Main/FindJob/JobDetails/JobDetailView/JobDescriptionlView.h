//
//  JobDescriptionlView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobDescriptionlView : UIView

@property (weak, nonatomic) IBOutlet UILabel *postionName;
@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *publicTime;
@property (weak, nonatomic) IBOutlet UILabel *availTime;
@property (weak, nonatomic) IBOutlet UILabel *exprienceTime;
@property (weak, nonatomic) IBOutlet UILabel *RecruitmentNum;
@property (weak, nonatomic) IBOutlet UILabel *workNature;
@property (weak, nonatomic) IBOutlet UILabel *workPlace;
@property (weak, nonatomic) IBOutlet UILabel *knowledge;
@property (weak, nonatomic) IBOutlet UILabel *salary;
@property (weak, nonatomic) IBOutlet UITextView *jobDescriptionTextView;

+(JobDescriptionlView*)setJobDescriptionView;
@end
