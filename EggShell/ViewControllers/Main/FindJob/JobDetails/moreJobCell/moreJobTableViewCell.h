//
//  moreJobTableViewCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface moreJobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *positionName;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *companyName;
@property (weak, nonatomic) IBOutlet UILabel *addres;
@property (weak, nonatomic) IBOutlet UILabel *knowdelge;

@property (weak, nonatomic) IBOutlet UILabel *salary;
@end
