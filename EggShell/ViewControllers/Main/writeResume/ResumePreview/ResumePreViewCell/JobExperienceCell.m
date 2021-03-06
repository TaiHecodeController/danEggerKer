//
//  JobExperienceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "JobExperienceCell.h"
#import "EditdelegateView.h"
@implementation JobExperienceCell
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
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, .5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.contentView addSubview:lineView];

    //工作时间
    UILabel *workTimeHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    workTimeHeadLable.text = @"工作时间:";
    workTimeHeadLable.font = [UIFont systemFontOfSize:12];
    workTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:workTimeHeadLable];
    self.workTime =[[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-75, 12)];
    self.workTime.font = [UIFont systemFontOfSize:12];
    self.workTime.textColor = UIColorFromRGB(0x000000);
    self.workTime.text = @"暂无";
    [self.contentView addSubview:self.workTime];
    //单位名称
    UILabel * positionHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    positionHeadLable.text = @"单位名称:";
    positionHeadLable.font = [UIFont systemFontOfSize:12];
    positionHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:positionHeadLable];
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-75, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //担任职位
    UILabel * titleLabHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    titleLabHeadLable.text = @"担任职位:";
    titleLabHeadLable.font = [UIFont systemFontOfSize:12];
    titleLabHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:titleLabHeadLable];
    self.titleLab =[[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-90, 12)];
    self.titleLab.font = [UIFont systemFontOfSize:12];
    self.titleLab.textColor = UIColorFromRGB(0x000000);
    self.titleLab.text = @"暂无";
    [self.contentView addSubview:self.titleLab];
    //工作内容
    UILabel * contentLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 74, WIDETH-15, 12)];
    contentLable.text = @"工作内容";
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:contentLable];
    
    self.workContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, WIDETH-30, 60)];
    self.workContent.font = [UIFont systemFontOfSize:12];
    self.workContent.textColor = UIColorFromRGB(0x000000);
    self.workContent.text = @"暂无";
    [self.contentView addSubview:self.workContent];
    EditdelegateView * editDeleteView = [[EditdelegateView alloc] initWithFrame:CGRectMake(WIDETH - 140, 154, 140, 35)];
    self.editDeleteView = editDeleteView;
    [self.contentView addSubview:editDeleteView];
    editDeleteView.ediBtn.tag = 10;
    editDeleteView.delgateBtn.tag = 11;
    [editDeleteView.ediBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
    [editDeleteView.delgateBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)editBtbClick:(UIButton*)sender
{
    self.editDeleteBlock(sender.tag,self.tag);
}
-(void)configVulue:(NSDictionary *)dataDic
{
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.workTime.text = [NSString stringWithFormat:@"%@ 到 %@",startTime,endTime];
    self.position.text = dataDic[@"name"];
    self.titleLab.text = dataDic[@"title"];
    self.workContent.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //设置label的最大行数
    self.workContent.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.workContent.text sizeWithFont:self.workContent.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.workContent.frame = CGRectMake(15, 93, WIDETH-30, labelSize.height);
  self.editDeleteView.frame = CGRectMake(WIDETH-140, 95+labelSize.height, 140, 35);
    //计算出自适应的高度
    frame.size.height = labelSize.height+90+50;
    
    self.frame = frame;


}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
