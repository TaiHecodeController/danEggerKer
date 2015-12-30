//
//  editAddView.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "editAddView.h"

@implementation editAddView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 9, 15, 15)];
    self.imageView.image = [UIImage imageNamed:@"resumeAdd"];
    [self addSubview:self.imageView];
    self.editLable = [[UILabel alloc] initWithFrame:CGRectMake(15+8+15, 10, 28, 12)];
    self.editLable.text = @"新增";
    self.editLable.font = [UIFont systemFontOfSize:12];
    self.editLable.textColor = [UIColor whiteColor];
    [self addSubview:self.editLable];
    }
@end
