//
//  TH_FindJobVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//  找全职

#import "TH_FindJobVC.h"
#import "HYSegmentedControl.h"
#import "jobTableViewCell.h"
#import "UIBarButtonItem+DC.h"
#import "jobModel.h"
#import "TH_JobDetailVC.h"
#import "TH_JobScreeningVC.h"
#import "SearchJobVC.h"
#import "MJRefresh.h"
#import "SearchModelShare.h"


/*数据请求**/
#import "AFAppRequest.h"
#import "findJobModel.h"
#define bottomH 107
#import "AppDelegate.h"
#import "TH_LoginVC.h"



@interface TH_FindJobVC ()<UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,MJRefreshBaseViewDelegate>
{
    
    jobTableViewCell *_cell;
    
    BMKLocationService * _locService;
    NSIndexPath  * record_index;
    
    MBProgressHUD * _mbPro;
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *allSelected;
@property (nonatomic, strong) UIButton *apllyBtn;
@property (nonatomic, strong) NSMutableArray *jobArr;
@property (nonatomic, strong) UIView *corverView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, assign) int mailingNumBer;
@property (nonatomic, strong) NSMutableArray * cellArray;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,assign)int page;
@property (nonatomic,strong)AFRequestState * state;

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
//投递成功的数量
@property (nonatomic, assign) int TDSuccNum;


@end
@implementation TH_FindJobVC
-(void)dealloc
{
    [SearchModelShare sharedInstance].longitude = @"";
    [SearchModelShare sharedInstance].dimensionality = @"";
    [SearchModelShare sharedInstance].keyword = @"";

    [SearchModelShare sharedInstance].hy = @"";
    [SearchModelShare sharedInstance].job_post = @"";
    [SearchModelShare sharedInstance].cityid = @"";
    [SearchModelShare sharedInstance].salary = @"";
    [SearchModelShare sharedInstance].edu = @"";
    [SearchModelShare sharedInstance].exp = @"";
//    [SearchModelShare sharedInstance].type = @"";

    [SearchModelShare sharedInstance].sdate = @"";
    [SearchModelShare sharedInstance].job1 = @"";
    
    [_header free];
    [_footer free];
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:NO];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"sousuo001"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    searchBtn.frame = CGRectMake(WIDETH - 10 - 50 - 20 - 10,0, 44, 44);
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchBtn];
    _searchBtn = searchBtn;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backRootController:) name:@"findJobBackClick" object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{ self.cellArray = [NSMutableArray arrayWithCapacity:0];
    //    jobTableViewCell * cell = self.cellArray[record_index.row];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //  [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    [_searchBtn removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"findJobBackClick" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(backRootController:) name:@"findJobBackClick" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyWordRefresh) name:@"keyWord" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TJsearch) name:@"TJsearch" object:nil];
    
    NSLog(@"_job_type%@",_job_type);
    //全职过来
    if ([_job_type isEqual:@"0"])
    {
        [SearchModelShare sharedInstance].type = @"55";
    }
    //兼职过来
    else if ([_job_type isEqual:@"1"])
    {
        [SearchModelShare sharedInstance].type = @"56";
    }
    //实习过来
    else if  ([_job_type isEqual:@"2"])
    {
        [SearchModelShare sharedInstance].type = @"129";
    }
    //18项进来
    else
    {
        [SearchModelShare sharedInstance].type = @"";
    }

    self.jobArr = [[NSMutableArray alloc]init];
    _mailingNumBer = 0;
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNormalImageName:@"liebiao" hightImageName:nil action:@selector(rightClick) target:self];
    
    [self initView];
    
    //在此方法里请求数据
    self.page = 1;
    [self hySegmentedControlSelectAtIndex:0];
    
    //设置定位精确度，默认：kCLLocationAccuracyBest
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    //指定最小距离更新(米)，默认：kCLDistanceFilterNone
    [BMKLocationService setLocationDistanceFilter:100.f];
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

-(void)backRootController:(NSNotification*)notion
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark -- 条件筛选刷新
- (void)TJsearch
{
    //工作性质
    [SearchModelShare sharedInstance].type = @"";
    [SearchModelShare sharedInstance].job1 = @"";
    [SearchModelShare sharedInstance].keyword = @"";
    
    //全城回调
    if ([SearchModelShare sharedInstance].longitude.length == 0)
    {
        [self hySegmentedControlSelectAtIndex:0];
    }
    //附近回调
    else
    {
        [self hySegmentedControlSelectAtIndex:1];
    }
}
#pragma mark -- 关键字刷新
- (void)keyWordRefresh
{
    //清空筛选条件
        [SearchModelShare sharedInstance].hy = @"";
        [SearchModelShare sharedInstance].job_post = @"";
        [SearchModelShare sharedInstance].cityid = @"";
        [SearchModelShare sharedInstance].salary = @"";
        [SearchModelShare sharedInstance].edu = @"";
        [SearchModelShare sharedInstance].exp = @"";
        [SearchModelShare sharedInstance].type = @"";
    
//        NSLog(@"_job_type%@",_job_type);
//        if ([_job_type isEqual:@"0"])
//        {
////            [SearchModelShare sharedInstance].type = @"";
//        }
//        if ([_job_type isEqual:@"1"])
//        {
////            [SearchModelShare sharedInstance].type = @"56";
//        }
//        if ([_job_type isEqual:@"2"])
//        {
////            [SearchModelShare sharedInstance].type = @"119";
//        }
    
        [SearchModelShare sharedInstance].sdate = @"";
        [SearchModelShare sharedInstance].job1 = @"";

    //全城回调
    if ([SearchModelShare sharedInstance].longitude.length == 0)
    {
        [self hySegmentedControlSelectAtIndex:0];
    }
    //附近回调
    else
    {
        [self hySegmentedControlSelectAtIndex:1];
    }
    
}

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        
        _currentIndex = 0;
        [_jobArr removeAllObjects];
        [self.tableView reloadData];
        
        [SearchModelShare sharedInstance].longitude = @"";
        [SearchModelShare sharedInstance].dimensionality = @"";
        
        /*数据请求**/
        _mbPro = [MBProgressHUD mbHubShow];
        [self loadData:_mbPro page:self.page];
    }
    else
    {
        _currentIndex = 1;
        [_jobArr removeAllObjects];
        [self.tableView reloadData];
        
        AppDelegate *app = [AppDelegate instance];

                [SearchModelShare sharedInstance].longitude = [NSString stringWithFormat:@"%fd",app.longitude];
                [SearchModelShare sharedInstance].dimensionality = [NSString stringWithFormat:@"%fd",app.latitude];
        
//        [SearchModelShare sharedInstance].job_post = @"132";
        /*数据请求**/
        _mbPro = [MBProgressHUD mbHubShow];
        [self loadData:_mbPro page:self.page];
    }
}


-(void)loadData:(id)notify page:(int)num
{
    if(_state.running)
    {
        return;
    }
    //打印出所有字段
    NSLog(@"~~~~~~~~~~~经度%@ 纬度%@ 关键字%@ 行业类别%@ 职位类别%@ 薪资%@ 教育水平%@ 经验%@ 工作性质%@ 发布时间%@ 城市%@ 首页行业%@",[SearchModelShare sharedInstance].longitude,[SearchModelShare sharedInstance].dimensionality,[SearchModelShare sharedInstance].keyword,[SearchModelShare sharedInstance].hy,[SearchModelShare sharedInstance].job_post,[SearchModelShare sharedInstance].salary,[SearchModelShare sharedInstance].edu,[SearchModelShare sharedInstance].exp,[SearchModelShare sharedInstance].type,[SearchModelShare sharedInstance].sdate,[SearchModelShare sharedInstance].cityid,[SearchModelShare sharedInstance].job1);
    
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    
    self.state = [[TH_AFRequestState searchJobWithSucc:^(NSArray *DataArr) {
        

        if (DataArr.count > 0)
        {
            [self.jobArr addObjectsFromArray:DataArr];
            [self.tableView reloadData];
        }
        else
        {
            [MBProgressHUD creatembHub:@"暂无数据"];
        }
        
    } withfail:^(int errCode, NSError *err) {
        
    } withlongitude:[SearchModelShare sharedInstance].longitude dimensionality:[SearchModelShare sharedInstance].dimensionality keyword:[SearchModelShare sharedInstance].keyword page:numStr hy:[SearchModelShare sharedInstance].hy job_post:[SearchModelShare sharedInstance].job_post salary:[SearchModelShare sharedInstance].salary edu:[SearchModelShare sharedInstance].edu exp:[SearchModelShare sharedInstance].exp type:[SearchModelShare sharedInstance].type sdate:[SearchModelShare sharedInstance].sdate job1:[SearchModelShare sharedInstance].job1 cityid:[SearchModelShare sharedInstance].cityid resp:[findJobModel class]] addNotifaction:notify];

}

#pragma mark -
#pragma mark -- 定位代理
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
//    NSLog(@"heading is %@",userLocation.heading);
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %0.2f,long %0.2f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _longitude = userLocation.location.coordinate.longitude;
    _latitude = userLocation.location.coordinate.latitude;
}

- (void)initView
{
    CGFloat y = 0;
    CGFloat margin = 10;
    
    NSArray *iconArr = @[@[@"quancheng_Unselected",@"quancheng_Selected"],@[@"fujin_unSelected",@"fujin_Selected"]];
    
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:y Titles:@[@"全城", @"附近"]  IconNames:iconArr delegate:self] ;
    [self.view addSubview:_segmentedControl];
    
    y += _segmentedControl.frame.size.height;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -  66 - 40 - bottomH )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView =[[UIView alloc] init];
    [self.view addSubview:_tableView];
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.tableView;
    _header.delegate = self;
    //上拉刷新
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.tableView;
    _footer.delegate = self;
    _bottomView = [[UIView alloc]init];
    _bottomView.frame = CGRectMake(0, HEIGHT - bottomH - 66, WIDETH, bottomH);
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.frame = CGRectMake(0, 0, WIDETH, 1);
    bottomLine.backgroundColor = color(221, 221, 221);
    [_bottomView addSubview:bottomLine];
    
    _apllyBtn = [[UIButton alloc]init];
    CGFloat applyBtnH = 30;
    CGFloat applyBtnW = 150;
    _apllyBtn.frame = CGRectMake(0.3 * WIDETH, 50, applyBtnW, applyBtnH);
    [_apllyBtn setTitle:@"申请职位" forState:UIControlStateNormal];
    [_apllyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_apllyBtn addTarget:self action:@selector(apllyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _apllyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _apllyBtn.backgroundColor = color(63, 172, 241);
    _apllyBtn.clipsToBounds = YES;
    _apllyBtn.layer.cornerRadius = 5;
    [_bottomView addSubview:_apllyBtn];
    
    _allSelected = [[UIButton alloc]init];
//    CGFloat allSelectedW =  90;
//    CGFloat allSelectedH =  27.5;
    _allSelected.frame = CGRectMake( 2 *margin, 8, 40, 40);
//    [_allSelected setTitle:@"全选" forState:UIControlStateNormal];
    [_allSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _allSelected.titleLabel.font = [UIFont systemFontOfSize:15];
    _allSelected.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
//    [_allSelected setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
//    [_allSelected setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    [_allSelected setBackgroundImage:[UIImage imageNamed:@"duikuang001"] forState:UIControlStateNormal];
    [_allSelected setBackgroundImage:[UIImage imageNamed:@"duikuang123"] forState:UIControlStateSelected];

    [_allSelected addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_allSelected];
    
    UILabel *quanxuanLab = [[UILabel alloc]init];
    quanxuanLab.text = @"全选";
    quanxuanLab.font = [UIFont systemFontOfSize:13];
    quanxuanLab.frame = CGRectMake(CGRectGetMaxX(_allSelected.frame)+3, 15, 40, 22.5);
    [_bottomView addSubview:quanxuanLab];
    
}

- (void)addCoverView
{
    UIView *converView = [[UIView alloc]initWithFrame:self.view.bounds];
    converView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:converView];
    _corverView = converView;
}

- (void)addAlertView
{
    CGFloat margin = 10;
    
    UIImage *bgimg = [UIImage imageNamed:@"shenqing"];
    CGFloat alertViewX = (WIDETH - bgimg.size.width) / 2;
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(alertViewX, 145, bgimg.size.width, bgimg.size.height)];
    alertView.backgroundColor = [UIColor colorWithPatternImage:bgimg];
    [self.view addSubview:alertView];
    _alertView = alertView;
    
    UILabel *lab1 = [[UILabel alloc]init];
    lab1.text = @"申请职位";
    lab1.textColor =[UIColor whiteColor];
    lab1.font = [UIFont systemFontOfSize:13];
    CGSize labSize = [lab1.text sizeWithFont:lab1.font];
    lab1.frame = CGRectMake(margin, margin, labSize.width, labSize.height);
    [alertView addSubview:lab1];
    
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
    CGFloat closeWith = 10;
    closeBtn.frame = CGRectMake(alertView.frame.size.width - margin - closeWith, margin, closeWith, closeWith);
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    //    UIButton *jianliBtn = [[UIButton alloc]init];
    //    [jianliBtn setTitle:@"您投递10个职位，2个职位已经投递，一周内不能重复投递职位。" forState:UIControlStateNormal];
    //    [jianliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    jianliBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    ////    [jianliBtn setImage:[UIImage imageNamed:@"duihaolan"] forState:UIControlStateNormal];
    //    jianliBtn.frame = CGRectMake(margin, 40, 400, 50);
    //    [alertView addSubview:jianliBtn];

    UITextView *jianliBtn = [[UITextView alloc]init];
    jianliBtn.text = [NSString stringWithFormat:@"您投递%d个职位，%d个职位已经投递，一周内不能重复投递职位。",_mailingNumBer,(_mailingNumBer - _TDSuccNum)];
    jianliBtn.font = [UIFont systemFontOfSize:13];
    jianliBtn.frame = CGRectMake(margin, 40, 300, 50);
    [alertView addSubview:jianliBtn];
    jianliBtn.editable = NO;
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    okBtn.backgroundColor = color(63, 172, 241);
    CGFloat okBtnW =( 1- 0.34 * 2) * alertView.frame.size.width;
    okBtn.frame = CGRectMake(0.34 * alertView.frame.size.width, 100 , okBtnW, 30);
    okBtn.clipsToBounds = YES;
    okBtn.layer.cornerRadius = 5;
    [okBtn addTarget:self action:@selector(okBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:okBtn];
    
}

- (void)removeCoverAndAlert
{
    [_corverView removeFromSuperview];
    _corverView = nil;
    
    [_alertView removeFromSuperview];
    _alertView = nil;
}

- (void)querData
{
    _jobArr = [[NSMutableArray alloc]init];
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"findjobtest" ofType:@"plist"];
    _jobArr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    THLog(@"jobarr:%@",_jobArr);
}

#pragma mark tabViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    jobTableViewCell *cell = (jobTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    jobTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[jobTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (_currentIndex == 0)
    {
        if(self.jobArr.count >0)
        {
        findJobModel * model = self.jobArr[indexPath.row];
        cell.positionLab.text = model.job_name;
        cell.companyLab.text = model.com_name;
        cell.cityLab.text =  model.provinceid;
        cell.knowledgeLab.text = model.edu;
        NSString * dateStr = model.lastupdate;
        cell.timeLab.text = [dateStr substringFromIndex:5];
       
        cell.salaryLab.text = model.salary;
        cell.jobSelected = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
        [cell.positionSecBtn addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell layoutSubviews];
        }
    }
    else
    {
        if (self.jobArr.count > 0)
        {
            findJobModel * model = self.jobArr[indexPath.row];
            cell.positionLab.text = model.job_name;
            cell.companyLab.text = model.com_name;
            cell.cityLab.text =  model.provinceid;
            cell.knowledgeLab.text = model.edu;
            NSString * dateStr = model.lastupdate;
            cell.timeLab.text = [dateStr substringFromIndex:5];
            
            cell.salaryLab.text = model.salary;
            cell.jobSelected = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
            [cell.positionSecBtn addTarget:self action:@selector(singleClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell layoutSubviews];
        }
    }
    
    return cell;
}
#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 1;
        THLog(@"");
        [self.jobArr removeAllObjects];
        
        [self loadData:refreshView page:_page];
    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        [self loadData:refreshView page:_page];
        
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _jobArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.editing) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
        findJobModel *fjModel = _jobArr[indexPath.row];
        
        TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
        record_index = indexPath;
        detail.uid = [fjModel.uid intValue];
        detail.pid = [fjModel.job_id intValue];
        detail.saveBOOL = 1;
//        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
//        NSLog(@"uid%@",[df objectForKey:@"uid"]);
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    
}

#pragma mark -- respondEvent
- (void)allClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //选中所有
        for (int i = 0; i<_jobArr.count; i++) {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            findJobModel *model = self.jobArr[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"1";
        }
        
        [_tableView reloadData];
        
    }
    else
    {
        sender.selected = NO;
        //失选所有
        for (int i = 0; i<_jobArr.count; i++)
        {
            //            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            findJobModel *model = self.jobArr[i];
            //            _jobArr[i][@"selected"] = @"1";
            model.cellselected = @"0";
        }
        [_tableView reloadData];
    }
}

- (void)singleClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        
        jobTableViewCell *cell = (jobTableViewCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        findJobModel *fjModel = self.jobArr[indexPath.row];
        fjModel.cellselected = @"1";
        //        [_cellIndeSet addIndex:indexPath.row];
        
    }
    else
    {
        sender.selected = NO;
        
        jobTableViewCell *cell = (jobTableViewCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        findJobModel *fjModel = self.jobArr[indexPath.row];
        fjModel.cellselected = @"0";
        //        [_cellIndeSet removeIndex:indexPath.row];
    }
    
}


- (void)rightClick
{
    THLog(@"条件选择按钮被点击");
    
    TH_JobScreeningVC * job = [[TH_JobScreeningVC alloc] init];
    job.title = @"职位搜索";
    [self.navigationController pushViewController:job animated:YES];
}

- (void)rightClick2
{
    THLog(@"放大镜被点击");
    
}

#pragma mark  -- 职位申请按钮
- (void)apllyBtnClick
{
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
    if([AppDelegate instance].userId)
    {
        
        _mailingNumBer = 0;
        //遍历哪个职位被选中
        NSMutableString *job_idStr = [[NSMutableString alloc]init];
        for (findJobModel *model in self.jobArr)
        {
            if ([model.cellselected isEqualToString: @"1"])
            {
                _mailingNumBer++;
                [job_idStr appendString:[NSString stringWithFormat:@"%@,",model.job_id]];
                
            }
            
        }
        NSLog(@"job_idStr%@",job_idStr);
        
       self.state = [[TH_AFRequestState SQJobWithSucc:^(NSString *DataArr) {
            
            //总投递数-投递成功数
            if (( _mailingNumBer - [DataArr intValue] ) == 0)
            {
                 [MBProgressHUD creatembHub:@"投递成功"];
            }
            else
            {
                //如果有失败的情况下
               //返回的是投递成功的数量
                            NSLog(@"%@",DataArr);
                            _TDSuccNum = [DataArr intValue];
                
                            [self addCoverView];
                            
                            [self addAlertView];
            }
            

            
        } withfail:^(int errCode, NSError *err) {
            
            NSLog(@"%d",errCode);
            
            //errCode = 2, 全部都投递过了
            if (errCode == 1)
            {
                [MBProgressHUD creatembHub:@"请先创建一份简历"];
            }
            if (errCode == 2)
            {
                [MBProgressHUD creatembHub:@"您已经投递过了，一周之内不能投递"];
            }
//            //投递成功的职位为0
//            _TDSuccNum = 0;
//            [self addCoverView];
//            [self addAlertView];
            
        } withUid:nil job_id:job_idStr resp:[NSObject class]] addNotifaction:[MBProgressHUD mbHubShow]];
    
    }
    else
    {
       
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alertView.delegate = self;
        [alertView show];
    }
}

#pragma mark -- alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        TH_LoginVC * login =[[TH_LoginVC alloc] init];
        login.findJobApplications = @"findJobApplications";
        [self.navigationController pushViewController:login animated:YES];

    }
}

- (void)closeBtn
{
    THLog(@"close被点击");
    //    for (int i ; i< _jobArr.count; i++)
    //    {
    //        _jobArr[i][@"selected"] = @"0";
    //    }
    [self removeCoverAndAlert];
}

- (void)okBtn
{
    THLog(@"确定被点击");
    //    for (int i ; i< _jobArr.count; i++)
    //    {
    //        _jobArr[i][@"selected"] = @"0";
    //    }
    
    [self removeCoverAndAlert];
}

- (void)searchBtnClick
{
    THLog(@"搜索被点击");
    SearchJobVC * search = [[SearchJobVC alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    
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
