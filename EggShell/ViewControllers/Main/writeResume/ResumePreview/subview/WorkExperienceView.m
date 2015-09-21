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

-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
//    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary *dataDic = dataArray[i];
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.workTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    if (i == 0)
    {
       _titleLab.text = @"工作经历";
    }
     self.position.text = dataDic[@"title"];
    self.workContent.text = dataDic[@"content"];
    self.CompanyNameLable.text = dataDic[@"name"];
}
@end
