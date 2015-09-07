//
//  TH_JobDetailVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"
#import "ComPanyProfileView.h"
@interface TH_JobDetailVC : TH_BaseVC
@property(nonatomic,strong)ComPanyProfileView *  CMview;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,strong)MJRefreshFooterView * footer;

@property (nonatomic, assign) int uid;
@property (nonatomic, assign) int pid;
//0是从收藏职位列表跳过来的，1不是从收藏职位列表跳过来的
@property (nonatomic, assign) int saveBOOL;
@end
