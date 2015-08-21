//
//  WriteResumeCell.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteResumeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *resumeName;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIButton *showMessageBtn;
- (IBAction)whowAllClick:(UIButton *)sender;

@end
