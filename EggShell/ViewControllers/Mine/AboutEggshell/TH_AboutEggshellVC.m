//
//  TH_AboutEggshellVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_AboutEggshellVC.h"
@interface TH_AboutEggshellVC ()
@property(nonatomic,strong)UIScrollView * scro;
@property(strong,nonatomic)UIWebView* webView;
@end

@implementation TH_AboutEggshellVC

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"abouteggshellvc"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"abouteggshellvc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createLogo];
}
-(void)createLogo{


    NSString *path = [[NSBundle mainBundle] pathForResource:@"蛋壳儿" ofType:@"doc"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(-45, -50, WIDETH+90, HEIGHT)];
    
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];

    

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
