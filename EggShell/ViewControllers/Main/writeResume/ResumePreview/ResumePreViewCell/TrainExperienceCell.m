//
//  TrainExperienceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TrainExperienceCell.h"
#import "EditdelegateView.h"
@implementation TrainExperienceCell
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
    //培训时间
    self.trainTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 12)];
    self.trainTime.font = [UIFont systemFontOfSize:12];
    self.trainTime.textColor = UIColorFromRGB(0x000000);
    self.trainTime.text = @"暂无";
    [self.contentView addSubview:self.trainTime];
    //培训方向
    self.trainDirection = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, WIDETH-30, 12)];
    self.trainDirection.font = [UIFont systemFontOfSize:12];
    self.trainDirection.textColor = UIColorFromRGB(0x000000);
    self.trainDirection.text = @"暂无";
    [self.contentView addSubview:self.trainDirection];
    //培训中心
    self.trainCompany = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, WIDETH-30, 12)];
    self.trainCompany.font = [UIFont systemFontOfSize:12];
    self.trainCompany.textColor = UIColorFromRGB(0x000000);
    self.trainCompany.text = @"暂无";
    [self.contentView addSubview:self.trainCompany];
    //培训内容
    UILabel * proIntroduceHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 70, WIDETH, 12)];
    proIntroduceHeadLable.text = @"培训内容:";
    proIntroduceHeadLable.font = [UIFont systemFontOfSize:12];
    proIntroduceHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:proIntroduceHeadLable];
    self.trainIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 92, WIDETH-30, 50)];
    self.trainIntroduce.font = [UIFont systemFontOfSize:12];
    self.trainIntroduce.textColor = UIColorFromRGB(0x000000);
    self.trainIntroduce.text = @"暂无";
    [self.contentView addSubview:self.trainIntroduce];
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
//    self.trainTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
//    
//    self.trainDirection.text = dataDic[@"title"];
//    self.trainCompany.text = dataDic[@"name"];
//    self.trainIntroduce.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.trainIntroduce.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.trainIntroduce.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.trainIntroduce.text sizeWithFont:self.trainIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.trainIntroduce.frame = CGRectMake(15, 94, WIDETH-15, labelSize.height);
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