//
//  UIColor+RK_Color.m
//  EggShell
//
//  Created by 太和 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "UIColor+RK_Color.h"

@implementation UIColor (RK_Color)

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha
{
    CGFloat r = ((hexValue & 0x00FF0000) >> 16) / 255.0;
    CGFloat g = ((hexValue & 0x0000FF00) >> 8) / 255.0;
    CGFloat b = (hexValue & 0x000000FF) / 255.0;
    CGFloat a = alpha / 255.0;
    
    return [self colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue
{
    return [self colorWithHexValue:hexValue alpha:255];
}


@end
