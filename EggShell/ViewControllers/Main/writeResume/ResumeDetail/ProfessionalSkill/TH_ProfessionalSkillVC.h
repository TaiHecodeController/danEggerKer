//
//  TH_ProfessionalSkillVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

@interface TH_ProfessionalSkillVC : TH_BaseVC

@property (strong,nonatomic)NSDictionary * dataDic;
@property(assign)BOOL isSelect;

@property (nonatomic, copy) NSString *skillName;
@property (nonatomic, copy) NSString *skillType;
@property (nonatomic, copy) NSString *skillDegree;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *detailId;
@property (nonatomic, copy) NSString *resumId;
@property (nonatomic, copy) NSString *skillId;
@property (nonatomic, copy) NSString *ingId;
//pushType 0添加进来 1编辑进来
@property (nonatomic, assign) int pushtype;

@end
