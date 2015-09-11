
//
//  professionalSkillView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "professionalSkillView.h"

@implementation professionalSkillView

+(professionalSkillView*)setprofessionalSkillView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"professional" owner:self options:nil] lastObject];
}
-(void)conFigValue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
//    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary * dataDic  = dataArray[i];
    if(dataDic.count == 0)
    {
        return;
    }
    self.professionalSkill.text = dataDic[@"skill"];
    self.graspTime.text = dataDic[@"longtime"];
    self.skilledDegree.text = dataDic[@"ing"];
    self.skillName.text = dataDic[@"name"];
    if (i == 0)
    {
        _titleLab.text = @"专业技能";
    }
   

}
@end
