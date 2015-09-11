//
//  ProjectExpReadView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteRusumeModel2.h"
@interface ProjectExpReadView : UIView
+(ProjectExpReadView*)setProjectExperienceView;
@property (weak, nonatomic) IBOutlet UILabel *projectNameLable;
@property (weak, nonatomic) IBOutlet UILabel *SchoolTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *ProjectEnvironmentLable;
@property (weak, nonatomic) IBOutlet UILabel *holdOfficeLable;

@property (weak, nonatomic) IBOutlet UITextView *ProjectContentLable;
-(void)configValue:(WriteRusumeModel2*)model;
@end
