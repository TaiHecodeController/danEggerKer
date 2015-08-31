//
//  ResumeModel.h
//  EggShell
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeModel : NSObject
@property (strong,nonatomic)NSString * resumeName;
@property (strong,nonatomic)NSString * industry;
@property (strong,nonatomic)NSString * exceptJob;
@property (strong,nonatomic)NSString * exceptSalary;
@property (strong,nonatomic)NSString * exceptCity;
@property (strong,nonatomic)NSString * jobNature;
@property (strong,nonatomic)NSString * arriveTime;
@property (strong,nonatomic)NSString * findState;
@property (strong,nonatomic)NSString * userName;
@property (strong,nonatomic)NSString * sex;
@property (strong,nonatomic)NSString * userBirthday;
@property (strong,nonatomic)NSString * academic;
@property (strong,nonatomic)NSString * workExperience;
@property (strong,nonatomic)NSString * phoneNum;
@property (strong,nonatomic)NSString * email;
@property (strong,nonatomic)NSString * address;
+(instancetype)sharedResume;

@end
