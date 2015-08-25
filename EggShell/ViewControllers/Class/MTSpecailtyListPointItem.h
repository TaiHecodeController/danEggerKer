//
//  MTSpecailtyListPointItem.h
//  MyTravel
//
//  Created by zouyajun on 15/4/24.
//  Copyright (c) 2015年 mytravel. All rights reserved.
//

#import "MTGridView.h"

@interface MTSpecailtyListPointItem : MTGridViewItem

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *redXinBtn;
@property (nonatomic, strong) UIButton *priceBtn;
@property (nonatomic, strong) UILabel *companyLab;

@end
