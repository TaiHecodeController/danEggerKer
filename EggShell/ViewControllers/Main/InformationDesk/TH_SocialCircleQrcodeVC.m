//
//  TH_SocialCircleQrcodeVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/3.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_SocialCircleQrcodeVC.h"

@interface TH_SocialCircleQrcodeVC ()

@end

@implementation TH_SocialCircleQrcodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImageView * titleImageView    =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 40)];
    titleImageView.image = [UIImage imageNamed:@"shiyongxiangq"];
    [self.view addSubview:titleImageView];
    UIImageView * qrCodeImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDETH - 150)/2.0, (HEIGHT-150)/2.0-64-49, 150, 150)];
    [qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:self.qrCodeStr] placeholderImage:[UIImage imageNamed:@"HR交流圈"]];
    [self.view addSubview:qrCodeImageView];
    UITextView *detailView = [[UITextView alloc]init];
    detailView.frame = CGRectMake((WIDETH - 250)/2.0, CGRectGetMaxY(qrCodeImageView.frame)+10, 250, 200);
    detailView.text = self.content;
    detailView.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailView];
    
    
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
