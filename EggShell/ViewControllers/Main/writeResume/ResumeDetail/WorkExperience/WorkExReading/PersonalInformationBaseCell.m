//
//  PersonalInformationBaseCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/28.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "PersonalInformationBaseCell.h"

@implementation PersonalInformationBaseCell

-(void)configValeus:(NSDictionary *)dic
{
self.companyNameLable.text = [NSString stringWithFormat:@"%@",dic[@"name"]];
self.limitedTimeLable.text = [dic[@"sdate"] stringByAppendingFormat:@"-%@",dic[@"edate"]];
    self.jobNameLable.text = dic[@"title"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
