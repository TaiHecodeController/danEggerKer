//
//  ProjectExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProjectExperienceView.h"

@implementation ProjectExperienceView

+(ProjectExperienceView*)setProjectExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"project" owner:self options:nil]lastObject];
}
-(void)configValue:(NSString*)model
{
   
    self.projectTime.text = model;
    self.position.text = model;
    self.proName.text = model;
    self.proIntroduce.text = model;
}
@end
