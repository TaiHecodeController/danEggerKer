//
//  WorkExReadingView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkExReadingView : UIView
+(WorkExReadingView*)setView;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLable;
@property (weak, nonatomic) IBOutlet UILabel *HoldTimelable;

@property (weak, nonatomic) IBOutlet UILabel *DepartmentLable;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *OfficeLable;
@end
