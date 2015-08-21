//
//  Course PlayCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "Course PlayCell.h"

@implementation Course_PlayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setOrderValue:(int)number
{
    [self.orderBtn setTitle:[NSString stringWithFormat:@"%d",number] forState:UIControlStateNormal];

}
@end
