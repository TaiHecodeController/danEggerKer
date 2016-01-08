//
//  playDetailTitleView.h
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTimeView.h"
@interface playDetailTitleView : UIView
//活动logo
@property(nonatomic,strong)UIImageView * logoImageView;
//活动标题
@property(nonatomic,strong)UILabel * eventTitleLalbel;
//主办方
@property(nonatomic,strong)UILabel * organizersLable;
//举办时间
@property(nonatomic,strong)UILabel * holdTimeLable;
//举办地点
@property(nonatomic,strong)UILabel *  holdAddressLable;
//咨询电话
@property(nonatomic,strong)UILabel *  supporthotlineLable;
//联系人
@property(nonatomic,strong)UILabel *  connectPersonLable;
//交通路线
@property(nonatomic,strong)UILabel *   trafficRoutesLable;
//招聘会介绍
@property(nonatomic,strong)UILabel *   recruitmentIntroducedLable;
@property(nonatomic,strong)ItemTimeView * itemView ;
-(void)configValue:(NSDictionary*)dic;
@end
