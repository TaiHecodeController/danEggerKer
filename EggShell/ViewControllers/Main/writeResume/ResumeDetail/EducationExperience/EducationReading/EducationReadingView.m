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

-(void)config:(NSDictionary *)dic
{
    self.nameLab.text = dic[@"name"];
    self.timeLab.text = [dic[@"sdate"] stringByAppendingFormat:@"-%@",dic[@"edate"]];
    self.dapartmentLab.text = dic[@"specialty"];
    self.positionLab.text = dic[@"title"];
    self.contentTextView.text = dic[@"content"];
}
@end
