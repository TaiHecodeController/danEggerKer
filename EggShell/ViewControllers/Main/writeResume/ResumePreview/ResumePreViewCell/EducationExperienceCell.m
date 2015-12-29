//
//  EducationExperienceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EducationExperienceCell.h"

@implementation EducationExperienceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{//教育时间
    self.educationTime =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 12)];
    self.educationTime.font = [UIFont systemFontOfSize:12];
    self.educationTime.textColor = UIColorFromRGB(0x000000);
    self.educationTime.text = @"暂无";
    [self.contentView addSubview:self.educationTime];
    //所学专业
    self.department = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, WIDETH-30, 12)];
    self.department.font = [UIFont systemFontOfSize:12];
    self.department.textColor = UIColorFromRGB(0x000000);
    self.department.text = @"暂无";
    [self.contentView addSubview:self.department];
    //所在学校
    self.schoolName =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, WIDETH-30, 12)];
    self.schoolName.font = [UIFont systemFontOfSize:12];
    self.schoolName.textColor = UIColorFromRGB(0x000000);
    self.schoolName.text = @"暂无";
    [self.contentView addSubview:self.schoolName];
    //担任职位
    UILabel * positionHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 76, 60, 12)];
    positionHeadLable.font = [UIFont systemFontOfSize:12];
    positionHeadLable.textColor = UIColorFromRGB(0x000000);
    positionHeadLable.text = @"担任职位";
    [self.contentView addSubview:positionHeadLable];
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(75, 76, WIDETH-75, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //专业描述
    UILabel * descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 96, WIDETH-30, 12)];
    descriptionLable.text = @"专业描述";
    descriptionLable.font = [UIFont systemFontOfSize:12];
    descriptionLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:descriptionLable];
    self.departmentIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 118, WIDETH-30, 60)];
    self.departmentIntroduce.font = [UIFont systemFontOfSize:12];
    self.departmentIntroduce.textColor = UIColorFromRGB(0x000000);
    self.departmentIntroduce.text = @"暂无";
    [self.contentView addSubview:self.departmentIntroduce];
    
    
}
-(void)configVulue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
    //    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary * dataDic = dataArray[i];
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.educationTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    self.department.text = dataDic[@"specialty"];
    self.schoolName.text = dataDic[@"name"];
    self.position.text = dataDic[@"title"];
    self.departmentIntroduce.text = dataDic[@"content"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
