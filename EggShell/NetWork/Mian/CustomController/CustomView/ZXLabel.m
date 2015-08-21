//
//  ZXLabel.m
//  致学在线
//
//  Created by zhixue on 15/5/14.
//  Copyright (c) 2015年 ZQZX. All rights reserved.
//

#import "ZXLabel.h"

@implementation ZXLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.font = [UIFont systemFontOfSize:20];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end
