//
//  Course PlayCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Course_PlayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
-(void)setOrderValue:(int)number;
@end
