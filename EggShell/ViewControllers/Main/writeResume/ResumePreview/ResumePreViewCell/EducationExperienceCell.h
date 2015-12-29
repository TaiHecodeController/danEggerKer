//
//  EducationExperienceCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationExperienceCell : UITableViewCell
@property(nonatomic,strong)UILabel  * educationTime;
@property(nonatomic,strong)UILabel  * department;
@property(nonatomic,strong)UILabel  * schoolName;
@property(nonatomic,strong)UILabel  * position;
@property(nonatomic,strong)UILabel  * departmentIntroduce;
-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i;

@end
