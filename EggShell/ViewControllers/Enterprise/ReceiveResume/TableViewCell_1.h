//
//  TableViewCell_1.h
//  EggShell
//
//  Created by 太和 on 15/11/24.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cpy_ReciveResumeListMode.h"
//未查看cell

@interface TableViewCell_1 : UITableViewCell

@property (nonatomic, strong) UIButton *selIcon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *positionLab;
@property (nonatomic, strong) UILabel *expLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *salaryLab;
@property (nonatomic) CGFloat cellHeight;
@property (nonatomic, copy) NSString *icon_seleted;

- (void)config:(cpy_ReciveResumeListMode *)model;

@end
