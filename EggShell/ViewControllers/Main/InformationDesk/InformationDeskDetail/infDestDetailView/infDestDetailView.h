//
//  infDestDetailView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "playFanModel.h"
@interface infDestDetailView : UIView
@property (weak, nonatomic) IBOutlet UILabel *holdLable;
@property (weak, nonatomic) IBOutlet UILabel *timelLable;
@property (weak, nonatomic) IBOutlet UILabel *contactLable;
@property (weak, nonatomic) IBOutlet UILabel *contactPesonLable;
@property (weak, nonatomic) IBOutlet UILabel *RouteLable;
-(void)setValue:(playFanModel*)model;
@end
