//
//  intentView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "intentView.h"

@implementation intentView

+(intentView*)setIntentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"intentView" owner:self options:nil] lastObject];
}

@end
