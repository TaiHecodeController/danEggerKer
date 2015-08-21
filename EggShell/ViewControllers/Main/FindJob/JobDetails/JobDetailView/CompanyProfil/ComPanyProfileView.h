//
//  ComPanyProfileView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/20.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComPanyProfileView;
@protocol companyProfileViewDelegate <NSObject>

-(void)CompanyProfilView :(ComPanyProfileView*)companyView;

@end
@interface ComPanyProfileView : UIView
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UILabel * companyFile;
@property(nonatomic,strong)UILabel * detailLable;
@property(nonatomic,strong)UIButton * selectBtn;
@property(nonatomic,assign)CGSize textSize;
@property(nonatomic,strong)id<companyProfileViewDelegate>delegate;
-(void)config:(NSString *)str;
@end
