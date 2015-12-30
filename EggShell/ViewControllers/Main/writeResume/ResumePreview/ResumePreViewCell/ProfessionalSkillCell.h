//
//  ProfessionalSkillCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditdelegateView.h"
@interface ProfessionalSkillCell : UITableViewCell
@property(nonatomic,strong)UILabel * professionalSkill;
@property(nonatomic,strong)UILabel * graspTime;
@property(nonatomic,strong)UILabel * skilledDegrees;
@property(nonatomic,strong)UILabel * skillName;

@property(nonatomic,strong)EditdelegateView * editDeleteView;
-(void)conFigValue:(NSDictionary *)dataDic;
@property(nonatomic,strong)void(^editDeleteBlock)(int sender,int row);
@end
