//
//  WorkExperienceView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkExperienceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *workTime;
@property (weak, nonatomic) IBOutlet UILabel *position;
@property (weak, nonatomic) IBOutlet UITextView *workContent;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *CompanyNameLable;

+(WorkExperienceView*)setWorkExperienceView;
-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i;
@end
