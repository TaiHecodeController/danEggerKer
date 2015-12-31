//
//  THMBProgressHubView.m
//  MBProgressHUB
//
//  Created by 李李贤军 on 15/12/23.
//  Copyright © 2015年 TH. All rights reserved.
//

#import "THMBProgressHubView.h"

@implementation THMBProgressHubView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*添加动画图片**/
        self.backgroundColor = [UIColor clearColor];
        _isAnimating = NO;
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,2, frame.size.width-20,frame.size.height-20)];
        [self addSubview:imageView];
        //设置动画帧
        imageView.animationImages=[NSArray arrayWithObjects: [UIImage imageNamed:@"10"],
                                   [UIImage imageNamed:@"20"],
                                   [UIImage imageNamed:@"30"],
                                   [UIImage imageNamed:@"40"],
                                   [UIImage imageNamed:@"50"],
                                   [UIImage imageNamed:@"60"],
                                   [UIImage imageNamed:@"70"],
                                   [UIImage imageNamed:@"80"],
                                   
                                   nil ];
        /*添加加载文字**/
      UILabel *  Infolabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        Infolabel.backgroundColor = [UIColor clearColor];
        Infolabel.textAlignment = NSTextAlignmentCenter;
        Infolabel.textColor = [UIColor colorWithRed:64.0/255 green:64./255 blue:64./255 alpha:1];
        Infolabel.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:12.0f];
        [self addSubview:Infolabel];
        self.Infolabel = Infolabel;
        self.layer.hidden = YES;
    }
    return self;
}
- (void)startAnimationWithText:(NSString *)text
{   self.Infolabel.text = text;

    _isAnimating = YES;
    self.layer.hidden = NO;
    [self doAnimation];
}

-(void)doAnimation{
    //设置动画总时间
    imageView.animationDuration=1.0;
    //设置重复次数,0表示不重复
    imageView.animationRepeatCount=0;
    //开始动画
    [imageView startAnimating];
}

- (void)stopAnimationWithLoadText:(NSString *)text withType:(BOOL)type;
{
    _isAnimating = NO;
   self.Infolabel.text = text;
    if(type){
        
        [UIView animateWithDuration:0.1f animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [imageView stopAnimating];
            self.layer.hidden = YES;
            self.alpha = 1;
        }];
    }else{
        [imageView stopAnimating];
        [imageView setImage:[UIImage imageNamed:@"30"]];
    }
    
}


@end
