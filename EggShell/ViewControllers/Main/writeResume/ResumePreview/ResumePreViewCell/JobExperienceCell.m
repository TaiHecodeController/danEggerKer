//
//  JobExperienceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "JobExperienceCell.h"

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
    self.workTime =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-15, 12)];
    self.workTime.font = [UIFont systemFontOfSize:12];
    self.workTime.textColor = UIColorFromRGB(0x000000);
    self.workTime.text = @"暂无";
    [self.contentView addSubview:self.workTime];
    //工作职位
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, WIDETH-15, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //公司标题
    self.titleLab =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, WIDETH-15, 12)];
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
    
}
-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
    //    NSDictionary * dataDic = [dataArray firstObject];
   
        NSDictionary *dataDic = dataArray[i];
        NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
        NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
        NSString * startTime = [Utils changeTimeToString:sdate];
        NSString * endTime = [Utils changeTimeToString:edate];
        self.workTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    
        self.position.text = dataDic[@"title"];
        self.titleLab.text = dataDic[@"name"];
        self.workContent.text = dataDic[@"content"];
    
//    NSDictionary *dataDic = dataArray[i];
//    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
//    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
//    NSString * startTime = [Utils changeTimeToString:sdate];
//    NSString * endTime = [Utils changeTimeToString:edate];
//    self.workTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
//    
//    self.position.text = dataDic[@"title"];
//    self.titleLab.text = dataDic[@"name"];
//    self.workContent.text = dataDic[@"content"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
