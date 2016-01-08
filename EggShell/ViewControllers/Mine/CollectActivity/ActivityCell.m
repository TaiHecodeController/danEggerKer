//
//  ActivityCell.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/7.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "ActivityCell.h"
#import "ItemTimeView.h"
@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    /*活动logo**/
    UIImageView * holdLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH-168*MyHeight-10, 10, 168*MyHeight, 95)];
    holdLogoImageView.image = [UIImage imageNamed:@"logoSencond"];
    [self.contentView addSubview:holdLogoImageView];
    /*活动标题**/
   UILabel * eventTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 9, WIDETH-168*MyHeight-10-15, 36)];
    eventTitleLable.text = @"让爱回家-心里疗愈工作坊2016年北京第八期";
    eventTitleLable.numberOfLines = 2;
    eventTitleLable.font = [UIFont systemFontOfSize:15];
    eventTitleLable.textColor = UIColorFromRGB(0x000000);
    self.eventTitleLable = eventTitleLable;
    [self.contentView addSubview:eventTitleLable];
    /*主办方**/
    UIImageView * holdViewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 53, 12.5, 12.5)];
    holdViewImageView.image =[UIImage imageNamed:@"holdmain"];
    [self.contentView addSubview:holdViewImageView];
    
    UILabel * holdLable = [[UILabel alloc] initWithFrame:CGRectMake(27.5, 53, WIDETH-168*MyHeight-10-15-27.5, 12)];
    holdLable.text = @"主办方: 戏剧大院";
    holdLable.font =[UIFont systemFontOfSize:12];
    holdLable.textColor = UIColorFromRGB(0x999999);
    self.holdLable = holdLable;
    [self.contentView addSubview:holdLable];
/*活动地址**/
    UIImageView * holdAddressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11.5, 72, 10, 13.5)];
    holdAddressImageView.image =[UIImage imageNamed:@"holdAddress"];
    [self.contentView addSubview:holdAddressImageView];
    
    UILabel * organizedAddressLable = [[UILabel alloc] initWithFrame:CGRectMake(27.5, 73, WIDETH-168*MyHeight-10-15-27.5, 12)];
    organizedAddressLable.text = @"北京市海淀区";
    organizedAddressLable.font =[UIFont systemFontOfSize:12];
    organizedAddressLable.textColor = UIColorFromRGB(0x999999);
    self.organizedAddressLable = organizedAddressLable;
    [self.contentView addSubview:organizedAddressLable];
   /*活动时间**/
    UIImageView * holeTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(11, 93, 11.5, 11.5)];
    holeTimeImageView.image = [UIImage imageNamed:@"holdtime"];
    [self.contentView addSubview:holeTimeImageView];
    UILabel * organizedTimeTitleLable =[[UILabel alloc] initWithFrame:CGRectMake(27.5, 93, WIDETH-168*MyHeight-10-15-27.5, 12)];
    organizedTimeTitleLable.text = @"2016-01-06";
    organizedTimeTitleLable.font =[UIFont systemFontOfSize:12];
    organizedTimeTitleLable.textColor = UIColorFromRGB(0x999999);
    self.organizedTimeTitleLable = organizedTimeTitleLable;
    [self.contentView addSubview:organizedTimeTitleLable];
//    /*收藏数量**/
    
    ItemTimeView * itemView = [[ItemTimeView alloc] initWithFrame:CGRectMake(WIDETH-168*MyWideth-10-72, 93, 72, 12)];
    self.itemView = itemView;
    [self.contentView addSubview:itemView];
    UIView * boddomView = [[UIView alloc] initWithFrame:CGRectMake(0, 115, WIDETH, 10)];
    
    boddomView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.contentView addSubview:boddomView];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
