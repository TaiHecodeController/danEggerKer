//
//  SocialCircleCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialCircleCell : UITableViewCell
@property(nonatomic,strong)UIImageView * logoImageView;
@property(nonatomic,strong)UILabel * groupNoLable;
-(void)configValue:(NSDictionary*)dic;
@end
