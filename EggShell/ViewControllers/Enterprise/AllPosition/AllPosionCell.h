//
//  AllPosionCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/11/25.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AllPosionModel.h"
@interface AllPosionCell : UITableViewCell
//按钮选框
@property(nonatomic,strong)UIButton * marqueeBtn;
//职位名称
@property(nonatomic,strong)UILabel * posionNameLable;
//职位状态
@property(nonatomic,strong)UILabel * posionStatusLable;
//收到个数
@property(nonatomic,strong)UILabel * receivedNumberLable;
@property(nonatomic,strong)UIImageView * receivedNumberImageView;
//浏览个数
@property(nonatomic,strong)UILabel * browseNumberLable;
@property(nonatomic,strong)UIImageView * browseNumberImageView;
//开始时间
@property(nonatomic,strong)UILabel * startTimeLable;
@property(nonatomic,strong)UIImageView * startTimeImageView;
//结束时间
@property(nonatomic,strong)UILabel * endTimeLable;
@property(nonatomic,strong)UIImageView * endTimeImageView;
@property (strong,nonatomic)void(^isSelectBlock)(int);
-(void)configValue:(AllPosionModel*)model;
@end
