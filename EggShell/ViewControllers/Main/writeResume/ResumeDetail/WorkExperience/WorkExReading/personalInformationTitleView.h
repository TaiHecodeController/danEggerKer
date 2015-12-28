//
//  personalInformationTitleView.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/28.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personalInformationTitleView : UIView
+(personalInformationTitleView*)setpersonalInformationTitleView;

@property (weak, nonatomic) IBOutlet UILabel *personTitleLable;
@property (weak, nonatomic) IBOutlet UIButton *personBackBtn;

@end
