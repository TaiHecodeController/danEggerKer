//
//  TH_featureVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/14.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_featureVC.h"
#import "TH_MainTabBarController.h"
#define kPageCount 4

@interface TH_featureVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation TH_featureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContent];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setContent
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(kPageCount * scrollView.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<kPageCount; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        NSString *name = [NSString stringWithFormat:@"guidePage%d", i];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        if (i == kPageCount - 1)
        {
            [self setupLastImageView:imageView];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = kPageCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:235/255.0 green:67/255.0 blue:67/255.0 alpha:1];
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}
- (void)setupLastImageView:(UIImageView *)imageView
{
    
    imageView.userInteractionEnabled = YES;
    
    //    // 1.分享给大家（checkbox）
    //    UIButton *shareBtn = [[UIButton alloc] init];
    //    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    //    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    //    [shareBtn setTitle:@"进来看看" forState:UIControlStateNormal];
    //    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //    shareBtn.width = 220;
    //    shareBtn.height = 30;
    //    shareBtn.centerX = imageView.width * 0.5;
    //    shareBtn.centerY = imageView.height * 0.7;
    //    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [imageView addSubview:shareBtn];
    
    //    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 2.开始
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"lanniu1"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"lanniu1"] forState:UIControlStateHighlighted];
    //    startBtn.size = startBtn.currentBackgroundImage.size;
    //    startBtn.centerX = shareBtn.centerX;
    //    startBtn.centerY = imageView.height * 0.8;
    //    startBtn.layer.masksToBounds = YES;
    //    startBtn.layer.cornerRadius = 3;
    //    [startBtn setBackgroundImage:[UIImage imageNamed:@"hongniu"] forState:UIControlStateNormal
    //     ];
    //    startBtn.backgroundColor = color(255, 255, 255);
    startBtn.frame = CGRectMake((WIDETH-150)/2, HEIGHT-132, 150, 30);
    [startBtn setTitle:@"立即体验" forState:UIControlStateNormal];
    startBtn.titleLabel.textColor = UIColorFromRGB(0xFFFFFF);
    startBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}
- (void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}
- (void)startClick
{
    TH_MainTabBarController * mainTabBar = [[TH_MainTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = mainTabBar;
    
    
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
