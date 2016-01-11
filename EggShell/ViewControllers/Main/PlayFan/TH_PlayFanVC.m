//
//  TH_PlayFanVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_PlayFanVC.h"
#import "InformationDeskCell.h"
#import "HYSegmentedControl.h"
#import "TH_InformationDeskDetailVC.h"
#import "playFanModel.h"
#import "AFAppRequest.h"
#import "informantionModel.h"
#import "TH_MainTabBarController.h"
#import "recommendCell.h"
#import "ActivityCell.h"
#import "TH_PlayFanDetailVC.h"
@interface TH_PlayFanVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    THMBProgressHubView * _mbPro;
     NSIndexPath  * record_index;
}

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * cellArray;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int limitNum;
@property (nonatomic,strong)AFRequestState * state;
@property (nonatomic, strong) playFanModel *firstModel;
@property (nonatomic, strong) recommendCell *headView;
@property (nonatomic, strong) NSDictionary *recommendDic;

@end

@implementation TH_PlayFanVC
-(void)dealloc
{
    
    [_header free];
    [_footer free];
}
-(void)viewWillAppear:(BOOL)animated
{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    self.navigationController.navigationBar.translucent = NO;
    
    [MobClick beginLogPageView:@"playfanvc"];
    
}
-(void)viewDidAppear:(BOOL)animated
{
//    self.cellArray = [NSMutableArray arrayWithCapacity:0];
//        InformationDeskCell * cell = self.cellArray[record_index.row];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//      [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"playfanvc"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray =[NSMutableArray arrayWithCapacity:0];
    self.recommendDic = [[NSDictionary alloc]init];
    self.view.backgroundColor =[UIColor whiteColor];
    self.limitNum = 10;
    [self createView];
    [self createTbleView];
    
    [self hySegmentedControlSelectAtIndex:0];
    
}

-(void)createView
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WIDETH, 0.5)];
    bgView.backgroundColor = color(221, 221, 221);
    [self.view addSubview:bgView];
    NSArray *iconArr = @[@[@"huogu0",@"huogu1"],@[@"huodong0",@"huodong1"]];
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"蛋壳活动", @"往期回顾"]  IconNames:iconArr delegate:self];
    [self.view addSubview:_segmentedControl];
    
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self.dataArray removeAllObjects];
       self.tableView.tableHeaderView = _headView;
        _currentIndex = 0;
        _page = 1;
        _mbPro = [MBProgressHUD mbHubShowMBProgressHubView:self];
        [self loadData:_mbPro page:_page pageTye:2];
        [self.tableView reloadData];
        
    }
    else
      {
         [self.dataArray removeAllObjects];
         self.tableView.tableHeaderView = nil;
            _currentIndex = 1;
            _page = 1;
            _mbPro = [MBProgressHUD mbHubShowMBProgressHubView:self];
            [self loadData:_mbPro page:_page pageTye:1];
            [self.tableView reloadData];
            
    }
}
-(void)createTbleView{
    
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT-64-49-40) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.tableView;
    _footer.delegate = self;
    
    _headView = [[recommendCell alloc]init];
    _headView.frame = CGRectMake(0, 0, WIDETH, 305);
    self.tableView.tableHeaderView = _headView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick:)];
    [_headView addGestureRecognizer:tap];
}

-(void)loadData:(id)notify page:(int)num pageTye:(int)type
{
    if(_state.running)
    {
        return;
    }
    _state = [[TH_AFRequestState loveActivityRequestListWithSucc:^(NSDictionary *DataDic) {
        
        if (_currentIndex == 0)
        {
            self.recommendDic = DataDic[@"recommend"];
            [self setHeadData:DataDic[@"recommend"]];
             [self.dataArray addObjectsFromArray:DataDic[@"result"]];

        }
        else
        {
            [self.dataArray addObjectsFromArray:DataDic];
        }
        [self.tableView reloadData];
        
    } resp:[NSObject class] withPage:num withLimit:self.limitNum withType:type] addNotifaction:notify];
}

- (void)setHeadData:(NSDictionary *)dic
{
    [_headView.banner sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"logoSencond"]];
    _headView.titleLab.text = dic[@"title"];
    _headView.hostLab.text = dic[@"organizers"];
    _headView.addressLab.text = dic[@"address"];
    _headView.timeLab.text = dic[@"starttime"];
    _headView.itemTimeView.collectionNumberTitleLable.text = dic[@"collect_count"];
    _headView.itemTimeView.commendNumberTitleLable.text = dic[@"apply_count"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aId"];
    if (!cell)
    {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aId"];
    }
    
    if(self.dataArray.count >0)
    {
        if (_currentIndex == 0)
        {
            
                NSDictionary *dic = self.dataArray[indexPath.row];
                cell.eventTitleLable.text = dic[@"title"];
                cell.holdLable.text = dic[@"organizers"];
                cell.organizedAddressLable.text = dic[@"address"];
                cell.organizedTimeTitleLable.text = dic[@"starttime"];
                cell.collectionNumberTitleLable.text = dic[@"collect_count"];
                cell.commendNumberTitleLable.text = dic[@"apply_count"];
                [cell.holdLogoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"logoSencond"]];

        }
        if (_currentIndex == 1)
        {
           
            NSDictionary *dic = self.dataArray[indexPath.row];
            cell.eventTitleLable.text = dic[@"title"];
            cell.holdLable.text = dic[@"organizers"];
            cell.organizedAddressLable.text = dic[@"address"];
            cell.organizedTimeTitleLable.text = dic[@"starttime"];
            cell.collectionNumberTitleLable.text = dic[@"collect_count"];
            cell.commendNumberTitleLable.text = dic[@"apply_count"];
            [cell.holdLogoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]] placeholderImage:[UIImage imageNamed:@"logoSencond"]];
        }
        
    }
    
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)headClick:(UITapGestureRecognizer *)tap
{
    TH_PlayFanDetailVC * detail = [[TH_PlayFanDetailVC alloc] init];
    detail.activityId = self.recommendDic[@"id"];
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArray[indexPath.row];
    if (_currentIndex == 0)
    {
                TH_PlayFanDetailVC * detail = [[TH_PlayFanDetailVC alloc] init];
        detail.activityId = dic[@"id"];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    else if (_currentIndex==1)
    {
        TH_PlayFanDetailVC * detail = [[TH_PlayFanDetailVC alloc] init];
        detail.iShistory  = YES;
        detail.activityId = dic[@"id"];
        [self.navigationController pushViewController:detail animated:YES];
    
    }
}

#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        
        [self.dataArray removeAllObjects];
        _page = 1;
        if (_currentIndex == 0)
        {
            [self loadData:refreshView page:_page pageTye:2];
        }
        else
        {
            [self loadData:refreshView page:_page pageTye:1];
        }
    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        if (_currentIndex == 0)
        {
            [self loadData:refreshView page:_page pageTye:2];
        }
        else
        {
            [self loadData:refreshView page:_page pageTye:1];
        }
        
    }
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
