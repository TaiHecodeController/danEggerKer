//
//  TH_FindJobVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_FindJobVC.h"
#import "HYSegmentedControl.h"
#import "jobTableViewCell.h"
#import "UIBarButtonItem+DC.h"
#import "jobModel.h"
#import "TH_JobDetailVC.h"
#import "TH_JobScreeningVC.h"
#import "SearchJobVC.h"
#import "TH_SearchVC.h"
#define bottomH 107


@interface TH_FindJobVC ()<UITableViewDataSource,UITableViewDelegate>

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

@end

@implementation TH_FindJobVC
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:NO];
//    self.navigationController.navigationBarHidden = NO;
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"sousuo001"] forState:UIControlStateNormal];
      [searchBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    searchBtn.frame = CGRectMake(WIDETH - 10 - 50 - 20,0, 44, 44);
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchBtn];
    _searchBtn = searchBtn;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:NO];
    
    [_searchBtn removeFromSuperview];
        
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
  
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNormalImageName:@"liebiao" hightImageName:nil action:@selector(rightClick) target:self];
    
    
    
//    [self addRightBtn2_NormalImageName:@"sousuo001" hightImageName:nil action:@selector(rightClick2) target:self];
    
    [self initView];
    
    [self querData];
    
    [self hySegmentedControlSelectAtIndex:0];
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
    [self.view addSubview:_tableView];
    
    _bottomView = [[UIView alloc]init];
    _bottomView.frame = CGRectMake(0, HEIGHT - bottomH - 66, WIDETH, bottomH);
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.frame = CGRectMake(10, 0, WIDETH, 1);
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
    CGFloat allSelectedW =  90;
    CGFloat allSelectedH =  20;
    _allSelected.frame = CGRectMake(0, 15, allSelectedW, allSelectedH);
    [_allSelected setTitle:@"全选" forState:UIControlStateNormal];
    [_allSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _allSelected.titleLabel.font = [UIFont systemFontOfSize:13];
    _allSelected.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [_allSelected setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
    [_allSelected setImage:[UIImage imageNamed:@"douyouduihao"] forState:UIControlStateSelected];
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
    closeBtn.frame = CGRectMake(alertView.frame.size.width - margin - 20, margin, 20, 20);
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:closeBtn];
    
    UIButton *jianliBtn = [[UIButton alloc]init];
    [jianliBtn setTitle:@"个人简历20150703" forState:UIControlStateNormal];
    [jianliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jianliBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [jianliBtn setImage:[UIImage imageNamed:@"duihaolan"] forState:UIControlStateNormal];
    jianliBtn.frame = CGRectMake(margin, 40, 125, 50);
    [alertView addSubview:jianliBtn];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

#pragma mark - http
- (void)startHttpRequest
{
    //    __weak typeof(self) weakSelf = self;
    //
    //    //模糊查询景点
    //    MTSearchScenicRequest *request = [MTSearchScenicRequest requestWithKeyword:_keyword cityCode:_cityCode limit:20 offset:0];
    //
    //    [MTConnection startRequest:request onTarget:weakSelf withBlock:^(BOOL success, MTRespDataSourceType sourceType, MTURLResponse *response)
    //     {
    //
    //         MTSearchScenicResponse *rp = (MTSearchScenicResponse *)response;
    //
    //         if (rp.scenicList && rp.scenicList.count > 0)
    //         {
    //             dataArray = [weakSelf getArray:rp.scenicList length:2];
    //             [_gridView reloadData];
    //         }
    //         else
    //         {
    //             //无符合信息
    //             [weakSelf showHttpErrorInfo:nil info:nil];
    //         }
    //     }];
}

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        
        _currentIndex = 0;
        //        [dataArray removeAllObjects];
        //        [dataArray addObject:@"1"];
        //        [dataArray addObject:@"2"];
        //        [dataArray addObject:@"3"];
        //        [dataArray addObject:@"4"];
        //        [dataArray addObject:@"5"];
        
        [_tableView reloadData];
        //        _tableView.hidden = YES;
        //        _gridView.hidden = NO;
    }
    else
    {
        _currentIndex = 1;
        //        [dataArray removeAllObjects];
        //        [dataArray addObject:@"11"];
        //        [dataArray addObject:@"22"];
        //        [dataArray addObject:@"33"];
        //        [dataArray addObject:@"44"];
        //        [dataArray addObject:@"55"];
        
        [_tableView reloadData];
        //        _gridView.hidden = YES;
        //        _tableView.hidden = NO;
    }
}

#pragma mark tabViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    jobTableViewCell *cell = (jobTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.cellHeight;
//        return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
//    RKRankCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    jobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[jobTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (_currentIndex == 0)
    {
//        cell.numLab.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
//        cell.headIcon.image = [UIImage imageNamed:@"rankilau"];
//        cell.name = @"USER1";
//        cell.price = @"100";
//        cell.lab.commonLab.text = @"共送出了";
//        [cell adjustFrame];
        
        cell.positionLab.text = _jobArr[indexPath.row][@"positionName"];
        cell.companyLab.text = @"苏宁消费金融有限公司";
        cell.cityLab.text = @"北京";
        cell.knowledgeLab.text = @"大专";
        cell.timeLab.text = @"7-30";
        cell.salaryLab.text = @"5k-7k";
        cell.jobSelected = _jobArr[indexPath.row][@"selected"];
        [cell layoutSubviews];
    }
    else
    {
//        cell.numLab.text = [NSString stringWithFormat:@"%ld.",indexPath.row + 1];
//        [cell.headIcon sd_setImageWithURL:[NSURL URLWithString:@"http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg"] placeholderImage:nil];
//        cell.name = @"USER1";
//        cell.price = @"200";
//        cell.lab.commonLab.text = @"共收到了";
//        [cell adjustFrame];
     
        cell.positionLab.text = _jobArr[indexPath.row][@"positionName"];
        cell.companyLab.text = @"苏宁消费金融有限公司";
        cell.cityLab.text = @"北京";
        cell.knowledgeLab.text = @"大专";
        cell.timeLab.text = @"7-30";
        cell.salaryLab.text = @"5k-7k";
        cell.jobSelected = _jobArr[indexPath.row][@"selected"];
        
        [cell layoutSubviews];

    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return dataArray.count;
    return _jobArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.editing) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
    TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
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
            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            _jobArr[i][@"selected"] = @"1";
        }
        [_tableView reloadData];

    }
    else
    {
        sender.selected = NO;
        
        //失选所有
        for (int i = 0; i<_jobArr.count; i++) {
            NSLog(@"_jobarr[%d]=%@", i, _jobArr[i]);
            _jobArr[i][@"selected"] = @"0";
        }
        [_tableView reloadData];
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

- (void)apllyBtnClick
{
    THLog(@"职位申请被点击");
    
    [self addCoverView];
    
    [self addAlertView];
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
