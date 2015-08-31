//
//  ResumeCell.h
//  EggShell
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerResumeVC.h"

@interface ResumeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *iSSelect;
- (IBAction)iSSelectClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *ResumeName;
@property (weak, nonatomic) IBOutlet UILabel *createDate;
@property (weak, nonatomic) IBOutlet UIButton *lookResume;
- (IBAction)lookResumeClick:(UIButton *)sender;
@property (strong,nonatomic) ManagerResumeVC * Controller;
@property (strong,nonatomic)NSIndexPath * cellIndex;

@end
