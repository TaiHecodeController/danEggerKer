//
//  WriteResumeCell.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "WriteResumeCell.h"

@implementation WriteResumeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)whowAllClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            NSLog(@"简历名称");
            break;
        case 101:
            NSLog(@"从事行业");
            break;
        default:
            break;
    }
}
@end
