//
//  SearchCity2_ViewController.h
//  EggShell
//
//  Created by 太和 on 15/9/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchCity2_VCDelegate2 <NSObject>

- (void)chooseWord2_SearchCity:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id;
@end

@interface SearchCity2_ViewController : UIViewController

@property (nonatomic, strong) id jobScreeningVC;
@property(nonatomic,copy)NSString * titleText;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, assign) NSInteger tableViewTagIndex;
@property (nonatomic, weak) id<SearchCity2_VCDelegate2>delegete;

//@property (nonatomic, weak) id<writeJLChooseVCDelegate1>delegete;
@property(nonatomic,strong)NSArray * DataArray;

@end
