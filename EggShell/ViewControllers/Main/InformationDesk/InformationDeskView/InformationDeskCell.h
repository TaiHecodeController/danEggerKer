//
//  InformationDeskCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playFanModel.h"
@interface InformationDeskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *homeLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
-(void)setValue:(playFanModel *)model;
@end
