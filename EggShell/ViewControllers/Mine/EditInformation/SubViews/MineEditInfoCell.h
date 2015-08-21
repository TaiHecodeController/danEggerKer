//
//  MineEditInfoCell.h
//  EggShell
//
//  Created by mac on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineEditVC.h"

@interface MineEditInfoCell : UITableViewCell
@property (strong,nonatomic) MineEditVC * Controller;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UILabel *moreLab;
@property (weak, nonatomic) IBOutlet UIButton *showAllBtn;
- (IBAction)showAllClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextClick:(UIButton *)sender;

@end
