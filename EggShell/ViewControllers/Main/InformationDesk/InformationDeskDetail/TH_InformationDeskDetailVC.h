//
//  TH_InformationDeskDetailVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "playFanModel.h"
#import "informantionModel.h"
@interface TH_InformationDeskDetailVC : TH_BaseVC
@property(nonatomic,strong)playFanModel * detaildic;
@property(nonatomic,strong)informantionModel * informodel;
@property(nonatomic,assign) int typeNum;
@property(nonatomic,assign) NSString * classId;
@end
