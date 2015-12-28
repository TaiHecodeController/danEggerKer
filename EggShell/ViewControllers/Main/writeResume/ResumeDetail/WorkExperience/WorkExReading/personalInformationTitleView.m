//
//  personalInformationTitleView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/28.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "personalInformationTitleView.h"

@implementation personalInformationTitleView
+(personalInformationTitleView*)setpersonalInformationTitleView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"personalInformationTitleViews" owner:self options:nil] lastObject];
}

@end
