//
//  EducationExperienceView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationExperienceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *educationTime;
@property (weak, nonatomic) IBOutlet UILabel *department;
@property (weak, nonatomic) IBOutlet UILabel *schoolName;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *departmentIntroduce;
+(EducationExperienceView*)setEducationExperienceView;
@end
