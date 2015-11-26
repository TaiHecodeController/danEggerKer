//
//  TH_AllPositionVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//
/*
 所有职位
 *
 */
#import "TH_AllPositionVC.h"
#import "AllPosionCell.h"
#import "AllPosionModel.h"
@interface TH_AllPositionVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
 MBProgressHUD * _mbPro;
}
@property(nonatomic,strong)UITableView  * tableView;
@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property(nonatomic,assign)int limitNum;
@end

@implementation TH_AllPositionVC
-(void)dealloc
{
    
    [_header free];
    [_footer free];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.limitNum = 3;
    self.page = 1;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    self.title = @"所有职位";
    self.view.backgroundColor = color(240, 240, 237);
    [self createTableView];
    //底部选框
    [self  createSelectBtn];
    [self loadData:self.limitNum page:self.page notif:[MBProgressHUD mbHubShow]];
    }
-(void)loadData:(int)limitNum page:(int)page notif:(id)notify
{
    if(_state.running)
    {
        return;
    }
    NSString * uid = [NSString stringWithFormat:@"%d",1869];
    NSString * jobstatus =[NSString stringWithFormat:@"%d",0];
    NSNumber  * pagenum =[NSNumber numberWithInt:page];
    NSNumber *   pagesize = [NSNumber numberWithInt:limitNum];
    NSDictionary * param = @{@"uid":uid,@"jobstatus":jobstatus,@"pagenum":pagenum,@"pagesize":pagesize};
    self.state = [[TH_AFRequestState EnterpriseFullPositionWithSucc:^(NSArray *dic)
    {
       
        
        [self.dataArray addObjectsFromArray:dic];
        [self.tableView reloadData];
    } withd:param resp:[AllPosionModel class]] addNotifaction:notify];

}
-(void)createSelectBtn
{
    UIView * bottoBgVieW =[[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 64-50, WIDETH, 50)];
    bottoBgVieW.backgroundColor = [UIColor whiteColor];
    bottoBgVieW.layer.borderWidth = 0.8;
    bottoBgVieW.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    [self.view addSubview:bottoBgVieW];
    //按钮选框
    UIButton *   marqueeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*MyWideth, 5*MyWideth, 40*MyWideth, 40*MyWideth)];
    [marqueeBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [marqueeBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    [marqueeBtn addTarget:self action:@selector(marqueeBtnClck:) forControlEvents:UIControlEventTouchUpInside];
    [bottoBgVieW addSubview:marqueeBtn];
    //文字
    UILabel * allLalbe = [[UILabel alloc] initWithFrame:CGRectMake(55*MyWideth, 15*MyWideth,35*MyWideth , (60*MyWideth-30*MyWideth)/2)];
    allLalbe.text = @"全选";
    allLalbe.font = [UIFont systemFontOfSize:15*MyWideth];
    allLalbe.textColor = UIColorFromRGB(0xF44336);
    [bottoBgVieW addSubview:allLalbe];
    NSArray * titileArray = @[@"暂停招聘",@"职位刷新",@"删除"];
    for (int i = 0 ; i < titileArray.count; i++) {
        UIButton * electBtn = [[UIButton alloc] initWithFrame:CGRectMake(55*MyWideth+15*MyWideth+35*MyWideth+((WIDETH -(55*MyWideth+15*MyWideth+48*MyWideth+35*MyWideth))/3)*i+15*MyWideth*i, 10*MyWideth, (WIDETH -(55*MyWideth+15*MyWideth+48*MyWideth+35*MyWideth))/3 , 30*MyWideth)];
        electBtn.backgroundColor =[UIColor redColor];
        electBtn.titleLabel.font = [UIFont systemFontOfSize:15*MyWideth];
        [electBtn setTitle:titileArray[i] forState:UIControlStateNormal];
        [bottoBgVieW addSubview:electBtn];
        //切圆角
        electBtn.layer.cornerRadius = 3;
        electBtn.layer.masksToBounds = YES;
        //颜色
        if (i==2) {
            electBtn.backgroundColor = UIColorFromRGB(0xF44336);
        }else
        {
            electBtn.backgroundColor = UIColorFromRGB(0x37ACF4);

        }
    }
}
#pragma mark --- 全选点击事件
-(void)marqueeBtnClck:(UIButton*)sender
{
    sender.selected = !sender.selected;
}

-(void)createTableView
{
    UITableView *  tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT - 64-50)];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.backgroundColor = color(240, 240, 237);
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
{   AllPosionCell * cell =[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[AllPosionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    if (self.dataArray.count !=0) {
        AllPosionModel * model = self.dataArray[indexPath.row];
        
        [cell configValue:model];
    }
    
    cell.isSelectBlock = ^(int tag)
    {
        
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105* MyWideth;
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 1;
        [self.dataArray removeAllObjects];
        [self loadData:self.limitNum page:_page notif:refreshView];
    }
    else{
        self.page++;
        
        THLog(@"上拉加载更多");
        [self loadData:self.limitNum page:self.page notif:refreshView];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }



@end
