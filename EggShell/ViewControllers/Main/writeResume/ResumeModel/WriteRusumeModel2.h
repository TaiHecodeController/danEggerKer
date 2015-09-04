//
//  WorkExperienceModel.h
//  EggShell
//
//  Created by mac on 15/9/3.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriteRusumeModel2 : NSObject
@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)NSString * sdate;
@property (nonatomic,strong)NSString * edate;
@property (nonatomic,strong)NSString * department;
@property (nonatomic,strong)NSString * title;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,strong)NSString * position;
//专业技能属性
@property (nonatomic,strong)NSString * skillType;
@property (nonatomic,strong)NSString * skillDegree;
@property (nonatomic,strong)NSString * skillTime;
//项目属性

@property (nonatomic,strong)NSString * projectPath;
@end
