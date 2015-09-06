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
-(void)configVulue:(NSArray *)dataArray
{
    if(dataArray.count == 0)
    {
        return;
    }
    NSDictionary * dataDic = [dataArray firstObject];
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.workTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    self.position.text = dataDic[@"title"];
    self.workContent.text = dataDic[@"content"];
}
@end
