//
//  professionalSkillView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface professionalSkillView : UIView
@property (weak, nonatomic) IBOutlet UILabel *professionalSkill;
@property (weak, nonatomic) IBOutlet UILabel *graspTime;
@property (weak, nonatomic) IBOutlet UILabel *skilledDegree;
@property (weak, nonatomic) IBOutlet UILabel *skillName;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+(professionalSkillView*)setprofessionalSkillView;
-(void)conFigValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
