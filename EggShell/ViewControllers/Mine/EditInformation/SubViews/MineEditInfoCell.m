//
//  MineEditInfoCell.m
//  EggShell
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MineEditInfoCell.h"
#import "EditAddressVC.h"

@implementation MineEditInfoCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showAllClick:(UIButton *)sender {
}
- (IBAction)nextClick:(UIButton *)sender {
    [self.Controller.navigationController pushViewController:[[EditAddressVC alloc] init] animated:YES];
}

@end
