//
//  personResumeCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personResumeCell : UITableViewCell
@property(nonatomic,strong)UILabel * nameSexAge;
@property(nonatomic,strong)UILabel * adademic;
@property(nonatomic,strong)UILabel *  experience;
@property(nonatomic,strong)UILabel *  address;
@property(nonatomic,strong)UILabel *  phoneNum;
@property(nonatomic,strong)UILabel *  email;
-(void)configVulue:(NSDictionary *)dataDic;
-(void)setIntroductionText:(NSString*)text;
@end
