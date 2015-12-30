//
//  CertificateCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "CertificateCell.h"
#import "EditdelegateView.h"
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
    UILabel * awardTimeHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    awardTimeHeadLable.text = @"颁发时间:";
    awardTimeHeadLable.font = [UIFont systemFontOfSize:12];
    awardTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:awardTimeHeadLable];

    self.awardTime = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-90, 12)];
    self.awardTime.font = [UIFont systemFontOfSize:12];
    self.awardTime.textColor = UIColorFromRGB(0x000000);
    self.awardTime.text = @"暂无";
    [self.contentView addSubview:self.awardTime];
    //职位全称
    UILabel * certificateNameHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    certificateNameHeadLable.text = @"证书全称:";
    certificateNameHeadLable.font = [UIFont systemFontOfSize:12];
    certificateNameHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:certificateNameHeadLable];
    self.certificateName = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-90, 12)];
    self.certificateName.font = [UIFont systemFontOfSize:12];
    self.certificateName.textColor = UIColorFromRGB(0x000000);
    self.certificateName.text = @"暂无";
    [self.contentView addSubview:self.certificateName];
    //颁发单位
    UILabel * awardCompanyHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    awardCompanyHeadLable.text = @"颁发单位:";
    awardCompanyHeadLable.font = [UIFont systemFontOfSize:12];
    awardCompanyHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:awardCompanyHeadLable];
    self.awardCompany = [[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-90, 12)];
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
-(void)configValue:(NSDictionary *)dataDic
{
    
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
       self.awardTime.text = startTime;
    self.certificateName.text = dataDic[@"name"];
    
    self.awardCompany.text = dataDic[@"title"];
    self.certificateIntroduce.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
//    self.certificateIntroduce.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.certificateIntroduce.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.certificateIntroduce.text sizeWithFont:self.certificateIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.certificateIntroduce.frame = CGRectMake(15, 94, WIDETH-30, labelSize.height);
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
