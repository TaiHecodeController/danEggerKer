//
//  TH_BaseVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TH_BaseVC : UIViewController

//添加右侧第二个按钮
- (void)addRightBtn2_NormalImageName:(NSString *)nIcon hightImageName:(NSString *)hIcon action:(SEL)action target:(id)target;

@end
