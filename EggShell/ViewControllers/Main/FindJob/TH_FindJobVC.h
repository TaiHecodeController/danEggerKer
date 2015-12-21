//
//  TH_FindJobVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

//static NSString const *  staticVar;

typedef enum
{
    
    tabBarType,
    homePushType
    
}pushType;

@interface TH_FindJobVC : TH_BaseVC

@property (nonatomic, copy) NSString *longtitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *edu;
@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *fbtime;
@property (nonatomic, copy) NSString *hy;
@property (nonatomic, copy) NSString *job1;
@property (nonatomic, copy) NSString *job1_son;
@property (nonatomic, copy) NSString *job_post;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *provinceid;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *three_cityid;
@property (nonatomic, copy) NSString *type;


@property(nonatomic,copy)NSString * jobId;

//工作性质 0 全职 1 兼职 2 实习
@property (nonatomic, copy) NSString *job_type;
@property (nonatomic) pushType rk_pushType;
@end
