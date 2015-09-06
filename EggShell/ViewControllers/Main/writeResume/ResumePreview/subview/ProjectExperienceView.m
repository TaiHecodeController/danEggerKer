//
//  ProjectExperienceView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ProjectExperienceView.h"

@implementation ProjectExperienceView

+(ProjectExperienceView*)setProjectExperienceView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"project" owner:self options:nil]lastObject];
}
-(void)configValue:(NSArray *)dataArray
{
   if(dataArray.count == 0)
   {
       return;
   }
   
    NSDictionary * dataDic = [dataArray firstObject];
    if(dataDic.count == 0)
    {
        return;
    }
    self.projectTime.text = dataDic[@""];
    self.position.text = dataDic[@""];
    self.proName.text = dataDic[@""];
    self.proIntroduce.text = dataDic[@""];
}
@end
