//
//  UIButton+Extension.h
//  button
//
//  Created by aitaomama-ios on 15/9/5.
//  Copyright (c) 2015年 Beijing Aitao Mother Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)
/**
 *  为button加载网络图片
 *
 *  @param urlStr 网络连接
 */
- (void)setButtonImageWithUrl:(NSString *)urlStr;
@end
