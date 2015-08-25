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

@end
