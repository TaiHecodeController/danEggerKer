//
//  CompanyMessageView.h
//  EggShell
//
//  Created by mac on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyMessageView : UIView
@property (strong,nonatomic)UIImage * logoImage;
@property (strong,nonatomic)void(^showAllClick)(UIButton *);
@property (strong,nonatomic)UIButton * showAllBtn;
@property (assign) CGSize textSize;
@property (strong,nonatomic)UILabel * companyMessage;
@end
