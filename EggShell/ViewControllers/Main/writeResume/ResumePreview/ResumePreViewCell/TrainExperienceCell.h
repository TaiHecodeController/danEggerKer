//
//  TrainExperienceCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditdelegateView.h"
@interface TrainExperienceCell : UITableViewCell
@property(nonatomic,strong)UILabel * trainTime;
@property(nonatomic,strong)UILabel * trainDirection;
@property(nonatomic,strong)UILabel * trainCompany;
@property(nonatomic,strong)UILabel * trainIntroduce;
@property(nonatomic,strong)EditdelegateView * editDeleteView;
-(void)configValue:(NSDictionary *)dataDic;
@property(nonatomic,strong)void(^editDeleteBlock)(int sender);
@end
