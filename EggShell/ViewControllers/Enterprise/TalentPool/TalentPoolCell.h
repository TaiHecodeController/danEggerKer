//
//  TalentPoolCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/11/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalentPoolCell : UITableViewCell
//选框
@property(nonatomic,strong)UIButton * marqueeBtn;
//姓名
@property(nonatomic,strong)UILabel * nameLable;
//时间
@property(nonatomic,strong)UILabel * timeLable;
//职位名称
@property(nonatomic,strong)UILabel * jobNameLable;
//职位年限图片
@property(nonatomic,strong)UIImageView * jobYearImageView;
//职位年限
@property(nonatomic,strong)UILabel * jobYearLable;
//职位薪水
@property(nonatomic,strong)UILabel * salaryLable;
@end
