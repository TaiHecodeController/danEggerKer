//
//  findJobDetialScriptionViewS.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "findJobDetialScriptionViewS.h"

@implementation findJobDetialScriptionViewS

+(findJobDetialScriptionViewS*)setFindJobDetialScriptionView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"findJobDetialScriptionView" owner:self options:nil] lastObject];
}
-(void)setValues:(NSDictionary*)dic
{
//    @property (weak, nonatomic) IBOutlet UIImageView *logoView;
//    @property (weak, nonatomic) IBOutlet UILabel *jobNameLable;
//    @property (weak, nonatomic) IBOutlet UILabel *companyNameLable;
//    @property (weak, nonatomic) IBOutlet UILabel *releaseTimeLable;
//    @property (weak, nonatomic) IBOutlet UILabel *closeTImeLable;
//    @property (weak, nonatomic) IBOutlet UILabel *salaryLable;
//    @property (weak, nonatomic) IBOutlet UILabel *workYearLable;
//    @property (weak, nonatomic) IBOutlet UILabel *studyLable;
//    @property (weak, nonatomic) IBOutlet UILabel *addressLable;
//    @property (weak, nonatomic) IBOutlet UILabel *natureLable;
//    @property (weak, nonatomic) IBOutlet UILabel *recruitLable;
//    @property (weak, nonatomic) IBOutlet UILabel *genderLable;
//    @property (weak, nonatomic) IBOutlet UILabel *marraigeLable;
//    @property (weak, nonatomic) IBOutlet UILabel *dutyLable;
//    @property (weak, nonatomic) IBOutlet UITextView *jobCroptionTextView;
//    @property (weak, nonatomic) IBOutlet UILabel *compayAddressLable;
}
@end
