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
@interface TH_PlayFanVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property (nonatomic,strong)AFRequestState * state;
@end

@implementation TH_PlayFanVC
-(void)dealloc
{
    
    [_header free];
    [_footer free];
}
-(void)viewWillAppear:(BOOL)animated
{[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    


}
- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor =[UIColor whiteColor];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        self.navigationController.navigationBar.translucent = NO;
    
    self.page = 0;
    self.title = @"玩出范";
    [self createView];
    [self createTbleView];
    [self hySegmentedControlSelectAtIndex:0];
    [self loadData:_header page:0];

    // Do any additional setup after loading the view.
}



-(void)loadData:(id)notify page:(int)num
{
    if(_state.running)
    {
        return;
    }
    
    NSString * pageNumber = [NSString stringWithFormat:@"%d",num];
    _state = [[TH_AFRequestState playClassrRequestWithSucc:^(NSArray *DataDic) {
        self.dataArray = [NSMutableArray arrayWithArray:DataDic];
        
        [self.tableView reloadData];

    } resp:[playFanModel class] withPage:pageNumber] addNotifaction:notify];
}

-(void)createView
{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WIDETH, 0.5)];
    bgView.backgroundColor = color(221, 221, 221);
    [self.view addSubview:bgView];
    NSArray *iconArr = @[@[@"high1",@"high"],@[@"fuli",@"fuli1"]];
    
    
    
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:0 Titles:@[@"蛋粉H翻天igh", @"蛋壳儿送福利"]  IconNames:iconArr delegate:self] ;
    [self.view addSubview:_segmentedControl];
    
}
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        
        _currentIndex = 0;
        NSLog(@"蛋粉H翻天igh");
        
        
        [self.tableView reloadData];
       
    }
    else
    {
        _currentIndex = 1;
        NSLog(@"蛋壳儿送福利");
        
        
        [self.tableView reloadData];
        
    }
}
-(void)createTbleView{

    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, WIDETH, HEIGHT-40-49) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    self.tableView.showsVerticalScrollIndicator = NO;
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
    InformationDeskCell* InforCell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!InforCell) {
        InforCell = [[[NSBundle mainBundle] loadNibNamed:@"InformationDeskCell" owner:self options:nil] lastObject];
    }
    
    playFanModel * model = self.dataArray[indexPath.row];
    [InforCell setValue:model];
    
    NSLog(@"%@",model.endtime);
    
   return InforCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    TH_InformationDeskDetailVC * detail = [[TH_InformationDeskDetailVC alloc] init];
    detail.title = @"详情";
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 0;
        THLog(@"");
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
        [self loadData:refreshView page:_page];
    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        [self.dataArray removeAllObjects];
        [self loadData:refreshView page:_page];
        
        
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
