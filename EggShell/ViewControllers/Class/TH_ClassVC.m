//
//  TH_ClassVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_ClassVC.h"
#import "HYSegmentedControl.h"
#import "jobTableViewCell.h"
#import "UIBarButtonItem+DC.h"
#import "jobModel.h"
#import "TH_JobDetailVC.h"
#import "OpenClassCell.h"
//#import "MoviePlayerViewController.h"
#import "THCoursePlayVC.h"

#import "OpenClassVideoListRequest.h"
#import "OpenClassModel.h"
#import "UIImageView+WebCache.h"
//#import "MJRefresh.h"
#import "MTSpecailtyListPointItem.h"
#import "NSIndexPath+RK_row_col.h"

#define bottomH 107

@interface TH_ClassVC ()<MJRefreshBaseViewDelegate>
{
    int                 gap;
}

@property (nonatomic, strong) HYSegmentedControl *segmentedControl;
@property (nonatomic, assign) int currentIndex;
@property (nonatomic, strong) NSMutableArray *openClassList;
@property (nonatomic, assign) CGFloat headViewMaxY;
@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) MTGridView *_gridView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic,strong)MJRefreshFooterView *  footer;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,assign)int page;
@property (nonatomic, strong) NSArray *teacherArr;

@end

@implementation TH_ClassVC

-(void)dealloc
{
    
    [_header free];
    [_footer free];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公开课";
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;

    self.dataArray =[[NSMutableArray alloc]init];
    self.page = 1;
    MBProgressHUD * mub = [MBProgressHUD mbHubShow];
    [self loadData:mub page:self.page];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = color(243, 243, 241);
   
    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNormalImageName:@"liebiao" hightImageName:nil action:@selector(rightClick) target:self];
//    
//    [self addRightBtn2_NormalImageName:@"sousuo001" hightImageName:nil action:@selector(rightClick2) target:self];
    
    [self querTeacherFCVideo];
    
    [self initSegView];
    
    
    
    [self querData];
    
    [self hySegmentedControlSelectAtIndex:0];
    
   
    
}

-(void)loadData:(id)notify page:(int)num
{
    if(_state.running)
    {
        return;
    }
    
    NSString * page = [NSString stringWithFormat:@"%d",num];

    __weak typeof (self) weakSelf = self;
    
    _state = [[OpenClassVideoListRequest requestWithSucc:^(NSArray *DataDic) {
        
                [weakSelf.dataArray addObjectsFromArray:[weakSelf getArray:DataDic length:2]];
                [weakSelf._gridView reloadData];
        

    } resp:[OpenClassModel class] paramPage:page Pagesize:@"2"] addNotifaction:notify];
    
}

- (void)querTeacherFCVideo
{

    [OpenClassVideoListRequest requestTeacherWithSucc:^(NSArray *DataDic) {
        
        NSLog(@"%@",DataDic);
        _teacherArr = [NSMutableArray arrayWithArray:DataDic];
        [self initTableView];
        
    } resp:[NSObject class] paramPage:@"1" Pagesize:@"1"];
}

- (void)initSegView
{
    
    CGFloat y = 0;
//    CGFloat margin = 10;
    
//    NSArray *iconArr = @[@[@"shipin2",@"shipin"],@[@"yuyin2",@"yuyin"]];
     NSArray *iconArr = @[@[@"shipin2",@"shipin"]];
    
    _segmentedControl = [[HYSegmentedControl alloc] initWithOriginY:y Titles:@[@"视频课程"]  IconNames:iconArr delegate:self] ;
//    [self.view addSubview:_segmentedControl];
    
}

- (void)querData
{
    
    __weak typeof (self) weakSelf = self;
    
//    [OpenClassVideoListRequest requestWithSucc:^(NSArray *DataDic) {
//        
////        _openClassList = [NSMutableArray arrayWithArray:DataDic];
//        
//        [weakSelf.dataArray addObjectsFromArray:DataDic];
//        weakSelf.dataArray = [weakSelf getArray:DataDic length:2];
//        [weakSelf._gridView reloadData];
//        
//    } resp:[OpenClassModel class]];
}

#pragma mark -- configConllectionView
- (void)initTableView
{
    CGFloat segHeight = 40;
    CGFloat margin = 20;
    CGFloat minimargin = 10;
    CGFloat y = 0 ;
    
    UIView *headView = [[UIView alloc]init];
    _headView = headView;
    headView.frame = CGRectMake(0, y, WIDETH, 154);
    headView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:headView];
    
    CGSize msfcSize = [@"名师风采" sizeWithFont:[UIFont systemFontOfSize:15]];
    UILabel *msfcLab = [[UILabel alloc]initWithFrame:CGRectMake(margin, minimargin, msfcSize.width, msfcSize.height)];
    msfcLab.text = @"名师风采";
    msfcLab.font = [UIFont systemFontOfSize:15];
    msfcLab.textColor = UIColorFromRGB(000000);
    [headView addSubview:msfcLab];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    lineView.frame = CGRectMake(0, CGRectGetMaxY(msfcLab.frame) + minimargin, WIDETH, 0.5);
    [headView addSubview:lineView];
    
    int count = 3;
    //边距
    CGFloat qsBtnMargin = 20;
    //宽高
    CGFloat qsBtnW = 0.24 * WIDETH;
    CGFloat qsBtnH = qsBtnW;
    //中间距离
    CGFloat middleMargin = (WIDETH - (count * qsBtnW) - 2 * qsBtnMargin) / (count - 1);
//    for (int i = 0; i < count; i++)
//    {
//        UIButton *qsBtn = [[UIButton alloc]init];
//        CGFloat qsBtnX = qsBtnMargin + i * (qsBtnW + middleMargin);
//        CGFloat qsBtnY = CGRectGetMaxY(lineView.frame) + 15;
//        qsBtn.frame = CGRectMake(qsBtnX, qsBtnY, qsBtnW, qsBtnH);
//        qsBtn.tag = 1000 + i;
//        [qsBtn addTarget:self action:@selector(qsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
////        qsBtn.backgroundColor = [UIColor blackColor];
////        UIImageView *iconview = [[UIImageView alloc]init];
////        [iconview sd_setImageWithURL:[NSURL URLWithString:_teacherArr[i][@"vimage"]] placeholderImage:nil];
//        [qsBtn setBackgroundImage:nil forState:UIControlStateNormal];
//        [headView addSubview:qsBtn];
//        _headViewMaxY = CGRectGetMaxY(qsBtn.frame);
//    }
        for (int i = 0; i < count; i++)
        {
            UIImageView *qsBtn = [[UIImageView alloc]init];
            CGFloat qsBtnX = qsBtnMargin + i * (qsBtnW + middleMargin);
            CGFloat qsBtnY = CGRectGetMaxY(lineView.frame) + 15;
            qsBtn.frame = CGRectMake(qsBtnX, qsBtnY, qsBtnW, qsBtnH);
            qsBtn.tag = 1000 + i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(qsBtnClick:)];
            [qsBtn addGestureRecognizer:tap];
            qsBtn.userInteractionEnabled = YES;
//            [qsBtn addTarget:self action:@selector(qsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //        qsBtn.backgroundColor = [UIColor blackColor];
    //        UIImageView *iconview = [[UIImageView alloc]init];
            [qsBtn sd_setImageWithURL:[NSURL URLWithString:_teacherArr[i][@"vimage"]] placeholderImage:nil];
            [headView addSubview:qsBtn];
            _headViewMaxY = CGRectGetMaxY(qsBtn.frame);
        }

    
    headView.frame = CGRectMake(0, y, WIDETH, _headViewMaxY + 15);
    
    UIView *marginView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), WIDETH, 10)];
    marginView.backgroundColor = UIColorFromRGB(0xf3f3f1);
    [headView addSubview:marginView];
    
    UIView *hotView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(marginView.frame), WIDETH, 34)];
    [headView addSubview:hotView];
    
    UILabel *hotLab = [[UILabel alloc]init];
    hotLab.text = @"热门课程";
    hotLab.font = [UIFont systemFontOfSize:15];
    CGSize msfcSize1 = [@"热门课程" sizeWithFont:[UIFont systemFontOfSize:15]];
    hotLab.frame = CGRectMake(10, 10, msfcSize1.width, msfcSize1.height);
    hotLab.textColor = UIColorFromRGB(000000);
    [hotView addSubview:hotLab];
    
    UIView *hotLine = [[UIView alloc]init];
    hotLine.frame = CGRectMake(0, CGRectGetHeight(hotView.frame) - 0.5, WIDETH, 0.5);
    hotLine.backgroundColor = UIColorFromRGB(0xdddddd);
    [hotView addSubview:hotLine];
    
    headView.frame = CGRectMake(0, y, WIDETH, _headViewMaxY + 15 + marginView.frame.size.height + hotView.frame.size.height + 15);
    
    gap = 5;
    self._gridView = [[MTGridView alloc]initWithFrame:CGRectMake(0, 44 - segHeight, WIDETH, HEIGHT - 44  - 90)];
    self._gridView.delegate = self;
    self._gridView.dataSource = self;
    self._gridView.columnSpace = 20;
    self._gridView.rowSpace = 15;
    self._gridView.paddingEdge = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.view addSubview:self._gridView];
    self._gridView.headerView = headView;
    
    //下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.scrollView = [self._gridView gridTabelView];
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = [self._gridView gridTabelView];
    _footer.delegate = self;
}

#pragma mark -- MJRefresh
//- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
//{
//    if( refreshView == _header ){
//
//        THLog(@"");
//    }
//    else{
//
//        THLog(@"上拉加载更多");
//    }
//}

#pragma  mark -- gridViewDelegate
- (MTGridViewItem *)gridView:(MTGridView *)gridView itemForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"identifier";
    
    MTSpecailtyListPointItem *cell =(MTSpecailtyListPointItem *)[gridView dequeueReusableItemWithIdentifier:identifier  atColIndex:0];
    
    if (cell == nil)
    {
        cell = [[MTSpecailtyListPointItem alloc]initWithStyle:MTGridViewItemStyleDefault identifier:identifier];
    }
    
    if (_currentIndex == 0)
    {
        OpenClassModel *model = self.dataArray[indexPath.rowIndex][indexPath.columnIndex];
        
        [cell.coverView sd_setImageWithURL:[NSURL URLWithString:model.vimage] placeholderImage:[UIImage imageNamed:@"remen"]];
        cell.nameLab.text = model.video_teacher;
        //        cell.coverView.image = [UIImage imageNamed:@"remen"];
        //        cell.nameLab.text = @"王老师";
        [cell.redXinBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [cell.redXinBtn setTitle:@"300" forState:UIControlStateNormal];
        [cell.priceBtn setImage:[UIImage imageNamed:@"qian"] forState:UIControlStateNormal];
        [cell.priceBtn setTitle:@"9元" forState:UIControlStateNormal];
        cell.companyLab.text = @"中国惠普";
    }
    else
    {
        OpenClassModel *model = _openClassList[indexPath.row];
        
        [cell.coverView sd_setImageWithURL:[NSURL URLWithString:model.vimage] placeholderImage:[UIImage imageNamed:@"remen"]];
        cell.nameLab.text = model.video_teacher;
        //        cell.coverView.image = [UIImage imageNamed:@"remen"];
        //        cell.nameLab.text = @"王老师";
        [cell.redXinBtn setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
        [cell.redXinBtn setTitle:@"300" forState:UIControlStateNormal];
        [cell.priceBtn setImage:[UIImage imageNamed:@"qian"] forState:UIControlStateNormal];
        [cell.priceBtn setTitle:@"9元" forState:UIControlStateNormal];
        cell.companyLab.text = @"中国惠普";
    }

    
//    MTSpecialtyListModel *model = self.dataArray[indexPath.rowIndex][indexPath.columnIndex];
//    [item.iconView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:mImageByName(@"placeholder")];
//    item.specialtyName.text = model.name;
    
    
    
    return cell;
    
}
- (int)numberOfRowAtGridView:(MTGridView *)gridView
{
    return self.dataArray.count;
}
- (int)gridView:(MTGridView *)gridView numberOfColumnInRow:(int)row
{
    return [self.dataArray[row] count];
}
- (float)gridView:(MTGridView *)gridView heightOfItemAtIndexPath:(NSIndexPath *)indexPath
{
//    return  (gridView.frame.size.width - 2 * 15 ) / 2;
    return 140;
}
- (float)gridView:(MTGridView *)gridView widthOfItemAtIndexPath:(NSIndexPath *)indexPath
{
    return ((gridView.frame.size.width - 2 * 20 ) - 25) / 2;
}
- (void)gridView:(MTGridView *)gridView didSelectedItemAtIndexPath:(NSIndexPath *)indexPath
{
     OpenClassModel *model = self.dataArray[indexPath.rowIndex][indexPath.columnIndex];
    //    播放视频
    //    NSURL *Url = [NSURL URLWithString:@"00018093b103eb7fe795cf4cebab8871_0"];
    NSURL *Url = [NSURL URLWithString:model.video_id];
    if (!Url) {
        return;
    }
    NSString *str = model.plist;
   NSArray *arr = [str componentsSeparatedByString:@","];

    THCoursePlayVC *moviePlayer =    [[THCoursePlayVC alloc] initNetworkMoviePlayerViewControllerWithURL:Url movieTitle:model.video_name];
    moviePlayer.classId = arr.lastObject;
    //    [self.navigationController presentViewController:moviePlayer animated:YES completion:nil];
    [self.navigationController pushViewController:moviePlayer animated:YES];
}

#pragma mark -- MJRefresh
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        _page = 0;
        THLog(@"下拉刷新");
//        [self.dataArray removeAllObjects];
        [self loadData:refreshView page:_page];
    }
    else{
        self.page++;
        THLog(@"上拉加载更多");
        [self loadData:refreshView page:_page];
        
    }
}

- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    if (index == 0)
    {
        
        _currentIndex = 0;
        
        [self._gridView reloadData];
    }
    else
    {
        _currentIndex = 1;
        //        [self._gridView reloadData];
        

    }
}

#pragma mark -- respondEvent
- (void)qsBtnClick:(UITapGestureRecognizer *)tap
{
    NSURL *Url;
    if (tap.view.tag == 1000)
    {
         Url = [NSURL URLWithString:_teacherArr[tap.view.tag-1000][@"video_id"]];
    }
    else if (tap.view.tag == 1001)
    {
         Url = [NSURL URLWithString:_teacherArr[tap.view.tag-1000][@"video_id"]];
    }
    else if (tap.view.tag == 1002)
    {
         Url = [NSURL URLWithString:_teacherArr[tap.view.tag-1000][@"video_id"]];
    }
    
    //    播放视频
    NSString *str = _teacherArr[tap.view.tag-1000][@"plist"];
    NSArray *arr = [str componentsSeparatedByString:@","];
    
    if (!Url) {
        return;
    }
    
    THCoursePlayVC *moviePlayer =    [[THCoursePlayVC alloc] initNetworkMoviePlayerViewControllerWithURL:Url movieTitle:@"英语完型填空"];
    moviePlayer.classId = arr.lastObject;
    //    [self.navigationController presentViewController:moviePlayer animated:YES completion:nil];
    [self.navigationController pushViewController:moviePlayer animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark -- 一位数组转二维数组
- (NSMutableArray *)getArray:(NSArray *)array length:(int)length
{
    if (array == nil)
    {
        return nil;
    }
    
    int count = (int)[array count];
    NSMutableArray *getArray = [[NSMutableArray alloc]init];
    
    if (length > count)
    {
        [getArray addObject:[array mutableCopy]];
        
        return getArray ;
    }
    
    int tempLenth = count / length * length;
    
    NSArray *tempArray = [array mutableCopy];
    
    NSMutableArray *tempNsArray = [[NSMutableArray alloc]init];
    
    //数组里包含数组就是二位数组
    for (int i = 0; i < tempLenth; i+= length)
    {
        for (int j = i; j < i + length; j++)
        {
            [tempNsArray addObject:[tempArray objectAtIndex:j]];
        }
        
        [getArray addObject:[tempNsArray mutableCopy]];
        [tempNsArray removeAllObjects];
    }
    
    int remainder = count % length;
    
    if (remainder != 0)
    {
        for (int i = tempLenth; i < count; i += remainder)
        {
            for (int j = i; j < i + remainder; j++)
            {
                [tempNsArray addObject:[tempArray objectAtIndex:j]];
            }
            
            [getArray addObject:[tempNsArray mutableCopy]];
            [tempNsArray removeAllObjects];
        }
    }
    return getArray;
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
