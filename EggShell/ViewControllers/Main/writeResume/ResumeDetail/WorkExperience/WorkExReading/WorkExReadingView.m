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

-(void)config:(NSDictionary *)dic
{
    self.companyNameLable.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
    self.HoldTimelable.text = [dic[@"sdate"] stringByAppendingFormat:@"-%@",dic[@"edate"]];
    self.DepartmentLable.text = dic[@"department"];
    self.descriptionTextView.text = dic[@"content"];
    self.OfficeLable.text = dic[@"title"];
    
}
@end
