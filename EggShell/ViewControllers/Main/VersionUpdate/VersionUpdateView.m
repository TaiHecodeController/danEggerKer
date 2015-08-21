//
//  VersionUpdateView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/18.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "VersionUpdateView.h"
#import "AppDelegate.h"
@interface VersionUpdateView()
{
   
}
@end
@implementation VersionUpdateView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (IBAction)laterBtn:(UIButton *)sender {
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}

- (IBAction)btnclick:(id)sender {
    [self removeFromSuperview];
    [_backView removeFromSuperview];
    NSLog(@"111");
}



-(void)showVersonView
{
    AppDelegate * dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    _backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _backView.backgroundColor = [UIColor blackColor];
    _backView.alpha = 0.3;
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = YES;
    
    [dele.window addSubview:_backView];
    [dele.window addSubview:self];
    [UIView animateWithDuration:0.1 animations:^{
        self.center = dele.window.center;
    }];
}

@end
