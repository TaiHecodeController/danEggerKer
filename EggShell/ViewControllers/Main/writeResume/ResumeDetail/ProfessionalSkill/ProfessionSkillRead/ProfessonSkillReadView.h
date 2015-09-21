//
//  ProfessonSkillReadView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteRusumeModel2.h"

@interface ProfessonSkillReadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *bixuanxiang;

@property (weak, nonatomic) IBOutlet UILabel *resumTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *SkillNameLable;
@property (weak, nonatomic) IBOutlet UILabel *SkillTypeLable;
@property (weak, nonatomic) IBOutlet UILabel *ProficiencyLable;
@property (weak, nonatomic) IBOutlet UILabel *MasterTimeLable;
+(ProfessonSkillReadView*)setProfessonSkillReadView;
-(void)configValue:(WriteRusumeModel2*)model;
@end
