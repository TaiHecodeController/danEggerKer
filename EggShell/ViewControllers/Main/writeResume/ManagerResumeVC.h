//
//  ManagerResumeVC.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerResumeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *createNewResume;
- (IBAction)createNewResumeClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *resumeName;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UIButton *lookResume;
@property (weak, nonatomic) IBOutlet UIButton *edit;
- (IBAction)editClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *useResume;
- (IBAction)userResume:(UIButton *)sender;
- (IBAction)delete:(id)sender;

@end
