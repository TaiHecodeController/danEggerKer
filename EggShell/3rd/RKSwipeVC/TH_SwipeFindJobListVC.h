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


@property (nonatomic, copy) NSString *longtitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *edu;
@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *fbtime;
@property (nonatomic, copy) NSString *hy;
@property (nonatomic, copy) NSString *job1;
@property (nonatomic, copy) NSString *job1_son;
@property (nonatomic, copy) NSString *job_post;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *provinceid;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *three_cityid;
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;
@property(nonatomic,strong)NSString * TipStr;

@end
