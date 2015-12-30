//
//  personResumeCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "personResumeCell.h"

@implementation personResumeCell

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
//年龄性别
    self.nameSexAge = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 16)];
    self.nameSexAge.font= [UIFont systemFontOfSize:16];
    self.nameSexAge.textColor = UIColorFromRGB(0x000000);
    self.nameSexAge.text = @"暂无";
    [self.contentView addSubview:self.nameSexAge];
    //学历
    UILabel * adademicHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 60, 12)];
    adademicHeadLable.text = @"学历:";
    adademicHeadLable.font = [UIFont systemFontOfSize:12];
    adademicHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:adademicHeadLable];
    self.adademic = [[UILabel alloc] initWithFrame:CGRectMake(75, 45, 200, 12)];
    self.adademic.font = [UIFont systemFontOfSize:12];
    self.adademic.textColor = UIColorFromRGB(0x000000);
    self.adademic.text = @"暂无";
    [self.contentView addSubview:self.adademic];
    //经验
    UILabel * experienceHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 67, 60, 12)];
    experienceHeadLable.text = @"经验:";
    experienceHeadLable.font = [UIFont systemFontOfSize:12];
    experienceHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:experienceHeadLable];
    self.experience = [[UILabel alloc] initWithFrame:CGRectMake(75, 67, 200, 12)];
    self.experience.font = [UIFont systemFontOfSize:12];
    self.experience.textColor = UIColorFromRGB(0x000000);
    self.experience.text = @"暂无";
    [self.contentView addSubview:self.experience];
//所在地
    UILabel * addressHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 89, 60, 12)];
    addressHeadLable.text = @"所在地:";
    addressHeadLable.font = [UIFont systemFontOfSize:12];
    addressHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:addressHeadLable];
    self.address =[[UILabel alloc] initWithFrame:CGRectMake(75, 89, WIDETH - 75, 12)];
    self.address.font = [UIFont systemFontOfSize:12];
    self.address.textColor = UIColorFromRGB(0x000000);
    self.address.text = @"暂无";
    [self.contentView addSubview:self.address];
    //联系手机
    UILabel * phoneNumHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 111, 60, 12)];
    phoneNumHeadLable.text = @"联系手机:";
    phoneNumHeadLable.font = [UIFont systemFontOfSize:12];
    phoneNumHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:phoneNumHeadLable];
    self.phoneNum = [[UILabel alloc] initWithFrame:CGRectMake(75, 111, 200, 12)];
    self.phoneNum.font = [UIFont systemFontOfSize:12];
    self.phoneNum.textColor = UIColorFromRGB(0x000000);
    self.phoneNum.text = @"暂无";
    [self.contentView addSubview:self.phoneNum];
    //电子邮件
    UILabel * emailHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 133, 60, 12)];
    emailHeadLable.text = @"电子邮件:";
    emailHeadLable.font = [UIFont systemFontOfSize:12];
    emailHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:emailHeadLable];
    self.email =[[UILabel alloc] initWithFrame:CGRectMake(75, 133, WIDETH-133, 12)];
    self.email.font = [UIFont systemFontOfSize:12];
    self.email.textColor = UIColorFromRGB(0x000000);
    self.email.text = @"暂无";
    [self.contentView addSubview:self.email];
    
}
-(void)configVulue:(NSDictionary *)dataDic
{
    if(dataDic.count == 0)
    {
        self.hidden = YES;
    }else
    {
        self.hidden = NO;
    }
    self.nameSexAge.text = [NSString stringWithFormat:@"%@ %@ %@岁",dataDic[@"uname"],dataDic[@"sex"][@"name"],dataDic[@"birthday"]];
    self.adademic.text = dataDic[@"edu"][@"name"];
    self.experience.text = dataDic[@"exp"][@"name"];
    self.address.text = dataDic[@"address"];
    self.email.text= dataDic[@"email"];
    self.phoneNum.text = dataDic[@"telphone"];
    
}
-(void)setIntroductionText:(NSString*)text
{
    //获得当前cell高度
    CGRect frame = [self frame];
    //计算出自适应的高度
    frame.size.height = 155;
    
    self.frame = frame;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
