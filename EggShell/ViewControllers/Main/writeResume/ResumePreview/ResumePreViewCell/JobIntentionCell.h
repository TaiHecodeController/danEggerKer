//
//  JobIntentionCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobIntentionCell : UITableViewCell
@property(nonatomic,strong)UILabel * exceptJob;
@property(nonatomic,strong)UILabel * exceptIndustry;
@property(nonatomic,strong)UILabel * exceptSalary;
@property(nonatomic,strong)UILabel * workAddress;
@property(nonatomic,strong)UILabel * arriveTime;
@property(nonatomic,strong)UILabel * workState;
@property(nonatomic,strong)UILabel *  workNature;
-(void)configValue:(NSDictionary*)dataDic;
@end
