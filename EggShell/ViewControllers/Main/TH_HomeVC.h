//
//  TH_HomeVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "MJRefresh.h"

@interface TH_HomeVC : TH_BaseVC
@property (strong,nonatomic)MJRefreshFooterView * footer;
@property (strong,nonatomic)MJRefreshHeaderView * header;

@end
