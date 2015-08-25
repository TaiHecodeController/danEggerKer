//
//  MTGridView.h
//  TmallClient-iPhone
//
//  Created by hjy_x on 3/14/13.
//  Copyright (c) 2013 Tmall.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+RK_Color.h"


typedef enum
{
    MTGridViewItemStyleDefault,
}MTGridViewItemStyle;

typedef enum
{
    MTGridViewSeparateNone,
    MTGridViewSeparateGrayLine,
    MTGridViewSeparateHalfLine,
}MTGridViewSeparateStyle;

@interface MTGridViewItem : UIControl

- (id)initWithStyle:(MTGridViewItemStyle)style identifier:(NSString *)identifier;

@end

@class MTGridView;

@protocol MTGridViewDataSource <NSObject>

@required
- (int)numberOfRowAtGridView:(MTGridView *)gridView;

- (int)gridView:(MTGridView *)gridView numberOfColumnInRow:(int)row;

- (MTGridViewItem *)gridView:(MTGridView *)gridView itemForColumnAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (float)gridView:(MTGridView *)gridView widthOfItemAtIndexPath:(NSIndexPath *)indexPath;

- (float)gridView:(MTGridView *)gridView heightOfItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MTGridViewDelegate <UIScrollViewDelegate>

@optional
- (void)gridView:(MTGridView *)gridView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MTGridView : UIView

@property (nonatomic, assign) id<MTGridViewDataSource> dataSource;
@property (nonatomic, assign) id<MTGridViewDelegate> delegate;
@property (nonatomic, assign) float rowSpace;
@property (nonatomic, assign) float columnSpace;
@property (nonatomic, assign) UIEdgeInsets paddingEdge;
@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) MTGridViewSeparateStyle separateStyle;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *footerView;

- (MTGridViewItem *)dequeueReusableItemWithIdentifier:(NSString *)identifier atColIndex:(int)index;
- (MTGridViewItem *)gridViewItemAtIndexPath:(NSIndexPath *)indexPath;

- (UITableView *)gridTabelView;
- (void)reloadData;
@end
