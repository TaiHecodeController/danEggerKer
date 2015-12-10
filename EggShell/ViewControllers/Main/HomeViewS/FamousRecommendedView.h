//
//  FamousRecommendedView.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FamousRecommendedView;
@protocol FamousRecommendedViewDelegate <NSObject>
-(void)FamousRecommendedViewJob:(FamousRecommendedView*)HotJobView DidClickButton:(int)tag;
@end

@interface FamousRecommendedView : UIView
@property(nonatomic,assign)id<FamousRecommendedViewDelegate>famousRecommendedViewDelegate;
@property(nonatomic,strong)UIImageView * famoutsRecruitImageView;
@property(nonatomic,strong)UIButton * first;
@property(nonatomic,strong)UIButton * second;
@property(nonatomic,strong)UIButton * three;
@property(nonatomic,strong)UIButton * fourth;
@property(nonatomic,strong)UIButton * five;
@property(nonatomic,strong)UIButton * six;
@property(nonatomic,strong)UIButton * seven;
@property(nonatomic,strong)UIButton * eight;
@property(nonatomic,strong)UIButton * nine;

@property(nonatomic,strong)UIImageView * firstImageView;
@property(nonatomic,strong)UIImageView * secondImageView;
@property(nonatomic,strong)UIImageView * threeImageView;
@property(nonatomic,strong)UIImageView * fourthImageView;
@property(nonatomic,strong)UIImageView * fiveImageView;
@property(nonatomic,strong)UIImageView * sixImageView;
@property(nonatomic,strong)UIImageView * sevenImageView;
@property(nonatomic,strong)UIImageView * eightImageView;
@property(nonatomic,strong)UIImageView * nineImageView;
-(void)configValue:(NSArray*)array;
@end
