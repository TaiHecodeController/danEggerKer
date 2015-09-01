//
//  EducationTimeCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TH_EducationExperienceVC.h"

@interface EducationTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *startTime;
@property (weak, nonatomic) IBOutlet UIButton *endTime;
- (IBAction)startTimeClick:(UIButton *)sender;
- (IBAction)endTimeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *todayClick;
- (IBAction)todayClick:(UIButton *)sender;


@end
