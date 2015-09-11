//
//  ProjectExperienceView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectExperienceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *projectTime;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UITextView *proIntroduce;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+(ProjectExperienceView*)setProjectExperienceView;
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
