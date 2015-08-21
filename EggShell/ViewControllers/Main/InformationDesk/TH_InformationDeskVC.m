//
//  TH_InformationDeskVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_InformationDeskVC.h"
#import "InformationDeskCell.h"
#import "HYSegmentedControl.h"
#import "TH_InformationDeskDetailVC.h"
@interface TH_InformationDeskVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * tablewVew;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;

@end

@implementation TH_InformationDeskVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    
    [self createTableView];
     [self hySegmentedControlSelectAtIndex:0];
    
}
-(void)createView
{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WIDETH, 0.5)];
    bgView.backgroundColor = color(221, 221, 221);
    [self.view addSubview:bgView];
    NSArray *iconArr = @[@[@"zhaopinhui",@"zhaopinhui1"],@[@"shuangxuanhui",@"shuangxuanhui1"]];
    

    
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"招聘会", @"双选会"]  IconNames:iconArr delegate:self] ;
    [self.view addSubview:_segmentedControl];

}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        
        _currentIndex = 0;
        NSLog(@"招聘会");
        
        
        [self.tablewVew reloadData];
        
    }
    else
    {
        _currentIndex = 1;
        NSLog(@"双选会");
        
        
        [self.tablewVew reloadData];
        
    }
}


-(void)createTableView
{

    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT - 64-40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tablewVew = tableView;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    InformationDeskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationDeskCell" owner:self options:nil] lastObject];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TH_InformationDeskDetailVC * inforMation = [[TH_InformationDeskDetailVC alloc]init];
    inforMation.title = @"详情";
    [self.navigationController pushViewController:inforMation animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
