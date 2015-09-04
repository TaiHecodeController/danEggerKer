//
//  intentView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface intentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *exceptJob;
@property (weak, nonatomic) IBOutlet UILabel *exceptIndustry;
@property (weak, nonatomic) IBOutlet UILabel *exceptSalary;
@property (weak, nonatomic) IBOutlet UILabel *workAddress;
@property (weak, nonatomic) IBOutlet UILabel *arriveTime;
@property (weak, nonatomic) IBOutlet UILabel *workState;
@property (weak, nonatomic) IBOutlet UILabel *workNature;

+(intentView*)setIntentView;
-(void)configValue:(NSString*)model;
@end
