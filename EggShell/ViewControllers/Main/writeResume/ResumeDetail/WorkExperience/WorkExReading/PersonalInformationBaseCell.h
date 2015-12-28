//
//  PersonalInformationBaseCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/28.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInformationBaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyNameLable;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLable;
@property (weak, nonatomic) IBOutlet UILabel *limitedTimeLable;

-(void)configValeus:(NSDictionary *)dic;

@end
