
//
//  EducationExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "EducationExperienceView.h"

@implementation EducationExperienceView
+(EducationExperienceView*)setEducationExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"education" owner:self options:nil]lastObject];
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
    self.educationTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    self.department.text = dataDic[@"specialty"];
    self.schoolName.text = dataDic[@"name"];
    self.position.text = dataDic[@"title"];
    self.departmentIntroduce.text = dataDic[@"content"];
}
@end
