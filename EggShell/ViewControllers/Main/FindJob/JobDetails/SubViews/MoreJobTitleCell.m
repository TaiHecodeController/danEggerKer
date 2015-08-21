//
//  MoreJobTitleCell.m
//  EggShell
//
//  Created by mac on 15/8/21.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "MoreJobTitleCell.h"

@implementation MoreJobTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    UIView  * heatView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 53)];
    
    UIView * lineVew = [[UIView alloc] initWithFrame:CGRectMake(15, 25, 2, 15)];
    lineVew.backgroundColor = color(244, 67, 54);
    [heatView addSubview:lineVew];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 10)];
    bgView.backgroundColor = color(243, 243, 241);
    [heatView addSubview:bgView];
    UILabel * RelatedLable = [[UILabel alloc] initWithFrame:CGRectMake(21, 25, 100, 13)];
    RelatedLable.text = @"该公司更多职位";
    RelatedLable.textColor = color(100, 100, 100);
    RelatedLable.font =[UIFont systemFontOfSize:13];
    [heatView addSubview:RelatedLable];
    
    heatView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:heatView];
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
