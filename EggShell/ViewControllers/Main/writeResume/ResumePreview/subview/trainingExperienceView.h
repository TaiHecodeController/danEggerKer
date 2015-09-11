//
//  trainingExperienceView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trainingExperienceView : UIView
@property (weak, nonatomic) IBOutlet UILabel *trainTime;
@property (weak, nonatomic) IBOutlet UILabel *trainDirection;
@property (weak, nonatomic) IBOutlet UILabel *trainCompany;
@property (weak, nonatomic) IBOutlet UITextView *trainIntroduce;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+(trainingExperienceView*)settrainingExperienceView;
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
