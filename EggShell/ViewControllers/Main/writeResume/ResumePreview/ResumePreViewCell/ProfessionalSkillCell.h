//
//  ProfessionalSkillCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfessionalSkillCell : UITableViewCell
@property(nonatomic,strong)UILabel * professionalSkill;
@property(nonatomic,strong)UILabel * graspTime;
@property(nonatomic,strong)UILabel * skilledDegree;
@property(nonatomic,strong)UILabel * skillName;
-(void)conFigValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
