//
//  ChooseCity_3ViewController.h
//  EggShell
//
//  Created by 太和 on 15/9/9.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol writeJLChooseVCDelegate3 <NSObject>

- (void)chooseWord3:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id;

@end

@interface ChooseCity_3ViewController : UIViewController

@property(nonatomic,copy)NSString * titleText;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, assign) NSInteger tableViewTagIndex;
@property (nonatomic, weak) id<writeJLChooseVCDelegate3>delegete;
@property(nonatomic,strong)NSArray * DataArray;


@end
