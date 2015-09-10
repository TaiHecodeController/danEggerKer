//
//  SearchCity3_ViewController.h
//  EggShell
//
//  Created by 太和 on 15/9/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchCity3_VCDelegate3 <NSObject>

- (void)chooseWord3_SearchCity:(NSString *)keyWord cellIndex:(NSIndexPath *)cellIndex tableViewTagIndex:(NSInteger)tableViewTagIndex withId:(NSString *)Id;

@end

@interface SearchCity3_ViewController : UIViewController

@property(nonatomic,copy)NSString * titleText;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, assign) NSInteger tableViewTagIndex;
@property (nonatomic, weak) id<SearchCity3_VCDelegate3>delegete;
@property(nonatomic,strong)NSArray * DataArray;

@end
