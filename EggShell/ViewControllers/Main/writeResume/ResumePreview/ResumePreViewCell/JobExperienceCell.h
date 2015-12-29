//
//  JobExperienceCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobExperienceCell : UITableViewCell
@property(nonatomic,strong)UILabel *  workTime;
@property(nonatomic,strong)UILabel *  position;
@property(nonatomic,strong)UILabel *  titleLab;
@property(nonatomic,strong)UILabel *   workContent;
-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i;
@end
