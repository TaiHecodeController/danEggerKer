//
//  ItemTimeView.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "ItemTimeView.h"

@implementation ItemTimeView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUi];
    }
    return self;
}
-(void)makeUi
{
    /*收藏数量**/
    UIImageView * collectionNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(1.5, 0, 13, 12)];
    collectionNumberImageView.image =[UIImage imageNamed:@"collectnum"];
    [self addSubview:collectionNumberImageView];
    UILabel*  collectionNumberTitleLable =[[UILabel alloc] initWithFrame:CGRectMake(16, 0, 16, 12)];
    collectionNumberTitleLable.text = @"06";
    collectionNumberTitleLable.font =[UIFont systemFontOfSize:12];
    collectionNumberTitleLable.textColor = UIColorFromRGB(0x999999);
    self.collectionNumberTitleLable = collectionNumberTitleLable;
    [self addSubview:collectionNumberTitleLable];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(36, 0, .5, 12)];
    lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self addSubview:lineView];
    /*评论人数**/
    UIImageView * commendNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(42.5, 1, 11, 9.5)];
    commendNumberImageView.image =[UIImage imageNamed:@"hezuonum"];
    [self addSubview:commendNumberImageView];
    UILabel *  commendNumberTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 16, 12)];
    commendNumberTitleLable.text = @"06";
//    commendNumberTitleLable.backgroundColor = [UIColor redColor];
    commendNumberTitleLable.font =[UIFont systemFontOfSize:12];
    commendNumberTitleLable.textColor = UIColorFromRGB(0x999999);
    self.commendNumberTitleLable = commendNumberTitleLable;
    [self addSubview:commendNumberTitleLable];
}
@end
