//
//  EducationReadVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/4.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "WriteRusumeModel2.h"

@interface EducationReadVC : TH_BaseVC

@property (strong,nonatomic)WriteRusumeModel2 * model;
@property (nonatomic, copy) NSString *resumeId;

@end
