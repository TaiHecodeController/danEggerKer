//
//  TableViewCell_3.h
//  EggShell
//
//  Created by 太和 on 15/11/24.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cpy_ReciveResumeListMode.h"

@interface TableViewCell_3 : UITableViewCell

@property (nonatomic, strong) UIImageView *selIcon;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UILabel *positionLab;
@property (nonatomic, strong) UILabel *expLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *salaryLab;
@property (nonatomic) CGFloat cellHeight;

- (void)config:(cpy_ReciveResumeListMode *)model;

@end
