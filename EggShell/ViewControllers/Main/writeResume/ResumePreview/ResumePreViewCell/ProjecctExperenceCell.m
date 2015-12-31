//
//  ProjecctExperenceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "ProjecctExperenceCell.h"
#import "EditdelegateView.h"
@implementation ProjecctExperenceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{ UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, .5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.contentView addSubview:lineView];
    //项目时间
    UILabel * projectTimeHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    projectTimeHeadLable.text = @"项目时间:";
    projectTimeHeadLable.font = [UIFont systemFontOfSize:12];
    projectTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:projectTimeHeadLable];
     self.projectTime = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-90, 12)];
     self.projectTime.font = [UIFont systemFontOfSize:12];
     self.projectTime.textColor = UIColorFromRGB(0x000000);
     self.projectTime.text = @"暂无";
    [self.contentView addSubview:self.projectTime];
//职位名称
    UILabel *positionHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    positionHeadLable.text = @"担任职位:";
    positionHeadLable.font = [UIFont systemFontOfSize:12];
    positionHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:positionHeadLable];
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-90, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //项目名称
    UILabel * proNameHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    proNameHeadLable.text = @"项目名称:";
    proNameHeadLable.font = [UIFont systemFontOfSize:12];
    proNameHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:proNameHeadLable];
    self.proName = [[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-90, 12)];
    self.proName.font = [UIFont systemFontOfSize:12];
    self.proName.textColor = UIColorFromRGB(0x000000);
    self.proName.text = @"暂无";
    [self.contentView addSubview:self.proName];
    //项目内容
    UILabel * proIntroduceHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 74, WIDETH, 12)];
    proIntroduceHeadLable.text = @"项目内容:";
    proIntroduceHeadLable.font = [UIFont systemFontOfSize:12];
    proIntroduceHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:proIntroduceHeadLable];
    self.proIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 94, WIDETH-30, 50)];
    self.proIntroduce.font = [UIFont systemFontOfSize:12];
    self.proIntroduce.textColor = UIColorFromRGB(0x000000);
    self.proIntroduce.text = @"暂无";
    [self.contentView addSubview:self.proIntroduce];

    EditdelegateView * editDelete = [[EditdelegateView alloc] initWithFrame:CGRectMake(WIDETH - 140, 142, 140, 35)];
    [self.contentView addSubview:editDelete];
    editDelete.ediBtn.tag = 10;
    editDelete.delgateBtn.tag = 11;
    [editDelete.ediBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
    [editDelete.delgateBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
     self.editDeleteView = editDelete;
}
-(void)editBtbClick:(UIButton*)sender
{
    self.editDeleteBlock(sender.tag,self.tag);
}
-(void)conFigValues:(NSDictionary *)dataDic
{
        NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.projectTime.text = [NSString stringWithFormat:@"%@ 到 %@",startTime,endTime];
    
    self.position.text = dataDic[@"title"];
    self.proName.text = dataDic[@"name"];
    self.proIntroduce.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //设置label的最大行数
    self.proIntroduce.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.proIntroduce.text sizeWithFont:self.proIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.proIntroduce.frame = CGRectMake(15, 90, WIDETH-30, labelSize.height);
    self.editDeleteView.frame = CGRectMake(WIDETH-140, 90+labelSize.height, 140, 35);
    //计算出自适应的高度
    frame.size.height = labelSize.height+90+40;
    
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
