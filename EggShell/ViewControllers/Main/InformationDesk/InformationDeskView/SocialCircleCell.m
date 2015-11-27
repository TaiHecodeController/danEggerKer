//
//  SocialCircleCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "SocialCircleCell.h"

@implementation SocialCircleCell
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
    UIImageView * logoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(20*MyWideth, 10*MyHeight, 70*MyHeight, 70*MyHeight)];
    self.logoImageView = logoImageView;
    logoImageView.image = [UIImage imageNamed:@"HR交流圈"];
    [self.contentView addSubview:logoImageView];
    UILabel * groupNoLable = [[UILabel alloc] initWithFrame:CGRectMake(162*MyWideth, 38*MyHeight, WIDETH - 182, 16)];
    self.groupNoLable = groupNoLable;
    groupNoLable.font = [UIFont systemFontOfSize:16];
    groupNoLable.textColor = UIColorFromRGB(0x666666);
    groupNoLable.text = @"蛋壳儿精英群";
    [self.contentView addSubview:groupNoLable];
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
-(void)configValue:(NSDictionary*)dic
{
    
   [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"photo"]] placeholderImage:[UIImage imageNamed:@"HR交流圈"]];
    self.groupNoLable.text = dic[@"name"];

}
@end
