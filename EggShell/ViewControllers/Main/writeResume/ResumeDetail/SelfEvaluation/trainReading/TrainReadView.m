//
//  TrainReadView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TrainReadView.h"

@implementation TrainReadView

+(TrainReadView*)settrinView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"trainRead" owner:self options:nil] lastObject];
}

@end
