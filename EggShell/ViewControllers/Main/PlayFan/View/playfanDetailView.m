//
//  playfanDetailView.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "playfanDetailView.h"

@implementation playfanDetailView

-(id)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        [self createView    ];
    }
    return self;
}
-(void)createView
{
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, .5)];
    lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self addSubview:lineView];
    //招聘会介绍
    UILabel * recruitmentIntroducedHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 13)];
    recruitmentIntroducedHeadLable.text = @"招聘会介绍:";
    recruitmentIntroducedHeadLable.textColor = UIColorFromRGB(0x000000);
    recruitmentIntroducedHeadLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:recruitmentIntroducedHeadLable];
    UILabel *   recruitmentIntroducedLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15+13, WIDETH-30, 120)];
    recruitmentIntroducedLable.text = @"北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司北京蛋壳无限科技有限公司";
    recruitmentIntroducedLable.numberOfLines = 0;
    recruitmentIntroducedLable.textColor = UIColorFromRGB(0x646464);
    recruitmentIntroducedLable.font = [UIFont systemFontOfSize:13];
    self.recruitmentIntroducedLable = recruitmentIntroducedLable;
    [self addSubview:recruitmentIntroducedLable];

    
}
@end
