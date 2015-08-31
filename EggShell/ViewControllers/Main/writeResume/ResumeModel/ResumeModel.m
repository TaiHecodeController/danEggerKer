//
//  ResumeModel.m
//  EggShell
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ResumeModel.h"

@implementation ResumeModel

+(instancetype)sharedResume
{
    static dispatch_once_t onceToken;
    static ResumeModel * model = nil;
    dispatch_once(&onceToken, ^{
        model = [[ResumeModel alloc] init];
    });
    return model;
}

@end
