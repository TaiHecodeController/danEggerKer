//
//  TH_MineVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "TH_JobWishlistVC.h"
#import "MineVeiw.h"
@interface TH_MineVC : TH_BaseVC
@property(nonatomic,strong)MineVeiw * mineView;
@property(nonatomic,strong)void(^jobWilstBlock)(TH_JobWishlistVC * );
@end
