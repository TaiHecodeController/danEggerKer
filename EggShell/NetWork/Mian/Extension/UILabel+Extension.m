//
//  UILabel+Extension.m
//  致学干部课堂
//
//  Created by Qingyun on 15/3/22.
//  Copyright (c) 2015年 RenCH. All rights reserved.
//

#import "UILabel+Extension.h"

static BOOL _isShow;

@implementation UILabel (Extension)
+ (void)showWithTitle:(NSString *)text viewControll:(UIViewController *)showVC LableRect:(CGRect)lableRect animationY:(float)animationY
{
    if (!_isShow)
    {
        _isShow = YES;
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor lightGrayColor];
        label.alpha = 0.0;
        label.font = [UIFont systemFontOfSize:16];
        label.text = text;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.frame = lableRect;
        [UIView animateWithDuration:0.5 animations:^{
            [showVC.view addSubview:label];
            label.alpha = 1.0;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1.0 animations:^{
                    label.alpha = 0.0;
                }];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [label removeFromSuperview];
                    _isShow = NO;
                });
            });
        }];
    }
}
@end
