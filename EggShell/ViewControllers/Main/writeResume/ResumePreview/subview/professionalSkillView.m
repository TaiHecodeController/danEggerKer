
//
//  professionalSkillView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "professionalSkillView.h"

@implementation professionalSkillView

+(professionalSkillView*)setprofessionalSkillView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"professional" owner:self options:nil] lastObject];
}
@end
