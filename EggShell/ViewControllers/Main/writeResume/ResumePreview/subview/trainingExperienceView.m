//
//  trainingExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "trainingExperienceView.h"

@implementation trainingExperienceView
+(trainingExperienceView*)settrainingExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"train" owner:self options:nil] lastObject];
}
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
    
//    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary * dataDic = dataArray[i];
    if(dataDic.count == 0)
    {
        return;
    }
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.trainTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    
    self.trainDirection.text = dataDic[@"title"];
    self.trainCompany.text = dataDic[@"name"];
    self.trainIntroduce.text = dataDic[@"content"];
    if (i == 0)
    {
        _titleLab.text = @"培训内容";
        _titleLab.textColor = [UIColor redColor];
    }

}
@end
