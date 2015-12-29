//
//  TH_ProjectExperienceVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

@interface TH_ProjectExperienceVC : TH_BaseVC

@property (nonatomic, copy) NSString *Projectexperience;
@property (nonatomic, copy) NSString *sdate;
@property (nonatomic, copy) NSString *edate;
@property (nonatomic, copy) NSString *projectEnvironmental;
@property (nonatomic, copy) NSString *postion;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *detailId;
//pushType 0添加进来 1编辑进来
@property (nonatomic, assign) int pushtype;

@end
