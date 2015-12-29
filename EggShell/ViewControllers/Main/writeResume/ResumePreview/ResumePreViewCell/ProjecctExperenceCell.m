//
//  ProjecctExperenceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "ProjecctExperenceCell.h"

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

    
}
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
    
    //    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary * dataDic = dataArray[i];
    if(dataDic.count == 0)
    {
        return;
    }
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.projectTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    
    self.position.text = dataDic[@"title"];
    self.proName.text = dataDic[@"name"];
    self.proIntroduce.text = dataDic[@"content"];
   }

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
