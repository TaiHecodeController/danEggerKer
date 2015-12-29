//
//  WorkingExperienceVC.h
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum
{
    addPush,
    editPush,
    
}pushType;

@interface WorkingExperienceVC : UIViewController
@property (strong,nonatomic)UILabel * nameLab;
@property (strong,nonatomic)UITextView * contentTextField;

@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *deprtment;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *workContent;
@property (nonatomic, copy) NSString *detailId;
@property (nonatomic, assign) pushType pushtype;

@end
