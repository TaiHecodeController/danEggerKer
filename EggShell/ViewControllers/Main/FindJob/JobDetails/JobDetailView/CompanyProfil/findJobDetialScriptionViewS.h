//
//  findJobDetialScriptionViewS.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface findJobDetialScriptionViewS : UIView
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLable;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLable;
@property (weak, nonatomic) IBOutlet UILabel *releaseTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *closeTImeLable;
@property (weak, nonatomic) IBOutlet UILabel *salaryLable;
@property (weak, nonatomic) IBOutlet UILabel *workYearLable;
@property (weak, nonatomic) IBOutlet UILabel *studyLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *natureLable;
@property (weak, nonatomic) IBOutlet UILabel *recruitLable;
@property (weak, nonatomic) IBOutlet UILabel *genderLable;
@property (weak, nonatomic) IBOutlet UILabel *marraigeLable;
@property (weak, nonatomic) IBOutlet UILabel *dutyLable;
@property (weak, nonatomic) IBOutlet UITextView *jobCroptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *compayAddressLable;
@property (weak, nonatomic) IBOutlet UILabel *dutytitleLable;
@property (weak, nonatomic) IBOutlet UIView *dutyBgview;
@property(nonatomic,strong)UILabel * dutyLableTime;
@property (weak, nonatomic) IBOutlet UIView *threeBgview;
@property (weak, nonatomic) IBOutlet UIView *fourthBgview;

@property (weak, nonatomic) IBOutlet UIView *firstBgview;
@property (weak, nonatomic) IBOutlet UIView *secondBgview;
@property(nonatomic,strong)UIView * bgview;
-(void)restLayer;
+(findJobDetialScriptionViewS*)setFindJobDetialScriptionView;
-(void)setValues:(NSDictionary*)dic;
@end
