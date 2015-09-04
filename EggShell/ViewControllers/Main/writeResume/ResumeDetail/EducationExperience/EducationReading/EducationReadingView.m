//
//  EducationReadingView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "EducationReadingView.h"

@implementation EducationReadingView

+(EducationReadingView*)setView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"EducationReading" owner:self options:nil] lastObject];
}

-(void)config:(WriteRusumeModel2 *)model
{
    self.nameLab.text = model.name;
    self.timeLab.text = [model.sdate stringByAppendingFormat:@"-%@",model.edate];
    self.dapartmentLab.text = model.department;
    self.positionLab.text = model.position;
    self.contentTextView.text = model.content;
}
@end
