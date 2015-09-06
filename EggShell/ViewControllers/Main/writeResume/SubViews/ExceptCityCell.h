//
//  ExceptCityCell.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteResumeViewController.h"

@interface ExceptCityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *proviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *countyBtn;
@property (strong,nonatomic) WriteResumeViewController * Controller;
@property (strong,nonatomic) void(^proviceClick)(int);
@property (strong,nonatomic) void(^cityClick)(int);
@property (strong,nonatomic) void(^threecityClick)(int);
- (IBAction)exceptClick:(UIButton *)sender;
- (IBAction)cityClick:(UIButton *)sender;
- (IBAction)countyBtn:(UIButton *)sender;

-(void)config:(NSArray *)dataArray;

@end
