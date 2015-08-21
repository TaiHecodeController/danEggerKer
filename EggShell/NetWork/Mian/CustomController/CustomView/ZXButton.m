//
//  ZXButton.m
//  致学干部课堂
//
//  Created by zhixue on 15/5/21.
//  Copyright (c) 2015年 ZQZX. All rights reserved.
//

#import "ZXButton.h"

@implementation ZXButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
@end
