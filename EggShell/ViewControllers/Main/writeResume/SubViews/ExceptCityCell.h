//
//  ExceptCityCell.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExceptCityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *proviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *countyBtn;
- (IBAction)exceptClick:(UIButton *)sender;
- (IBAction)cityClick:(UIButton *)sender;
- (IBAction)countyBtn:(UIButton *)sender;


@end
