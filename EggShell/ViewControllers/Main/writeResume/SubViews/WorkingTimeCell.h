//
//  WorkingTimeCell.h
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkingExperienceVC.h"

@interface WorkingTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *StartTime;
- (IBAction)startTimeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *endTime;
- (IBAction)endTimeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *todaySelect;
- (IBAction)todaySelectClick:(UIButton *)sender;
@property (strong,nonatomic) WorkingExperienceVC * controller;

@end
