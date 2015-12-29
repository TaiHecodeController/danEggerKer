//
//  CertificateCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "CertificateCell.h"

@implementation CertificateCell
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
    //颁发时间
    self.awardTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 12)];
    self.awardTime.font = [UIFont systemFontOfSize:12];
    self.awardTime.textColor = UIColorFromRGB(0x000000);
    self.awardTime.text = @"暂无";
    [self.contentView addSubview:self.awardTime];
    //职位全称
    self.certificateName = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, WIDETH-30, 12)];
    self.certificateName.font = [UIFont systemFontOfSize:12];
    self.certificateName.textColor = UIColorFromRGB(0x000000);
    self.certificateName.text = @"暂无";
    [self.contentView addSubview:self.certificateName];
    //颁发单位
    self.awardCompany = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, WIDETH-30, 12)];
    self.awardCompany.font = [UIFont systemFontOfSize:12];
    self.awardCompany.textColor = UIColorFromRGB(0x000000);
    self.awardCompany.text = @"暂无";
    [self.contentView addSubview:self.awardCompany];
    //证书描述
    UILabel * proIntroduceHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 70, WIDETH, 12)];
    proIntroduceHeadLable.text = @"内容:";
    proIntroduceHeadLable.font = [UIFont systemFontOfSize:12];
    proIntroduceHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:proIntroduceHeadLable];
    self.certificateIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 92, WIDETH-30, 50)];
    self.certificateIntroduce.font = [UIFont systemFontOfSize:12];
    self.certificateIntroduce.textColor = UIColorFromRGB(0x000000);
    self.certificateIntroduce.text = @"暂无";
    [self.contentView addSubview:self.certificateIntroduce];
    
    
}
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
    //    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary *dataDic = dataArray[i];
    if(dataDic.count == 0)
    {
        return;
    }
    
    self.awardTime.text = dataDic[@"sdate"];
    self.certificateName.text = dataDic[@"name"];
    
    self.awardCompany.text = dataDic[@"title"];
    self.certificateIntroduce.text = dataDic[@"content"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
