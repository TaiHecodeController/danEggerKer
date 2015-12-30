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
{
    //项目时间
     self.projectTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 12)];
     self.projectTime.font = [UIFont systemFontOfSize:12];
     self.projectTime.textColor = UIColorFromRGB(0x000000);
     self.projectTime.text = @"暂无";
    [self.contentView addSubview:self.projectTime];
//职位
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, WIDETH-30, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //项目名称
    self.proName = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, WIDETH-30, 12)];
    self.proName.font = [UIFont systemFontOfSize:12];
    self.proName.textColor = UIColorFromRGB(0x000000);
    self.proName.text = @"暂无";
    [self.contentView addSubview:self.proName];
    //项目内容
    UILabel * proIntroduceHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 70, WIDETH, 12)];
    proIntroduceHeadLable.text = @"项目内容:";
    proIntroduceHeadLable.font = [UIFont systemFontOfSize:12];
    proIntroduceHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:proIntroduceHeadLable];
    self.proIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 92, WIDETH-30, 50)];
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
    self.editDeleteBlock(sender.tag);
}
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i
{
//    if(dataArray.count == 0)
//    {
//        return;
//    }
//    
//    //    NSDictionary * dataDic = [dataArray firstObject];
//    NSDictionary * dataDic = dataArray[i];
//    if(dataDic.count == 0)
//    {
//        return;
//    }
//    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
//    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
//    NSString * startTime = [Utils changeTimeToString:sdate];
//    NSString * endTime = [Utils changeTimeToString:edate];
//    self.projectTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
//    
//    self.position.text = dataDic[@"title"];
//    self.proName.text = dataDic[@"name"];
//    self.proIntroduce.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.proIntroduce.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.proIntroduce.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.proIntroduce.text sizeWithFont:self.proIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.proIntroduce.frame = CGRectMake(15, 94, WIDETH-15, labelSize.height);
    self.editDeleteView.frame = CGRectMake(WIDETH-140, 92+labelSize.height, 140, 35);
    //计算出自适应的高度
    frame.size.height = labelSize.height+92+45;
    
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
