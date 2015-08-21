//
//  UIBarButtonItem+Extension.m
//  
//
//
//  Copyright (c) 2015年 RenCH. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itermWithTarget:(id)target Action:(SEL)action Image:(NSString *)image HighImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    CGSize size = btn.currentBackgroundImage.size;
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
