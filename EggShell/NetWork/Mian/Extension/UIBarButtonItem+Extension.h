//
//  UIBarButtonItem+Extension.h
//  
//
//  
//  Copyright (c) 2015年 RenCH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itermWithTarget:(id)target Action:(SEL)action Image:(NSString *)image HighImage:(NSString *)highImage;
@end
