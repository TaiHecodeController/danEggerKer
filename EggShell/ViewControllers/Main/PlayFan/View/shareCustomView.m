
\

//
//  shareCustomView.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "shareCustomView.h"
#import "shareButtn.h"
#define     SCREEN_HEIGHT                   ([[UIScreen mainScreen] bounds].size.height)
#define     SCREEN_WIDTH                    ([[UIScreen mainScreen] bounds].size.width)
#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]
@interface shareCustomView()
{
    NSString *_urlString;
    NSString *_titleString;
    NSString *_contentString;
}
@property (nonatomic ,strong) UIView *toolbar;
@end
@implementation shareCustomView

-(id)init{
    self = [super init];
    if (self) {
        
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.userInteractionEnabled = YES;
        self.backgroundColor = WINDOW_COLOR;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelShare)];
        [self addGestureRecognizer:tapGesture];
        
        [self setupBlur];
        
        [self initOtherUI];
        
    }
    return self;
}

#pragma mark - 取消操作
-(void)cancelSelectedShareBtnClick{
    [self cancelShare];
}
#pragma mark - 设置模糊化
- (void)setupBlur {
    [self setClipsToBounds:YES];
    if (![self toolbar]) {
        self.toolbar = [[UIView alloc] init];
        self.toolbar.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.toolbar];
        self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.toolbar.frame = CGRectMake(0, SCREEN_HEIGHT - 249, SCREEN_WIDTH, 249);
    } completion:^(BOOL finished) {
    }];
}

-(void)initOtherUI{
    //分享标题
    UILabel *waitL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 49)];
    waitL.text = @"分享到";
    waitL.backgroundColor = UIColorFromRGB(0x3ebb2b);
    waitL.font = [UIFont systemFontOfSize:17.0];
    waitL.textAlignment = NSTextAlignmentCenter;
    waitL.textColor = UIColorFromRGB(0xFFFFFF);
    [self.toolbar addSubview:waitL];
    
    CGFloat buttonH = 61;
    CGFloat boardW = 45;
    CGFloat widethx = (WIDETH-45*3-38*2)/2.0;
    NSArray *imgsArray = [NSArray arrayWithObjects:@"qqshare",@"weiboshare",@"qqkongjianShare",@"weixinshare",@"pengyouShare", nil];
    NSArray *nameArray = [NSArray arrayWithObjects:@"QQ",@"新浪微博",@"QQ空间",@"微信",@"朋友圈", nil];
    
    for (int i = 0; i <= 4; i ++) {
        shareButtn *okBtn = [[shareButtn alloc] initWithFrame:CGRectMake(38+widethx*(i%3)+boardW*(i%3), 79+buttonH*(i/3)+13*(i/3), 45, buttonH)];
        okBtn.tag = i;

        [okBtn addTarget:self action:@selector(renwenAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.toolbar addSubview:okBtn];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
        imageView.image= [UIImage imageNamed:imgsArray[i]];
        [okBtn addSubview:imageView];
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 45+7, 45, 11)];
        lable.text =nameArray[i];
        lable.font = [UIFont systemFontOfSize:11];
        lable.textColor = UIColorFromRGB(0x333333);
        lable.textAlignment = NSTextAlignmentCenter;
        [okBtn addSubview:lable];
    }
}

#pragma mark - 确定操作
-(void)renwenAction:(UIButton *)sender{
    
    if (_delegate && [_delegate respondsToSelector:@selector(shareButtonActionWithTag:)]) {
        [_delegate shareButtonActionWithTag:sender.tag];
    }
    
    [self cancelShare];
}

#pragma mark - 显示操作
- (void)showInView:(UIView *) view{
    [[UIApplication sharedApplication].delegate.window  addSubview:self];
}

#pragma mark - 取消操作
- (void)cancelShare{
    [UIView animateWithDuration:0.3 animations:^{
        [self.toolbar setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    }completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
