//
//  NameAndSexCell.m
//  EggShell
//
//  Created by mac on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "NameAndSexCell.h"

@implementation NameAndSexCell

- (void)awakeFromNib {
    // Initialization code
    self.manBtn.selected = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectSex:(UIButton *)sender {
    if(sender.tag == 1000)
    {
        if(self.manBtn.selected == YES)
        {
            self.womenBtn.selected = NO;
            
        }else
        {
            self.manBtn.selected = YES;
            self.womenBtn.selected = NO;
        }
    }else
    {
        if(self.womenBtn.selected == YES)
        {
            self.manBtn.selected = NO;
            
        }else
        {
            self.womenBtn.selected = YES;
            self.manBtn.selected = NO;
        }
    }
}
@end
