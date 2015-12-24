//
//  THMBProgressHubView.h
//  MBProgressHUB
//
//  Created by 李李贤军 on 15/12/23.
//  Copyright © 2015年 TH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THMBProgressHubView : UIView

{//UIImageView
    UIImageView *imageView;
//    //UILabel
//    UILabel *Infolabel;
}
//网络加载文字
@property (nonatomic, assign) NSString *loadtext;
@property(nonatomic,strong)UILabel * Infolabel;
//动画判断
@property (nonatomic, readonly) BOOL isAnimating;
/*
 创建viewframe
 *
 */
- (id)initWithFrame:(CGRect)frame;
/*
 开始动画
 *
 */
- (void)startAnimationWithText:(NSString *)text;
/*
 停止动画
 *
 */
- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;


@end
