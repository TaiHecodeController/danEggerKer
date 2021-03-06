//
//  CompanyMessageView.m
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CompanyMessageView.h"
@interface CompanyMessageView ()
{
    UILabel * industryLab;
    UILabel * natureLab;
    UILabel * scaleLab;
    UILabel * addressLab;
    UILabel * companyIntroduce;
    CGRect record_Message;
    CGRect record_ShowAll;
    CGRect record_SelfView;
    
}
@end

@implementation CompanyMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self addSubview:lineView];
    
    UILabel * titileLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 50, 13)];
    titileLable.textColor = UIColorFromRGB(0x646464);
    titileLable.text  = @"行业:";
    titileLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:titileLable];
    industryLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 240, 13)];
    [self addSubview:industryLab];
    industryLab.text = @"计算机软件，IT服务，系统集成";
    industryLab.font = [UIFont systemFontOfSize:13];
    
    UILabel * natureTitileLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 50, 13)];
    natureTitileLable.textColor = UIColorFromRGB(0x646464);
    natureTitileLable.text  = @"性质:";
    natureTitileLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:natureTitileLable];

    natureLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 40, 240, 13)];
    natureLab.text = @"中外合资";
    natureLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:natureLab];
    
    
    UILabel * scaleTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 65, 50, 13)];
    scaleTitleLable.textColor = UIColorFromRGB(0x646464);
    scaleTitleLable.text  = @"规模:";
    scaleTitleLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:scaleTitleLable];
    scaleLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 65, 240, 13)];
    scaleLab.text = @"100人以上";
    scaleLab.font = [UIFont systemFontOfSize:13];
    [self addSubview:scaleLab];
    
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 50, 13)];
    addressLable.textColor = UIColorFromRGB(0x646464);
    addressLable.text  = @"地址:";
    addressLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:addressLable];
    addressLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 90, WIDETH - 60, 15)];
    
    addressLab.text = @"北京市朝阳区建国路2号中国惠普大厦";
//    addressLab.adjustsFontSizeToFitWidth = YES;
    addressLab.contentMode = UIViewContentModeTop;
    addressLab.font = [UIFont systemFontOfSize:12];
    addressLab.numberOfLines = 0;
    [self addSubview:addressLab];

    UIView * companyView = [[UIView alloc] initWithFrame:CGRectMake(15, 121, 2, 13)];
    companyView.backgroundColor = UIColorFromRGB(0x3ebb2b);
    [self addSubview:companyView];
    companyIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, WIDETH - 15, 15)];
    companyIntroduce.text = @"公司介绍";
    companyIntroduce.textColor = UIColorFromRGB(0x646464);
    companyIntroduce.font = [UIFont systemFontOfSize:13];
    [self addSubview:companyIntroduce];
    
    self.companyMessage = [[UILabel alloc] initWithFrame:CGRectMake(15, 138, WIDETH - 30, 80)];
    self.companyMessage.numberOfLines = 5;
    self.companyMessage.text = @"根据项目的需求，项目经理要求完成相关应用系统设计和系统开发，我当前的1大的多说的随处可见哈上帝对撒旦科技和打卡的期待和萨看到很多期待打可视电话期望的大都会区看万家灯火请问大家活动看得起万家灯火的简单好看却觉得好奇我看见的话去外地回去我看到机会去外地客户期望的借口";
    self.textSize = [self.companyMessage.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
    self.companyMessage.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.companyMessage];
    
    self.showAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showAllBtn.frame = CGRectMake((WIDETH -100)/2, 225, 100, 30);
    [self.showAllBtn setBackgroundImage:[UIImage imageNamed:@"showallBtnBlue"] forState:UIControlStateNormal];
    [self.showAllBtn setTitle:@"查看全部" forState:UIControlStateNormal];
    [self.showAllBtn setTitleColor:UIColorFromRGB(0X3ebb2b) forState:UIControlStateNormal];
    self.showAllBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.showAllBtn setTitle:@"点击收起" forState:UIControlStateSelected];
    [self.showAllBtn setImage:[UIImage imageNamed:@"chakanBlue"] forState:UIControlStateNormal ];
    [self.showAllBtn setImage:[UIImage imageNamed:@"shouqiBlue"] forState:UIControlStateSelected];
    self.showAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-115);
    self.showAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -33, 0, 0);
    [self.showAllBtn setTitleColor:UIColorFromRGB(0X3ebb2b) forState:UIControlStateSelected];
    
    [self.showAllBtn addTarget:self action:@selector(showAllClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.showAllBtn];
    
}
-(void)showAllClick:(UIButton *)sender
{
    self.showAllClick(sender);
}
-(void)configValue:(NSDictionary*)dic
{
    industryLab.text = [NSString stringWithFormat:@"%@",dic[@"hy"]];
    natureLab.text = [NSString stringWithFormat:@"%@",dic[@"pr"]];
     scaleLab.text = [NSString stringWithFormat:@"%@",dic[@"gm"]];
   addressLab.text = [NSString stringWithFormat:@"%@",dic[@"address"]];

    NSString *str =  [self flattenHTML:[NSString stringWithFormat:@"%@",dic[@"content"]] trimWhiteSpace:YES];
    self.companyMessage.text = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.textSize = [self.companyMessage.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
}
//去掉html标签
-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}
@end
