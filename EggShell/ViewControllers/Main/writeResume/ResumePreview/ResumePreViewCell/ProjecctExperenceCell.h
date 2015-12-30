//
//  ProjecctExperenceCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditdelegateView.h"
@interface ProjecctExperenceCell : UITableViewCell
@property(nonatomic,strong)UILabel * projectTime;
@property(nonatomic,strong)UILabel * position;
@property(nonatomic,strong)UILabel * proName;
@property(nonatomic,strong)EditdelegateView * editDeleteView;
@property(nonatomic,strong)UILabel * proIntroduce;
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i;
@property(nonatomic,strong)void(^editDeleteBlock)(int sender);
@end
