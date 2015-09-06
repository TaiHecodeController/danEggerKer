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
-(void)configValue:(NSArray *)dataArray
{
    if(dataArray.count == 0)
    {
        return;
    }
    NSDictionary * dataDic = [dataArray firstObject];
    self.trainTime.text = dataDic[@""];
    self.trainDirection.text = dataDic[@""];
    self.trainCompany.text = dataDic[@""];
    self.trainIntroduce.text = dataDic[@""];

}
@end
