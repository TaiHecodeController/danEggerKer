//
//  ProjectExpReadView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProjectExpReadView.h"

@implementation ProjectExpReadView

+(ProjectExpReadView*)setProjectExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProjectExperience" owner:self options:nil] lastObject];
}
-(void)configValue:(WriteRusumeModel2*)model
{
    self.projectNameLable.text = model.name;
    self.SchoolTimeLable.text = [model.sdate stringByAppendingFormat:@"-%@",model.edate];
    self.ProjectEnvironmentLable.text = model.projectPath;
    self.holdOfficeLable .text = model.position;
    self.ProjectContentLable.text = model.content;
}
@end