
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
-(void)conFigValue:(NSArray *)dataArray
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
    self.professionalSkill.text = dataDic[@"skill"];
    self.graspTime.text = dataDic[@"longtime"];
    self.skilledDegree.text = dataDic[@"ing"];
    self.skillName.text = dataDic[@"name"];
   

}
@end
