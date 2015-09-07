//
//  UIButton+Extension.m
//  button
//
//  Created by aitaomama-ios on 15/9/5.
//  Copyright (c) 2015年 Beijing Aitao Mother Technology Co., Ltd. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setButtonImageWithUrl:(NSString *)urlStr{
    NSURL * url = [NSURL URLWithString:urlStr];
    // 根据图片的url下载图片数据
    dispatch_queue_t Queue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(Queue, ^{
        // 异步下载图片
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:img forState:UIControlStateNormal];
        
        });
    });
}


@end
