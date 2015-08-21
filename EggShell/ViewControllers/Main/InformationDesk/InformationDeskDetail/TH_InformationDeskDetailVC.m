//
//  TH_InformationDeskDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_InformationDeskDetailVC.h"
#import "infDestDetailView.h"
@interface TH_InformationDeskDetailVC ()
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation TH_InformationDeskDetailVC

- (void)viewDidLoad {
    [self createSco];
    [self registerView];
}
-(void)createSco
{

    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
}
-(void)registerView
{ infDestDetailView * detail = [[[NSBundle mainBundle] loadNibNamed:@"infDestDetailView" owner:self options:nil] lastObject];
    detail.frame = CGRectMake(0, 0, WIDETH, HEIGHT);
    [self.scro addSubview:detail];
    self.scro.contentSize = CGSizeMake(WIDETH, 568);
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
