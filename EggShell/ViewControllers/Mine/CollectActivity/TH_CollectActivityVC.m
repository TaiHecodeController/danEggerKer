//
//  TH_CollectActivityVC.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/7.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "TH_CollectActivityVC.h"
#import "ActivityCell.h"
#import "HYSegmentedControl.h"
#import "TH_PlayFanDetailVC.h"
@interface TH_CollectActivityVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView * talbleView  ;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@end

@implementation TH_CollectActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self createTableView ];
}
-(void)createTableView
{
       _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"未开始", @"已结束"]  IconNames:nil delegate:self] ;
    _segmentedControl.backgroundColor =[UIColor whiteColor];
       [self.view addSubview:_segmentedControl];
    

    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT-64-40)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.talbleView = tableView;
    [self.view addSubview:tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TH_PlayFanDetailVC * playDetail =[[TH_PlayFanDetailVC alloc]init];
    playDetail.title = @"详情";
    [self.navigationController pushViewController:playDetail animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
