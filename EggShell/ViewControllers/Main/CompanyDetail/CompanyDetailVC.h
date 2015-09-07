//
//  CompanyDetailVC.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyMessageView.h"

@interface CompanyDetailVC : UIViewController
@property (strong,nonatomic)CompanyMessageView * CMview;
@property (strong,nonatomic)MJRefreshHeaderView * header;
@property (strong,nonatomic)MJRefreshFooterView * footer;
@property(nonatomic,copy) NSString *  businessUid;
@property(nonatomic,copy)  NSString * businessMid;;
@end
