
//
//  ProfessonSkillReadView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProfessonSkillReadView.h"

@implementation ProfessonSkillReadView

+(ProfessonSkillReadView*)setProfessonSkillReadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ProfessonSkillRead" owner:self options:nil] lastObject];
}

-(void)configValue:(WriteRusumeModel2*)model
{
    self.SkillNameLable.text = model.name;
    self.SkillTypeLable.text = model.skillType;
    self.ProficiencyLable.text = model.skillDegree;
    self.MasterTimeLable.text = model.skillTime;


}


@end
