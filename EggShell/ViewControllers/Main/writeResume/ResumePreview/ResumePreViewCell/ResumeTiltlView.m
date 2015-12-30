
//
//  ResumeTiltlView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "ResumeTiltlView.h"

@implementation ResumeTiltlView
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
    UILabel * myLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 13)];
    myLable.text = @"个人简历";
    myLable.font =[UIFont systemFontOfSize:13];
    myLable.textColor = [UIColor whiteColor];
    [self addSubview:myLable];
    
     self.personTileLable = myLable;
    UILabel * timeLable = [[UILabel alloc] initWithFrame:CGRectMake(WIDETH - 165, 9.5, 150, 11)];
    timeLable.text = @"创建于2015-08-03";
    timeLable.font =[UIFont systemFontOfSize:11];
    timeLable.textColor = UIColorFromRGB(0x646464);
    timeLable.textAlignment = NSTextAlignmentRight;
    self.createTimeLable  = timeLable;
    [self addSubview:timeLable];
    
}
@end