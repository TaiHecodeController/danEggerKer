
//
//  AllPosionCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/25.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "AllPosionCell.h"

@implementation AllPosionCell
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
    UIButton *   marqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10*MyWideth, 38*MyWideth, 38*MyWideth)];
    [marqueeBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [marqueeBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
//    [marqueeBtn addTarget:self action:@selector(markqueeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.marqueeBtn = marqueeBtn;
    [self.contentView addSubview:marqueeBtn];
    
    //职位名称
    UILabel *   posionNameLable = [[UILabel alloc] initWithFrame:CGRectMake(10*MyWideth+38*MyWideth+10, 10*MyWideth+12*MyWideth, WIDETH-(10*MyWideth+38*MyWideth+10*MyWideth-55*MyWideth), 16*MyWideth)];
    posionNameLable.text = @"PHP开发工程师";
    posionNameLable.font =[UIFont systemFontOfSize:16*MyWideth];
    posionNameLable.textColor = UIColorFromRGB(0x000000);
    self.posionNameLable = posionNameLable;
    [self.contentView addSubview:posionNameLable];
    //职位状态
    UILabel * posionStatusLable =[[UILabel alloc] initWithFrame:CGRectMake(WIDETH-55*MyWideth, 10*MyWideth+13*MyWideth, 45*MyWideth, 14*MyWideth)];
    posionStatusLable.textColor = UIColorFromRGB(0Xf44336);
    posionStatusLable.font =[UIFont systemFontOfSize:14*MyWideth];
    posionStatusLable.text = @"招聘中";
    self.posionStatusLable = posionStatusLable;
    [self.contentView addSubview:posionStatusLable];
    
    //分割线
    UIView * lineView =[[UIView alloc] initWithFrame:CGRectMake(20, 38*MyWideth+10*MyWideth, WIDETH-20*MyWideth, 1)];
    lineView.backgroundColor = color(240, 240, 237);
    [self.contentView addSubview:lineView];
    //收到个数
    UIView * receivedNumberBgView = [[UIView alloc] initWithFrame:CGRectMake(58*MyWideth, 38*MyWideth+10*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 57*MyWideth)];
//    receivedNumberBgView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:receivedNumberBgView];
    UIImageView * receivedNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDETH-(58*MyWideth+10))/4.0-13*MyWideth)/2.0, 10*MyWideth, 13*MyWideth,16*MyWideth)];
    receivedNumberImageView.image = [UIImage imageNamed:@"shoudao1"];
    [receivedNumberBgView addSubview:receivedNumberImageView];
    UILabel * receivedNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*MyWideth - 22*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 12*MyWideth)];
    receivedNumberLable.font = [UIFont systemFontOfSize:12*MyWideth];
    receivedNumberLable.textColor = UIColorFromRGB(0xF44336);
    receivedNumberLable.text = @"收到100";
    receivedNumberLable.textAlignment = NSTextAlignmentCenter;
    self.receivedNumberLable = receivedNumberLable;
    [receivedNumberBgView addSubview:receivedNumberLable];
    /*设置第几个字体**/
    NSMutableAttributedString *markLabelStrs = [[NSMutableAttributedString alloc] initWithString:receivedNumberLable.text];
    [markLabelStrs addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x646464) range:NSMakeRange(0,2)];
    receivedNumberLable.attributedText = markLabelStrs;
//    //浏览个数
//    @property(nonatomic,strong)UILabel * browseNumberLable;
    UIView * browseNumberBgView = [[UIView alloc] initWithFrame:CGRectMake(58*MyWideth+((WIDETH-(58*MyWideth+10))/4.0), 38*MyWideth+10*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 57*MyWideth)];
//    browseNumberBgView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:browseNumberBgView];
    UIImageView * browseNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDETH-(58*MyWideth+10))/4.0-16*MyWideth)/2.0, 10*MyWideth, 16*MyWideth,16*MyWideth)];
    browseNumberImageView.image = [UIImage imageNamed:@"liulan1"];
    [browseNumberBgView addSubview:browseNumberImageView];
    UILabel * browseNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*MyWideth - 22*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 12*MyWideth)];
    browseNumberLable.font = [UIFont systemFontOfSize:12*MyWideth];
    browseNumberLable.textColor = UIColorFromRGB(0XF44336);
    browseNumberLable.text = @"浏览1000";
    browseNumberLable.textAlignment = NSTextAlignmentCenter;
    self.browseNumberLable = browseNumberLable;
    [browseNumberBgView addSubview:browseNumberLable];
    //设置字体颜色
    /*设置第几个字体**/
    NSMutableAttributedString *markLabelStr = [[NSMutableAttributedString alloc] initWithString:browseNumberLable.text];
    [markLabelStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x646464) range:NSMakeRange(0,2)];
    browseNumberLable.attributedText = markLabelStr;
//    //开始时间
//    @property(nonatomic,strong)UILabel * startTimeLable;
    UIView * startTimeBgView = [[UIView alloc] initWithFrame:CGRectMake(58*MyWideth+((WIDETH-(58*MyWideth+10))/4.0)*2, 38*MyWideth+10*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 57*MyWideth)];
//    startTimeBgView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:startTimeBgView];
    UIImageView * startTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDETH-(58*MyWideth+16*MyWideth))/4.0-13)/2.0, 10*MyWideth, 16*MyWideth,16*MyWideth)];
    startTimeImageView.image = [UIImage imageNamed:@"startTime1"];
    [startTimeBgView addSubview:startTimeImageView];
    UILabel * startTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*MyWideth - 22*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 12*MyWideth)];
    startTimeLable.font = [UIFont systemFontOfSize:12*MyWideth];
    startTimeLable.textColor = UIColorFromRGB(0x646464);
    startTimeLable.text = @"2015-01-25";
    self.startTimeLable = startTimeLable;
    startTimeLable.textAlignment = NSTextAlignmentCenter;

    [startTimeBgView addSubview:startTimeLable];
//    //结束时间
//    @property(nonatomic,strong)UILabel * endTimeLable;
    UIView * endTimeBgView = [[UIView alloc] initWithFrame:CGRectMake(58*MyWideth+((WIDETH-(58*MyWideth+10))/4.0)*3, 38*MyWideth+10*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 57*MyWideth)];
    
//    endTimeBgView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:endTimeBgView];
    UIImageView * endTimeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(((WIDETH-(58*MyWideth+10))/4.0-16*MyWideth)/2.0, 10*MyWideth, 16*MyWideth,16*MyWideth)];
    endTimeImageView.image = [UIImage imageNamed:@"enttime1"];
    [endTimeBgView addSubview:endTimeImageView];
    UILabel * endTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 57*MyWideth - 22*MyWideth, (WIDETH-(58*MyWideth+10))/4.0, 12*MyWideth)];
    endTimeLable.font = [UIFont systemFontOfSize:12*MyWideth];
    endTimeLable.textColor = UIColorFromRGB(0x646464);
    endTimeLable.text = @"2015-01-30";
    endTimeLable.textAlignment = NSTextAlignmentCenter;
    self.endTimeLable = endTimeLable;
    [endTimeBgView addSubview:endTimeLable];


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_jobSelected isEqualToString:@"0"])
    {
        _marqueeBtn.selected = NO;
    }
    else
    {
        _marqueeBtn.selected = YES;
    }

    
}
//-(void)markqueeBtnClick:(UIButton*)sender
//{
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        self.isSelectBlock(self.tag);
//    }
//}
-(void)configValue:(AllPosionModel*)model
{
   
    self.posionNameLable.text = model.cj_name;
    self.receivedNumberLable.text = [NSString stringWithFormat:@"收到%@",model.count];
    NSMutableAttributedString *markLabelStrs = [[NSMutableAttributedString alloc] initWithString:self.receivedNumberLable.text];
    [markLabelStrs addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x646464) range:NSMakeRange(0,2)];
    self.receivedNumberLable.attributedText = markLabelStrs;
    self.browseNumberLable.text = [NSString stringWithFormat:@"浏览%@",model.jobhits];
    NSMutableAttributedString *markLabelStr = [[NSMutableAttributedString alloc] initWithString:self.browseNumberLable.text];
    [markLabelStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x646464) range:NSMakeRange(0,2)];
    self.browseNumberLable.attributedText = markLabelStr;
    self.startTimeLable.text = model.edate;
    self.endTimeLable.text = model.lastupdate;
    NSString * status = model.status;
    if ([status isEqualToString:[NSString stringWithFormat:@"%d",1]]) {
        self.posionStatusLable.text = @"已暂停";
    }else
    {
     self.posionStatusLable.text = @"招聘中";
    }
    
}
- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
  
}

@end
