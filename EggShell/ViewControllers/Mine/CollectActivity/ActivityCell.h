//
//  ActivityCell.h
//  EggShell
//
//  Created by 李李贤军 on 16/1/7.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemTimeView.h"
@interface ActivityCell : UITableViewCell
/*活动标题**/
@property(nonatomic,strong)UILabel * eventTitleLable;
/*主办方**/
@property(nonatomic,strong)UILabel * holdLable;
/*活动地址**/
@property(nonatomic,strong)UILabel * organizedAddressLable;
/*活动时间**/
@property(nonatomic,strong)UILabel * organizedTimeTitleLable;
/*收藏数量**/
@property(nonatomic,strong)UILabel * collectionNumberTitleLable;
/*评论人数**/
@property(nonatomic,strong)UILabel * commendNumberTitleLable;
/*活动logo**/
@property(nonatomic,strong)UIImageView * holdLogoImageView;
@property(nonatomic,strong)ItemTimeView * itemView;


@end
