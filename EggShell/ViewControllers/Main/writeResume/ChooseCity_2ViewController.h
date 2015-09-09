//
//  ChooseCity_2ViewController.h
//  EggShell
//
//  Created by 太和 on 15/9/9.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCity_2ViewController : UIViewController

@property(nonatomic,copy)NSString * titleText;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, assign) NSInteger tableViewTagIndex;
//@property (nonatomic, weak) id<writeJLChooseVCDelegate1>delegete;
@property(nonatomic,strong)NSArray * DataArray;

@end
