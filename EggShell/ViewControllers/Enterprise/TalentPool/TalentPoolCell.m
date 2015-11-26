//
//  TalentPoolCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TalentPoolCell.h"

@implementation TalentPoolCell
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
    //暗条
    UIView * bgVieW = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 10*MyWideth)];
    bgVieW.backgroundColor = color(240, 240, 237);
    [self.contentView addSubview:bgVieW];
    
    //按钮选框
    UIButton *   marqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20*MyWideth, 40*MyWideth, 40*MyWideth)];
    [marqueeBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [marqueeBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    [marqueeBtn addTarget:self action:@selector(markqueeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.marqueeBtn = marqueeBtn;
    [self.contentView addSubview:marqueeBtn];
    //姓名
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10+50*MyHeight, 10*MyHeight+10*MyHeight, 150, 16*MyHeight)];
    nameLable.text = @"张三丰";
    nameLable.font = [UIFont systemFontOfSize:16*MyWideth];
    nameLable.textColor = UIColorFromRGB(0x000000);
    [self.contentView addSubview:nameLable];
    //时间
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 80*MyWideth, 10*MyWideth+15*MyWideth, 70*MyWideth, 13*MyWideth)];
    timeLable.text = @"2015.01.01";
    timeLable.textAlignment = NSTextAlignmentRight;
    timeLable.font = [UIFont systemFontOfSize:13*MyWideth];
    timeLable.textColor = UIColorFromRGB(0X646464);
    [self.contentView addSubview:timeLable];
    //职位名称
    UILabel * jobNameLable = [[UILabel alloc] initWithFrame:CGRectMake(10+50*MyHeight, 57*MyWideth - 10*MyWideth-13*MyWideth+10*MyWideth, WIDETH/2.0-(10+50*MyHeight), 13*MyWideth)];
    jobNameLable.text = @"PHP工程师";
    jobNameLable.textColor = UIColorFromRGB(0x646464);
    jobNameLable.font = [UIFont systemFontOfSize:13*MyWideth];
    [self.contentView addSubview:jobNameLable];
    //职位年限图片
    UIImageView * jobYearImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDETH/2.0, 57*MyWideth - 10*MyWideth-13*MyWideth+10*MyWideth, 14*MyWideth, 14*MyWideth)];
    jobYearImageView.image =[UIImage imageNamed:@"clock-拷贝"];
    [self.contentView addSubview:jobYearImageView];
    
    //职位年限
    UILabel * jobYearLable =[[UILabel alloc] initWithFrame:CGRectMake(WIDETH/2.0+14*MyWideth+5*MyWideth, 57*MyWideth - 10*MyWideth-13*MyWideth+10*MyWideth, 55, 13*MyWideth)];
    jobYearLable.text = @"一年以下";
    jobYearLable.textColor = UIColorFromRGB(0X646464);
    jobYearLable.font = [UIFont systemFontOfSize:13*MyWideth];
    [self.contentView addSubview:jobYearLable];
    //职位薪水
    UILabel * salaryLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 150*MyWideth, 57*MyWideth - 10*MyWideth-13*MyWideth+10*MyWideth, 140*MyWideth, 13*MyWideth)];
    salaryLable.text = @"￥4000-16000";
    salaryLable.font = [UIFont systemFontOfSize:13*MyWideth];
    salaryLable.textColor = UIColorFromRGB(0Xf44336);
    salaryLable.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:salaryLable];
}
-(void)markqueeBtnClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
