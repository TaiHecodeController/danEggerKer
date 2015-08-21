//
//  VersionUpdateView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/18.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VersionUpdateView : UIView

@property (weak, nonatomic) IBOutlet UIButton *ImmediatelyBtn;
@property (weak, nonatomic) IBOutlet UIButton *laterBtn;
@property(nonatomic,strong)UIView * backView;
-(void)showVersonView;
@end
