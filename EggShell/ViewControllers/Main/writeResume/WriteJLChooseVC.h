//
//  WriteJLChooseVC.h
//  EggShell
//
//  Created by 太和 on 15/8/21.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol writeJLChooseVCDelegate <NSObject>

- (void)chooseWord:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id;

@end

@interface WriteJLChooseVC : UIViewController

//@property(nonatomic,strong)NSArray * DataArray;
@property(nonatomic,copy)NSString * titleText;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, assign) NSInteger tableViewTagIndex;
@property (nonatomic, weak) id<writeJLChooseVCDelegate>delegete;
@property(nonatomic,strong)NSMutableArray * DataArray;

@end
