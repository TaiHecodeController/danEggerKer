//
//  TH_JobWishlistVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
// 收藏职位

#import "TH_JobWishlistVC.h"
#import "HYSegmentedControl.h"
#import "jobTableViewCell.h"
#import "UIBarButtonItem+DC.h"
#import "jobModel.h"
#import "TH_JobDetailVC.h"
#import "jobListCell.h"
#import "saveListModel.h"
#define bottomH 107

#import "MJRefresh.h"

#import "Me_Request.h"

@interface TH_JobWishlistVC ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

{
    NSIndexPath  * record_index;

}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *allSelected;
@property (nonatomic, strong) UIButton *apllyBtn;
@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, strong) NSMutableArray *jobArr;
@property (nonatomic, strong) UIView *corverView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) NSMutableIndexSet *cellIndeSet;
@property (nonatomic, strong) NSMutableArray * cellArray;
@property (nonatomic, strong) AFRequestState *state;
@property (nonatomic, assign) int page;
@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property (nonatomic, assign) int TDSuccNum;
@property (nonatomic, assign) int mailingNumBer;
@property (nonatomic, assign) int jiluNum;

@end

@implementation TH_JobWishlistVC

-(void)dealloc
{
    [_header free];
    [_footer free];
}
-(void)viewDidAppear:(BOOL)animated
{
    jobListCell * cell = self.cellArray[record_index.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNormalImageName:@"liebiao" hightImageName:nil action:@selector(rightClick) target:self];
//    
//    [self addRightBtn2_NormalImageName:@"sousuo001" hightImageName:nil action:@selector(rightClick2) target:self];
    
    _cellIndeSet = [[NSMutableIndexSet alloc]init];
    
    [self initView];
    _jobArr = [[NSMutableArray alloc]init];
    self.page = 1;
    MBProgressHUD *mb = [MBProgressHUD mbHubShow];
    [self loadData:mb page:self.page];
    
}


- (void)initView
{
    
    CGFloat y = 0;
    CGFloat margin = 10;
    
    NSArray *iconArr = @[@[@"quancheng_Unselected",@"quancheng_Selected"],@[@"fujin_unSelected",@"fujin_Selected"]];
    
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:y Titles:@[@"全程", @"附近"]  IconNames:iconArr delegate:self] ;
//    [self.view addSubview:_segmentedControl];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *numLab = [[UILabel alloc]init];
//    numLab.text = @"15条记录";
    numLab.text = [NSString stringWithFormat:@"%d条记录",_jiluNum];
    numLab.font = [UIFont systemFontOfSize:13];
    CGSize numSize = [@"15条记录" sizeWithFont:numLab.font];
    CGFloat numLabX = WIDETH - numSize.width - margin;
    CGFloat numLabY = (headView.frame.size.height - numSize.height) / 2;
    numLab.frame = CGRectMake(numLabX, numLabY, numSize.width, numSize.height);
    [headView addSubview:numLab];
    _numLab = numLab;
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = color(221, 221, 221);
    lineView.frame = CGRectMake(0, CGRectGetHeight(headView.frame) - 0.5, WIDETH, 0.5);
    [headView addSubview:lineView];
    
    y += headView.frame.size.height;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - y - 66 - bottomH )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
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
    bottomLine.frame = CGRectMake(10, 0, WIDETH, 1);
    bottomLine.backgroundColor = color(221, 221, 221);
    [_bottomView addSubview:bottomLine];
    
    _apllyBtn = [[UIButton alloc]init];
    CGFloat applyX = 80;
    CGFloat applyBtnH = 30;
    CGFloat applyBtnW = ((WIDETH - applyX * 2) - 15) / 2;
    _apllyBtn.frame = CGRectMake(applyX, 50, applyBtnW, applyBtnH);
    [_apllyBtn setTitle:@"申请职位" forState:UIControlStateNormal];
    [_apllyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_apllyBtn addTarget:self action:@selector(apllyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _apllyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _apllyBtn.backgroundColor = color(63, 172, 241);
    _apllyBtn.clipsToBounds = YES;
    _apllyBtn.layer.cornerRadius = 5;
    [_bottomView addSubview:_apllyBtn];
    
    _removeBtn = [[UIButton alloc]init];
    CGFloat removeX = applyX + applyBtnW + 15;
    CGFloat removeBtnH = 30;
    CGFloat removeBtnW = ((WIDETH - applyX * 2) - 15) / 2;
    _removeBtn.frame = CGRectMake(removeX, 50, removeBtnW, removeBtnH);
    [_removeBtn setTitle:@"删除职位" forState:UIControlStateNormal];
    [_removeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_removeBtn addTarget:self action:@selector(removeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _removeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _removeBtn.backgroundColor = color(242, 69, 62);
    _removeBtn.clipsToBounds = YES;
    _removeBtn.layer.cornerRadius = 5;
    [_bottomView addSubview:_removeBtn];
    
    
    _allSelected = [[UIButton alloc]init];
    CGFloat allSelectedW =  90;
    CGFloat allSelectedH =  20;
    _allSelected.frame = CGRectMake(0, 15, allSelectedW, allSelectedH);
    [_allSelected setTitle:@"全选" forState:UIControlStateNormal];
    [_allSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _allSelected.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    _allSelected.titleLabel.font = [UIFont systemFontOfSize:13];
    [_allSelected setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [_allSelected setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
    [_allSelected addTarget:self action:@selector(allClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_allSelected];
    
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


-(void)loadData:(id)notify page:(int)num
{
    if(_state.running)
    {
        return;
    }
    
    if (_pushType == 0)
    {
        //投递职位列表
        self.state = [[Me_Request TDjobListWithSucc:^(NSArray *DataArr) {
            
            [_jobArr addObjectsFromArray:DataArr];
            [self.tableView reloadData];
             self.jiluNum = _jobArr.count;
            [self setValueForJilu:self.jiluNum];
            
        } withfail:^(int errCode, NSError *err) {
            
        } withUid:nil page:num limit:5 resp:[saveListModel class]] addNotifaction:notify];
    }
    
    if (_pushType == 1)
    {
        //搜藏职位列表
        self.state = [[TH_AFRequestState saveJobListSucc:^(NSArray *DataArr) {
    
             [_jobArr addObjectsFromArray:DataArr];
            [self.tableView reloadData];
            self.jiluNum = _jobArr.count;
             [self setValueForJilu:self.jiluNum];
    
        } withfail:^(int errCode, NSError *err) {
    
            NSLog(@"%@",err);
    
        } withUid:nil page:num limit:10 resp:[saveListModel class]] addNotifaction:notify];

    }
    
}

- (void)setValueForJilu:(int)num
{
    _numLab.text = [NSString stringWithFormat:@"%d条记录",num];
}

#pragma mark tabViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    jobListCell *cell = (jobListCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
    //        return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    //    RKRankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    jobListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[jobListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
   [cell.positionSecBtn addTarget:self action:@selector(positionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_currentIndex == 0)
    {
        if (_jobArr.count >0)
        {
            saveListModel *model = _jobArr[indexPath.row];
            cell.positionLab.text = model.job_name;
            cell.companyLab.text = model.com_name;
            cell.cityLab.text = model.provinceid;
            cell.knowledgeLab.text = model.edu;
            cell.timeLab.text = model.lastupdate;
            cell.salaryLab.text = model.salary;
            cell.jobSelected = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
            [cell layoutSubviews];

        }
    }
    else
    {
        if (_jobArr.count > 0)
        {
            saveListModel *model = _jobArr[indexPath.row];
            cell.positionLab.text = model.job_name;
            cell.companyLab.text = model.com_name;
            cell.cityLab.text = model.provinceid;
            cell.knowledgeLab.text = model.provinceid;
            cell.timeLab.text = model.lastupdate;
            cell.salaryLab.text = model.salary;
            cell.jobSelected = (model.cellselected.length == 0) ? (@"0") : (model.cellselected);
            [cell layoutSubviews];

        }
    }
    
    return cell;
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
{
    if (tableView.editing) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
        findJobModel *fjModel = _jobArr[indexPath.row];
        TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
        record_index = indexPath;
        detail.saveBOOL = 0;
        detail.uid = [fjModel.com_id intValue];
        detail.pid = [fjModel.job_id intValue];
        [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 1;
        [_jobArr removeAllObjects];
        [self loadData:refreshView page:_page];
    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        [self loadData:refreshView page:_page];
        
        
    }
}


#pragma mark -- respondEvent
- (void)allClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        //选中所有
        for (int i = 0; i<_jobArr.count; i++)
        {
            saveListModel *slModel = _jobArr[i];
            slModel.cellselected = @"1";
            [_cellIndeSet addIndex:i];
        }
        [_tableView reloadData];
        
    }
    else
    {
        sender.selected = NO;
        
        //失选所有
        for (int i = 0; i<_jobArr.count; i++) {
            saveListModel *slModel = _jobArr[i];
            slModel.cellselected = @"0";
            [_cellIndeSet removeIndex:i];
        }
        [_tableView reloadData];
    }
}

- (void)apllyBtnClick:(UIButton *)sender
{
    THLog(@"职位申请被点击");
    
    if (sender.selected == NO)
    {
        _mailingNumBer = 0;
        //遍历哪个职位被选中
        NSMutableString *job_idStr = [[NSMutableString alloc]init];
        for (saveListModel *model in self.jobArr)
        {
            if ([model.cellselected isEqualToString: @"1"])
            {
                _mailingNumBer++;
                [job_idStr appendString:[NSString stringWithFormat:@"%@,",model.id]];
                
            }
            
        }
        NSLog(@"job_idStr%@",job_idStr);
        
        [TH_AFRequestState SQJobWithSucc:^(NSString *DataArr) {
            
            //返回的是投递成功的数量
            NSLog(@"%@",DataArr);
            _TDSuccNum = [DataArr intValue];
            
            [self addCoverView];
            
            [self addAlertView];
            
        } withfail:^(int errCode, NSError *err) {
            
            NSLog(@"%d",errCode);
            
            //errCode = 2, 全部都投递过了
            
            //投递成功的职位为0
            _TDSuccNum = 0;
            [self addCoverView];
            [self addAlertView];
            
            
        } withUid:6 job_id:job_idStr resp:[NSObject class]];
        
    }
    else
    {
        [MBProgressHUD creatembHub:@"操作频率过高"];
    }
    
    sender.selected = !sender.selected;
    
    
}

- (void)removeBtnClick
{
    THLog(@"删除职位被点击");
    
    if (_pushType == 0)
    {
        //删除投递过的
        NSMutableString *str = [[NSMutableString alloc]init];
        for (saveListModel *slModel in _jobArr)
        {
            if ([slModel.cellselected  isEqual: @"1"])
            {
                NSString *str1 = [NSString stringWithFormat:@"%@,",slModel.job_id];
                [str appendString:str1];
            }
        }
        
        [TH_AFRequestState deleteSQJobWithSucc:^(NSDictionary *DataArr) {
            
            _page = 1;
            [_jobArr removeAllObjects];
            MBProgressHUD *mb = [MBProgressHUD mbHubShow];
            [self loadData:mb page:_page];
            [self.tableView reloadData];
            
        } withfail:^(int errCode, NSError *err) {
            
        } withUid:nil job_idStr:str resp:[NSObject class]];

    }
    else
    {
        //删除收藏职位
        NSMutableString *str = [[NSMutableString alloc]init];
        for (saveListModel *slModel in _jobArr)
        {
            if ([slModel.cellselected  isEqual: @"1"])
            {
                NSString *str1 = [NSString stringWithFormat:@"%@,",slModel.job_id];
                [str appendString:str1];
            }
        }
        
        [TH_AFRequestState deleteJobWithSucc:^(NSDictionary *DataArr) {
            
            _page = 1;
            [_jobArr removeAllObjects];
            MBProgressHUD *mb = [MBProgressHUD mbHubShow];
            [self loadData:mb page:_page];
            [self.tableView reloadData];
            
        } withfail:^(int errCode, NSError *err) {
            
            
            
        } withUid:nil job_idStr:str resp:[NSObject class]];
    }
    
    
   
    
    
}

- (void)positionBtnClick:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        
      jobListCell *cell = (jobListCell *)[sender superview];
      NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
      THLog(@"_cellIndexSet增加%ld",(long)indexPath.row);
      [_cellIndeSet addIndex:indexPath.row];
      saveListModel *slModel = _jobArr[indexPath.row];
      slModel.cellselected = @"1";
        
    }
    else
    {
        sender.selected = NO;
        
        jobListCell *cell = (jobListCell *)[sender superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        THLog(@"_cellIndexSet减少%ld",(long)indexPath.row);
        [_cellIndeSet removeIndex:indexPath.row];
        saveListModel *slModel = _jobArr[indexPath.row];
        slModel.cellselected = @"0";
    }
}

- (void)closeBtn
{
    THLog(@"close被点击");
    [self removeCoverAndAlert];
}

- (void)okBtn
{
    THLog(@"确定被点击");
    
    [self removeCoverAndAlert];
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
