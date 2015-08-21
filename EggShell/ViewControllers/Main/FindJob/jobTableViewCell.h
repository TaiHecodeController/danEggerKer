//
//  jobTableViewCell.h
//  EggShell
//
//  Created by 太和 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jobTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *positionSecBtn;
@property (nonatomic, strong) UILabel *positionLab;
@property (nonatomic, strong) UILabel *companyLab;
@property (nonatomic, strong) UILabel *cityLab;
@property (nonatomic, strong) UILabel *knowledgeLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *salaryLab;
@property (nonatomic, copy) NSString *jobSelected;

@property (nonatomic, assign) CGFloat cellHeight;

@end
