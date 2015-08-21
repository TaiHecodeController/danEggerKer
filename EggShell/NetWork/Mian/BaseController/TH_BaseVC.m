//
//  TH_BaseVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

@interface TH_BaseVC ()

@end

@implementation TH_BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;



    // Do any additional setup after loading the view.
    
    
}



- (void)addRightBtn2_NormalImageName:(NSString *)nIcon hightImageName:(NSString *)hIcon action:(SEL)action target:(id)target
{
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageNamed:nIcon] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:hIcon] forState:UIControlStateHighlighted];
    btn1.frame = (CGRect){{WIDETH - 0.186 * WIDETH, (44 - btn1.currentImage.size.height)/2},btn1.currentImage.size};
    [btn1 addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
//    return btn1;
    [self.navigationController.navigationBar addSubview:btn1];
}

- (void)didReceiveMemoryWarning
{
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
