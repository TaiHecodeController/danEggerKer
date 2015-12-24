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

-(void)setValue:(informantionModel *)model
{
    self.detailLable.hidden = YES;
    
    self.name.text = model.title;
    
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:model.logo]placeholderImage:[UIImage imageNamed:@"logoSencond"]];
    self.addressLable.text = model.address;
    self.homeLable.text = model.organizers;
//    self.timeLable.text = model.starttime;
//    NSString * dateStr = model.starttime;
//    self.timeLable.text = [dateStr substringFromIndex:5];
    
}
-(void)setValues:(informantionModel *)model
{
    self.addressView.hidden = YES;
    self.holdView.hidden = YES;
    self.addressLable.hidden = YES;
//    self.timeLable.hidden = YES;
    self.homeLable.hidden = YES;
    
    self.name.text = model.title;
    [self.logoImage sd_setImageWithURL:[NSURL URLWithString:model.logo]placeholderImage:[UIImage imageNamed:@"logoSencond"]];
//    self.addressLable.text = [NSString stringWithFormat:@"%@~%@",model.starttime,model.endtime];
   self.detailLable.text = [NSString stringWithFormat:@"%@~%@",model.starttime,model.endtime];
    //    self.timeLable.text = model.starttime;
//    NSString * dateStr = model.starttime;
//    self.timeLable.text = [dateStr substringFromIndex:5];
    
}
@end
