//
//  WorkExReadingView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WorkExReadingView.h"

@implementation WorkExReadingView

+(WorkExReadingView*)setView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WorkExReading" owner:self options:nil] lastObject];
}

-(void)config:(WriteRusumeModel2 *)model
{
    self.companyNameLable.text = model.name;
    self.HoldTimelable.text = [model.sdate stringByAppendingFormat:@"-%@",model.edate];
    self.DepartmentLable.text = model.department;
    self.descriptionTextView.text = model.content;
    self.OfficeLable.text = model.position;
    self.OfficeLable.text = model.title;
}
@end
