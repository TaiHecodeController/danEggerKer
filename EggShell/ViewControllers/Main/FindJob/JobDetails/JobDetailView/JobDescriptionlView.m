//
//  JobDescriptionlView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "JobDescriptionlView.h"

@implementation JobDescriptionlView
+(JobDescriptionlView*)setJobDescriptionView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"JobDescription" owner:self options:nil]
            lastObject];
}
@end
