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
#import "playFanModel.h"

@interface TH_CollectActivityVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    THMBProgressHubView * _mbPro;
    NSIndexPath  * record_index;
}
@property(nonatomic,strong)UITableView * tableView  ;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, strong) AFRequestState *state;
@property (nonatomic, assign) int currentIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int limitNum;
@end

@implementation TH_CollectActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray =[NSMutableArray arrayWithCapacity:0];
    self.limitNum = 10;
 
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self createTableView ];
      [self hySegmentedControlSelectAtIndex:0];
}
-(void)loadData:(id)notify page:(int)num pageTye:(int)type
{
    if(_state.running)
    {
        return;
    }
   
    NSNumber * pageType = [NSNumber numberWithInt:type];
    NSNumber * pageNum = [NSNumber numberWithInt:num];
    NSNumber * activityTypeNum =[NSNumber numberWithInt:self.activityType];
    NSNumber * limitNums= [NSNumber numberWithInt:self.limitNum];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString * tokenStr = [df objectForKey:@"md5_token"];
    NSDictionary * param =@{@"page":pageNum,@"limit":limitNums,@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"],@"token":tokenStr,@"type":pageType,@"activityType":activityTypeNum};
    
    _state = [[TH_AFRequestState activityRegistrationFavoritesWithSucc:^(NSArray *dics) {
        
        [self.dataArray addObjectsFromArray:dics];
            [self.tableView reloadData];
        
    } withd:param resp:[playFanModel class]] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    
    
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        [self.dataArray removeAllObjects];
        _currentIndex = 0;
        NSLog(@"未开始");
        _page = 1;
        _mbPro = [MBProgressHUD mbHubShowMBProgressHubView:self];
        [self loadData:_mbPro page:_page pageTye:2];
        [self.tableView reloadData];
        
    }
    else
    {
        [self.dataArray removeAllObjects];
        _currentIndex = 1;
        NSLog(@"已结束");
        _page = 1;
        _mbPro = [MBProgressHUD mbHubShowMBProgressHubView:self];
        [self loadData:_mbPro page:_page pageTye:1];
        [self.tableView reloadData];
        
    }
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
    self.tableView = tableView;
    [self.view addSubview:tableView];
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.tableView;
    _footer.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    if (self.dataArray.count!=0) {
        playFanModel * dic = self.dataArray[indexPath.row];
        
        [cell configValues:dic];

    }
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    TH_PlayFanDetailVC * playDetail =[[TH_PlayFanDetailVC alloc]init];
//    playDetail.title = @"详情";
//    [self.navigationController pushViewController:playDetail animated:YES];
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
    
}


@end
