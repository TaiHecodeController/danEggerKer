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
    UIImageView * logoImageView =[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
    logoImageView.image = [UIImage imageNamed:@"touxiang1"];
    [self.contentView addSubview:logoImageView];
    UILabel * groupNoLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 150, 60)];
    groupNoLable.text = @"蛋壳儿精英群";
    [self.contentView addSubview:groupNoLable];
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
