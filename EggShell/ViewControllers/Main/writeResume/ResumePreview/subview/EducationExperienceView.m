
//
//  EducationExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "EducationExperienceView.h"

@implementation EducationExperienceView
+(EducationExperienceView*)setEducationExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"education" owner:self options:nil]lastObject];
}
-(void)configVulue:(NSString*)model
{
   
    
    self.educationTime.text = model;
    self.department.text = model;
    self.schoolName.text = model;
    self.position.text = model;
    self.departmentIntroduce.text = model;
}
@end
