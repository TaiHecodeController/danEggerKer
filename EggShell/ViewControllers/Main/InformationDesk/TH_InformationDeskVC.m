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
#import "AFAppRequest.h"
#import "informantionModel.h"
@interface TH_InformationDeskVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    MBProgressHUD * _mbPro;
    NSIndexPath  * record_index;
}
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int limitNum;
@property (nonatomic,strong)AFRequestState * state;
@end

@implementation TH_InformationDeskVC
-(void)dealloc
{
    
    [_header free];
    [_footer free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.page = 1;
    self.limitNum = 10;
    [self createView];
    [self createTableView];
    [self hySegmentedControlSelectAtIndex:0];
    
}
-(void)loadData:(id)notify page:(int)num pageTye:(int)type
{
    if(_state.running)
    {
        return;
    }
    
    _state = [[TH_AFRequestState InformationDeskRequestWithSucc:^(NSArray *dataDic) {
        
        [self.dataArray addObjectsFromArray:dataDic];
        [self.tableView reloadData];
        
    } resp:[informantionModel class] withPage:num withLimit:self.limitNum withType:type] addNotifaction:notify];
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
        self.dataArray = [[NSMutableArray alloc]init];
        _currentIndex = 0;
        NSLog(@"招聘会");
        _page = 1;
        _mbPro = [MBProgressHUD mbHubShow];
        [self loadData:_mbPro page:_page pageTye:1];
        [self.tableView reloadData];
    }
    else
    {
        self.dataArray = [NSMutableArray
                       arrayWithCapacity:0];
        _currentIndex = 1;
        NSLog(@"双选会");
        _page=1;
        _mbPro = [MBProgressHUD mbHubShow];
        [self loadData:_mbPro page:_page pageTye:2];
        [self.tableView reloadData];
    }
}


-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT - 64-49) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.showsVerticalScrollIndicator = NO;
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
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    InformationDeskCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InformationDeskCell" owner:self options:nil] lastObject];
    }
    informantionModel * model = self.dataArray[indexPath.row];
    [cell setValue:model];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_currentIndex == 0) {
        TH_InformationDeskDetailVC * detail = [[TH_InformationDeskDetailVC alloc] init];
        detail.title = @"详情";
        informantionModel  * model = self.dataArray[indexPath.row];
        detail.informodel = model;
        record_index = indexPath;
        
        [self.navigationController pushViewController:detail animated:YES];
        

    }else if (_currentIndex==1)
    {
        TH_InformationDeskDetailVC * detail = [[TH_InformationDeskDetailVC alloc] init];
        detail.title = @"详情";
        informantionModel  * model = self.dataArray[indexPath.row];
        detail.informodel = model;
        record_index = indexPath;
        
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 0;
        
        if (_currentIndex == 0)
        {
            [self loadData:refreshView page:_page pageTye:1];
        }
        else
        {
            [self loadData:refreshView page:_page pageTye:2];
        }

    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        if (_currentIndex == 0)
        {
             [self loadData:refreshView page:_page pageTye:1];
        }
        else
        {
            [self loadData:refreshView page:_page pageTye:2];
        }
        
    }
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
