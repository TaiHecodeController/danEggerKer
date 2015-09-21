//
//  TrainReadView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteRusumeModel2.h"
@interface TrainReadView : UIView
+(TrainReadView*)settrinView;
@property (weak, nonatomic) IBOutlet UIButton *bitianxiang;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *trainingCentreLalbe;
@property (weak, nonatomic) IBOutlet UILabel *trailTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *TrainingDirectionLable;
@property (weak, nonatomic) IBOutlet UITextView *trainingContentLable;
-(void)configValue:(WriteRusumeModel2*)model;
@end
