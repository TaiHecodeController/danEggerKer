//
//  TH_FindJobVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

//static NSString const *  staticVar;

@interface TH_FindJobVC : TH_BaseVC
@property(nonatomic,copy)NSString * jobId;

//工作性质 0 全职 1 兼职 2 实习
@property (nonatomic, copy) NSString *job_type;
@end
