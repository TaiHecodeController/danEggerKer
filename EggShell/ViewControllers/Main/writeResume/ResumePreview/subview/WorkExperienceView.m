//
//  WorkExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkExperienceView.h"

@implementation WorkExperienceView

+(WorkExperienceView*)setWorkExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"workExperecie" owner:self options:nil] lastObject];
}
-(void)configVulue:(NSString *)model
{

    self.workTime.text = model;
    self.position.text = model;
    self.workContent.text = model;
}
@end
