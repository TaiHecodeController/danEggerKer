//
//  RKSwipeViewController.m
//  EggShell
//
//  Created by 太和 on 15/12/8.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "RKSwipeViewController.h"
#import "ZLSwipeableView.h"

@interface RKSwipeViewController ()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;

@end

@implementation RKSwipeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];
    
    // Required Data Source
    self.swipeableView.dataSource = self;
    
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;

}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    UIView *view =  [[UIView alloc]init];
    view.backgroundColor = [UIColor blackColor];
    return view;
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
