//
//  InformationDeskCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "InformationDeskCell.h"

@implementation InformationDeskCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setValue:(playFanModel *)model
{

    self.name.text = model.title;
    [self.logoImage setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"tu"]];
    
    self.addressLable.text = model.address;
    self.homeLable.text = model.organizers;
    self.timeLable.text = model.starttime;
    
}
@end
