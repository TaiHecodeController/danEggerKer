//
//  EditdelegateView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EditdelegateView.h"

@implementation EditdelegateView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createteView];
    }
    return self;
}
-(void)createteView
{
    self.ediBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
    [self addSubview:self.ediBtn];
    
    self.delgateBtn =[[UIButton alloc] initWithFrame:CGRectMake(70, 0, 70, 35)];
    [self addSubview:self.delgateBtn];
    UIImageView * editImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10.5, 14, 14)];
    editImageView.image =[UIImage imageNamed:@"resumeEditSelect"];
    [self addSubview:editImageView];
    UILabel * editLable =[[UILabel alloc] initWithFrame:CGRectMake(10+15+5, 10, 25, 15)];
    editLable.textColor = UIColorFromRGB(0x7adb6b);
    editLable.text = @"编辑";
    editLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:editLable];
    
    
    UIImageView * delegateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(82, 10.5, 11, 14)];
    delegateImageView.image =[UIImage imageNamed:@"resumeDelegate"];
    [self addSubview:delegateImageView];
    UILabel * delegateLable =[[UILabel alloc] initWithFrame:CGRectMake(80+15+5, 10, 25, 15)];
    delegateLable.textColor = UIColorFromRGB(0xeb7a23);
    delegateLable.text = @"删除";
    delegateLable.font = [UIFont systemFontOfSize:12];
    [self addSubview:delegateLable];

}
@end
