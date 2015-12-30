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
    //工作职位
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
    //公司标题
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
    
    self.workContent = [[UILabel alloc] initWithFrame:CGRectMake(15, 94, WIDETH-30, 60)];
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
    self.editDeleteBlock(sender.tag);
}
-(void)configVulue:(NSDictionary *)dataDic withArrIndex:(int)i
{
//    if(dataArray.count == 0)
//    {
//        return;
//    }
//        NSDictionary * dataDic = [dataArray firstObject];
//    NSDictionary *dataDic = dataArray[i];
//    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
//    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
//    NSString * startTime = [Utils changeTimeToString:sdate];
//    NSString * endTime = [Utils changeTimeToString:edate];
//    self.workTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
//    self.position.text = dataDic[@"title"];
//    self.titleLab.text = dataDic[@"name"];
//    self.workContent.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.workContent.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.workContent.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.workContent.text sizeWithFont:self.workContent.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.workContent.frame = CGRectMake(15, 94, WIDETH-30, labelSize.height);
  self.editDeleteView.frame = CGRectMake(WIDETH-140, 94+labelSize.height, 140, 35);
    //计算出自适应的高度
    frame.size.height = labelSize.height+94+45;
    
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
