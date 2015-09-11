//
//  EducationReadingView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteRusumeModel2.h"

@interface EducationReadingView : UIView
@property (weak, nonatomic) IBOutlet UILabel *ResumeTitle;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *dapartmentLab;
@property (weak, nonatomic) IBOutlet UILabel *positionLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

+(EducationReadingView*)setView;
-(void)config:(WriteRusumeModel2 *)model;
@end
