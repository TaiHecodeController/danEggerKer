//
//  JobIntentionCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "JobIntentionCell.h"

@implementation JobIntentionCell

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
// 期望职位
    UILabel * exceptJobHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    exceptJobHeadLable.text = @"期望职位:";
    exceptJobHeadLable.font = [UIFont systemFontOfSize:12];
    exceptJobHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:exceptJobHeadLable];
    self.exceptJob = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-75, 12)];
    self.exceptJob.font = [UIFont systemFontOfSize:12];
    self.exceptJob.textColor = UIColorFromRGB(0x000000);
    self.exceptJob.text = @"暂无";
    [self.contentView addSubview:self.exceptJob];
    //期望行业
    UILabel * exceptIndustryHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    exceptIndustryHeadLable.text = @"期望行业:";
    exceptIndustryHeadLable.font = [UIFont systemFontOfSize:12];
    exceptIndustryHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:exceptIndustryHeadLable];
    self.exceptIndustry = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-75, 12)];
    self.exceptIndustry.font = [UIFont systemFontOfSize:12];
    self.exceptIndustry.textColor = UIColorFromRGB(0x000000);
    self.exceptIndustry.text = @"暂无";
    [self.contentView addSubview:self.exceptIndustry];
    //待遇要求
    UILabel * exceptSalaryHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    exceptSalaryHeadLable.text = @"待遇要求:";
    exceptSalaryHeadLable.font = [UIFont systemFontOfSize:12];
    exceptSalaryHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:exceptSalaryHeadLable];
    self.exceptSalary = [[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-75, 12)];
    self.exceptSalary.font = [UIFont systemFontOfSize:12];
    self.exceptSalary.textColor = UIColorFromRGB(0x000000);
    self.exceptSalary.text = @"暂无";
    [self.contentView addSubview:self.exceptSalary];
    //工作地区
    UILabel * workAddressHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 76, 60, 12)];
    workAddressHeadLable.text = @"工作地区:";
    workAddressHeadLable.font = [UIFont systemFontOfSize:12];
    workAddressHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:workAddressHeadLable];
    self.workAddress = [[UILabel alloc] initWithFrame:CGRectMake(75, 76, WIDETH-75, 12)];
    self.workAddress.font = [UIFont systemFontOfSize:12];
    self.workAddress.textColor = UIColorFromRGB(0x000000);
    self.workAddress.text = @"暂无";
    [self.contentView addSubview:self.workAddress];
    //到岗时间
    UILabel * arriveTimeHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 98, 60, 12)];
    
    arriveTimeHeadLable.text = @"到岗时间:";
    arriveTimeHeadLable.font = [UIFont systemFontOfSize:12];
    arriveTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:arriveTimeHeadLable];
    self.arriveTime = [[UILabel alloc] initWithFrame:CGRectMake(75, 98, WIDETH-75, 12)];
    self.arriveTime.font = [UIFont systemFontOfSize:12];
    self.arriveTime.textColor = UIColorFromRGB(0x000000);
    self.arriveTime.text = @"暂无";
    [self.contentView addSubview:self.arriveTime];
    //求职状态
    UILabel *workStateHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 120, 60, 12)];
    workStateHeadLable.text = @"求职状态:";
    workStateHeadLable.font = [UIFont systemFontOfSize:12];
    workStateHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:workStateHeadLable];
    self.workState = [[UILabel alloc] initWithFrame:CGRectMake(75, 120, WIDETH-75, 12)];
    self.workState.font = [UIFont systemFontOfSize:12];
    self.workState.textColor = UIColorFromRGB(0x000000);
    self.workState.text = @"暂无";
    [self.contentView addSubview:self.workState];
    //职位性质
    UILabel * workNatureHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 142, 60, 12)];
    workNatureHeadLable.text = @"职位性质:";
    workNatureHeadLable.font = [UIFont systemFontOfSize:12];
    workNatureHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:workNatureHeadLable];
    self.workNature = [[UILabel alloc] initWithFrame:CGRectMake(75, 142, WIDETH-75  , 12)];
    self.workNature.font = [UIFont systemFontOfSize:12];
    self.workNature.textColor = UIColorFromRGB(0x000000);
    self.workNature.text = @"暂无";
    [self.contentView addSubview:self.workNature];


}
-(void)configValue:(NSDictionary*)dataDic
{
//    self.exceptJob.text = dataDic[@"job"][@"name"];
//    self.exceptIndustry.text = dataDic[@"hy"][@"name"];
//    self.exceptSalary.text = dataDic[@"salary"][@"name"];
//    self.workAddress.text = dataDic[@"area"][@"name"];
//    self.arriveTime.text = dataDic[@"dgtime"][@"name"];
//    self.workNature.text = dataDic[@"ctype"][@"name"];
//    self.workState.text = dataDic[@"jobst"][@"name"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //计算出自适应的高度
    frame.size.height = 165;
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
