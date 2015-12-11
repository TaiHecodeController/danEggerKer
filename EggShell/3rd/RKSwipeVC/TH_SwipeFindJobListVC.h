//
//  TH_SwipeFindJobListVC.h
//  EggShell
//
//  Created by 太和 on 15/12/11.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "ZLSwipeableView.h"

@interface TH_SwipeFindJobListVC : TH_BaseVC<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate,ZLSwipeableViewDirectionInterpretor>

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end
