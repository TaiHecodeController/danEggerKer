//
//  playDetailTitleView.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "playDetailTitleView.h"
#import "ItemTimeView.h"
@implementation playDetailTitleView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView
{
    
//    //活动logo
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, WIDETH/16.0*9.0)];
    logoImageView.image = [UIImage imageNamed:@"logoSencond"];
    self.logoImageView = logoImageView;
    [self addSubview:logoImageView];
       //活动标题
    UILabel * eventTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5, WIDETH-20, 15)];
    eventTitleLable.text = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
    eventTitleLable.font = [UIFont systemFontOfSize:15];
    eventTitleLable.textColor = UIColorFromRGB(0x000000);
    [self addSubview:eventTitleLable];
    self.eventTitleLalbel = eventTitleLable;
    //主办方
    UILabel * organizersHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15, 56, 13)];
    organizersHeadLable.text = @"主 办 方:";
    organizersHeadLable.textColor = UIColorFromRGB(0x000000);
    organizersHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:organizersHeadLable];
    UILabel *  organizersLable =[[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15, WIDETH-72, 13)];
    organizersLable.text = @"北京蛋壳无限科技有限公司";
    organizersLable.textColor = UIColorFromRGB(0x646464);
    organizersLable.font = [UIFont systemFontOfSize:13];
    self.organizersLable = organizersLable;
    [self addSubview:organizersLable];
    //举办时间
    UILabel *holdTimeHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15+10+13, 56, 13)];
    holdTimeHeadLable.text = @"举办时间:";
    holdTimeHeadLable.textColor = UIColorFromRGB(0x000000);
    holdTimeHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:holdTimeHeadLable];
    UILabel *  holdTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15+10+13, WIDETH-72, 13)];
    holdTimeLable.text = @"2015-01-09至2016-01-09";
    holdTimeLable.textColor = UIColorFromRGB(0x646464);
    holdTimeLable.font = [UIFont systemFontOfSize:13];
    self.holdTimeLable = holdTimeLable;
    [self addSubview:holdTimeLable];
    //举办地点
    UILabel * holdAddressHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15+10*2+13*2, 56, 13)];
    holdAddressHeadLable.text = @"举办地点:";
    holdAddressHeadLable.textColor = UIColorFromRGB(0x000000);
    holdAddressHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:holdAddressHeadLable];
    UILabel *   holdAddressLable = [[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15+10*2+13*2, WIDETH-72, 13)];
    holdAddressLable.text = @"各大高校";
    holdAddressLable.textColor = UIColorFromRGB(0x646464);
    holdAddressLable.font = [UIFont systemFontOfSize:13];
    self.holdAddressLable = holdAddressLable;
    [self addSubview:holdAddressLable];
    //咨询电话
    UILabel * supporthotlineHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15+10*3+13*3, 56, 13)];
    supporthotlineHeadLable.text = @"咨询电话:";
    supporthotlineHeadLable.textColor = UIColorFromRGB(0x000000);
    supporthotlineHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:supporthotlineHeadLable];
    UILabel *   supporthotlineLable =[[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15+10*3+13*3, WIDETH-82, 13)];
    supporthotlineLable.text = @"400-123456";
    supporthotlineLable.textColor = UIColorFromRGB(0x646464);
    supporthotlineLable.font = [UIFont systemFontOfSize:13];
    self.supporthotlineLable = supporthotlineLable;
    [self addSubview:supporthotlineLable];
    //联系人
    UILabel * connectPersonHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15+10*4+13*4, 56, 13)];
    connectPersonHeadLable.text = @"联 系 人:";
    connectPersonHeadLable.textColor = UIColorFromRGB(0x000000);
    connectPersonHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:connectPersonHeadLable];

    UILabel *   connectPersonLable = [[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15+10*4+13*4, WIDETH-82, 13)];
    connectPersonLable.text = @"王先生";
    connectPersonLable.textColor = UIColorFromRGB(0x646464);
    connectPersonLable.font = [UIFont systemFontOfSize:13];
    self.connectPersonLable = connectPersonLable;
    [self addSubview:connectPersonLable];
        //交通路线
    UILabel * trafficRoutesHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(10, WIDETH/16.0*9.0+5+10+15+10*5+13*5, 56, 13)];
    trafficRoutesHeadLable.text = @"交通路线:";
    trafficRoutesHeadLable.textColor = UIColorFromRGB(0x000000);
    trafficRoutesHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:trafficRoutesHeadLable];
    
    UILabel *   trafficRoutesLable = [[UILabel alloc] initWithFrame:CGRectMake(72, WIDETH/16.0*9.0+5+10+15+10*5+13*5, WIDETH-82, 13)];
    trafficRoutesLable.text = @"203公交，203公交，203公交，203公交，203公交";
    trafficRoutesLable.textColor = UIColorFromRGB(0x646464);
    trafficRoutesLable.font = [UIFont systemFontOfSize:13];
    trafficRoutesLable.numberOfLines = 0;
    self.trafficRoutesLable = trafficRoutesLable;
    [self addSubview:trafficRoutesLable];
  
    ItemTimeView * itemView = [[ItemTimeView alloc] initWithFrame:CGRectMake(WIDETH-82, WIDETH/16.0*9.0+5+10+15+10*5+13*6+20, 72,12)];
    self.itemView = itemView;
    [self addSubview:itemView];
}
-(void)configValue:(NSDictionary*)dic
{
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"logoSencond"]];
    self.eventTitleLalbel.text = dic[@"title"];
    self.organizersLable.text = dic[@"organizers"];
    self.holdTimeLable.text = [NSString stringWithFormat:@"%@至%@",dic[@"starttime"],dic[@"endtime"]];
    self.holdAddressLable.text = dic[@"address"];
    self.supporthotlineLable.text = dic[@"telphone"];
    self.connectPersonLable.text = dic[@"user"];
    self.trafficRoutesLable.text = dic[@"trafficRoutesLable"];
    self.itemView.collectionNumberTitleLable.text = dic[@"collect_count"];
    self.itemView.commendNumberTitleLable.text = dic[@"apply_count"];
    
}
@end
