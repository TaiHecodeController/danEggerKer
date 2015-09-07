//
//  MineEditVC.h
//  EggShell
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineEditVC : UIViewController
@property (strong,nonatomic)NSMutableArray * jobCellArray;
@property(nonatomic,strong)NSMutableArray * birthdayCellArray;
@property(nonatomic,copy) NSString * telphone;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,assign) int sex;
@property(nonatomic,copy) NSString * address;
@property(nonatomic,copy) NSString * descriptions;
@property(nonatomic,copy) NSString * birthday;
@property(nonatomic,copy) NSString * email;
@end
