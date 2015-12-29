//
//  TrainExperienceCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainExperienceCell : UITableViewCell
@property(nonatomic,strong)UILabel * trainTime;
@property(nonatomic,strong)UILabel * trainDirection;
@property(nonatomic,strong)UILabel * trainCompany;
@property(nonatomic,strong)UILabel * trainIntroduce;
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
