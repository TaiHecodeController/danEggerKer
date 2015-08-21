//
//  TH_JobWishlistVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_JobWishlistVC.h"
#import "JobWishlistCell.h"
#import "JobWishlistHeadView.h"
@interface TH_JobWishlistVC ()<UITableViewDataSource,UITableViewDelegate,JobWishlistCellDeleDate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UIButton *allClick;
@property(nonatomic,strong)UIButton * applicationBtn;
@property(nonatomic,strong)UIButton * deleteBtn;
@property(nonatomic,strong)JobWishlistCell * cell;

@end

@implementation TH_JobWishlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
       [self createTableView];
    [self createBtnClick];
}

-(void)createBtnClick{

    UIButton * allClick = [[UIButton alloc] initWithFrame:CGRectMake(20, HEIGHT - 135, 18, 18)];
    allClick.backgroundColor =[UIColor redColor];
    [allClick addTarget:self action:@selector(allClickBtn) forControlEvents:UIControlEventTouchUpInside];
    self.allClick = allClick;
    [self.view addSubview:allClick];
    //申请职位
    UIButton * applicationBtn =[[UIButton alloc] initWithFrame:CGRectMake(80,HEIGHT-120, (WIDETH-160-15)/2.0, 30)];
    self.applicationBtn = applicationBtn;
    
    [applicationBtn setBackgroundImage:[UIImage imageNamed:@"lanniux"] forState:UIControlStateNormal];
    [applicationBtn setTitle:@"申请职位" forState:UIControlStateNormal];
    [applicationBtn setTitleColor:color(255, 255, 255) forState:UIControlStateNormal];
    applicationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [applicationBtn addTarget:self action:@selector(applicationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:applicationBtn];
    
    //删除职位
    UIButton * deleteBtn =[[UIButton alloc] initWithFrame:CGRectMake(WIDETH/2.0+15, HEIGHT-120, (WIDETH-160-15)/2.0, 30)];
    
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"hongniux"] forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除职位" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:color(255, 255, 255) forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.deleteBtn = deleteBtn;
    [self.view addSubview:deleteBtn];
}

-(void)applicationBtnClick
{

}
-(void)allClickBtn
{

}
-(void)createTableView
{
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-150) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.showsVerticalScrollIndicator = NO;
   tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JobWishlistCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [JobWishlistCell RegisterJobWishListCell];
    }
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.jobDeleGate = self;
  [self.cell.jobBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [self.cell.jobBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    self.cell  = cell;
    return cell;

}
-(void)JobWishlistCellBtn:(JobWishlistCell *)jobCell didBtn:(typeBtn)sender
{
    
}
//-(void)JobWishlistCellBtn:(JobWishlistCell *)jobCell
//{
//    if (self.cell.jobBtn.selected == NO) {
//        self.cell.jobBtn.selected = YES;
//    }
//    else
//    {
//        self.cell.jobBtn.selected = NO;
//    }
//
////    self.cell.jobBtn.selected = !self.cell.jobBtn.selected;
//    NSLog(@"选择");
//    
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JobWishlistHeadView * jobHeadView = [[[NSBundle mainBundle] loadNibNamed:@"JobWishList" owner:self options:nil] lastObject];
    return jobHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 43;
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
