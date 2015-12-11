//
//  TH_SwipeFindJobListVC.m
//  EggShell
//
//  Created by 太和 on 15/12/11.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_SwipeFindJobListVC.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "SearchModelShare.h"
/*数据请求**/
#import "AFAppRequest.h"
#import "findJobModel.h"
#import "FindJobcardView.h"
#import "SearchJobVC.h"
#import "TH_JobScreeningVC.h"
#import "UIBarButtonItem+DC.h"
#import "TH_JobDetailVC.h"
#import "findJobCarViewS.h"
#define tabbarHeight 46

@interface TH_SwipeFindJobListVC ()
{
    MBProgressHUD * _mbPro;
}

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic) NSUInteger colorIndex;

//职位数组
@property (nonatomic, strong) NSMutableArray *jobArr;

@property (nonatomic) BOOL loadCardFromXib;

@property (nonatomic, strong) UIBarButtonItem *reloadBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *leftBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *upBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *downBarButtonItem;

@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,assign)int page;

//取消图片
@property (nonatomic, strong) UIImageView *cancelView;
//感兴趣图片
@property (nonatomic, strong) UIImageView *intestingView;
@property (assign) float oldx;

@property (nonatomic, strong) UIButton *searchBtn;
@property(nonatomic,strong)UIImageView * hideView;
//保存uid job_id
@property (nonatomic, copy) NSString *rk_uid;
@property (nonatomic, copy) NSString *rk_job_id;

@end

@implementation TH_SwipeFindJobListVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    UIButton *searchBtn = [[UIButton alloc] init];
    [searchBtn setImage:[UIImage imageNamed:@"sousuo001"] forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    searchBtn.frame = CGRectMake(WIDETH - 10 - 50 - 20 - 10,0, 44, 44);
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:searchBtn];
    _searchBtn = searchBtn;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [_searchBtn removeFromSuperview];
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIImageView * hideView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    hideView.image = [UIImage imageNamed:@"提示层"];
    hideView.userInteractionEnabled = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:hideView];
    UITapGestureRecognizer * taphide =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taphide)];
    self.hideView = hideView;
    [hideView addGestureRecognizer:taphide];
    //隐藏toolbar
    self.navigationController.toolbarHidden = YES;
    self.title = @"找工作";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barBtnItemWithNormalImageName:@"liebiao" hightImageName:nil action:@selector(rightClick) target:self];
    //    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //不感兴趣图片
    self.cancelView = [[UIImageView alloc]init];
    self.cancelView.image = [UIImage imageNamed:@"暂不考虑"];
    self.cancelView.frame = CGRectMake(0, 0, WIDETH - 30, HEIGHT - 66 - 40 - 44);    //收藏图片
    self.intestingView = [[UIImageView alloc]init];
    self.intestingView.image = [UIImage imageNamed:@"感兴趣"];
    self.intestingView.frame = CGRectMake(0, 0, WIDETH - 30,  HEIGHT - 66 - 40 - 44);
    
    //初始化职位数组，查询数据库
    self.jobArr = [[NSMutableArray alloc]init];
    _mbPro = [MBProgressHUD mbHubShowControllerView:self];
    self.page = 1;
    [self loadData:_mbPro page:self.page];
    
    self.colorIndex = 0;
    //    self.colors = @[
    //        @"Turquoise",
    //        @"Green Sea",
    //        @"Emerald",
    //        @"Nephritis",
    //        @"Peter River",
    //        @"Belize Hole",
    //        @"Amethyst",
    //        @"Wisteria",
    //        @"Wet Asphalt",
    //        @"Midnight Blue",
    //        @"Sun Flower",
    //        @"Orange",
    //        @"Carrot",
    //        @"Pumpkin",
    //        @"Alizarin",
    //        @"Pomegranate",
    //        @"Clouds",
    //        @"Silver",
    //        @"Concrete",
    //        @"Asbestos"
    //    ];
    
    //    self.reloadBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload"
    //                                                                style:UIBarButtonItemStylePlain
    //                                                               target:self
    //                                                               action:@selector(handleReload:)];
    //    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"←"
    //                                                              style:UIBarButtonItemStylePlain
    //                                                             target:self
    //                                                             action:@selector(handleLeft:)];
    //    self.upBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"↑"
    //                                                            style:UIBarButtonItemStylePlain
    //                                                           target:self
    //                                                           action:@selector(handleUp:)];
    //    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"→"
    //                                                               style:UIBarButtonItemStylePlain
    //                                                              target:self
    //                                                              action:@selector(handleRight:)];
    //    self.downBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"↓"
    //                                                              style:UIBarButtonItemStylePlain
    //                                                             target:self
    //                                                             action:@selector(handleDown:)];
    
    //    UIBarButtonItem *fixedSpace =
    //        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
    //                                                      target:nil
    //                                                      action:nil];
    //    UIBarButtonItem *flexibleSpace =
    //        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
    //                                                      target:nil
    //                                                      action:nil];
    //    self.toolbarItems = @[
    //        fixedSpace,
    //        _reloadBarButtonItem,
    //        flexibleSpace,
    //        _leftBarButtonItem,
    //        flexibleSpace,
    //        _upBarButtonItem,
    //        flexibleSpace,
    //        _rightBarButtonItem,
    //        flexibleSpace,
    //        _downBarButtonItem,
    //        fixedSpace
    //    ];
    
    //添加卡片视图
    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    self.swipeableView.backgroundColor =[UIColor  whiteColor];
    self.swipeableView.allowedDirection = ZLSwipeableViewDirectionHorizontal;
    [self.view addSubview:self.swipeableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.swipeableView addGestureRecognizer:tap];
    
    //添加数据源代理，事件代理
    self.swipeableView.dataSource = self;
    // Optional Delegate
    self.swipeableView.delegate = self;
    
    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //autolayout自动布局,布局swipeableView
    NSDictionary *metrics = @{};
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"|-15-[swipeableView]-15-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-20-[swipeableView]-66-|"
                               options:0
                               metrics:metrics
                               views:NSDictionaryOfVariableBindings(
                                                                    swipeableView)]];
    
    
    
}
-(void)taphide
{
    self.hideView.hidden = YES;
}
- (void)rightClick
{
    THLog(@"条件选择按钮被点击");
    
    TH_JobScreeningVC * job = [[TH_JobScreeningVC alloc] init];
    job.title = @"职位搜索";
    [self.navigationController pushViewController:job animated:YES];
}


- (void)searchBtnClick
{
    THLog(@"搜索被点击");
    SearchJobVC * search = [[SearchJobVC alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    
}

-(void)loadData:(id)notify page:(int)num
{
    [SearchModelShare sharedInstance].type = @"55";
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    
    self.state = [[TH_AFRequestState searchJobWithSucc:^(NSArray *DataArr) {
        
        if (DataArr.count > 0)
        {
            NSLog(@"DataArr:%@",DataArr);
            [self.jobArr removeAllObjects];
            [self.jobArr addObjectsFromArray:DataArr];
            if (self.page == 1)
            {
                
            }
            else
            {
                
                
                //清除卡片，用新数据刷新卡片
                [self.swipeableView discardAllViews];
                [self.swipeableView loadViewsIfNeeded];
            }
            
            
        }
        else
        {
            //            [MBProgressHUD creatembHub:@"暂无数据"];
        }
        
    } withfail:^(int errCode, NSError *err) {
        
    } withlongitude:[SearchModelShare sharedInstance].longitude dimensionality:[SearchModelShare sharedInstance].dimensionality keyword:[SearchModelShare sharedInstance].keyword page:numStr hy:[SearchModelShare sharedInstance].hy job_post:[SearchModelShare sharedInstance].job_post salary:[SearchModelShare sharedInstance].salary edu:[SearchModelShare sharedInstance].edu exp:[SearchModelShare sharedInstance].exp type:[SearchModelShare sharedInstance].type sdate:[SearchModelShare sharedInstance].sdate job1:[SearchModelShare sharedInstance].job1 cityid:[SearchModelShare sharedInstance].cityid provinceid:[SearchModelShare sharedInstance].provinceid job1_post:[SearchModelShare sharedInstance].job1_son resp:[findJobModel class]] addNotifaction:notify];
    
    
}

- (void)viewDidLayoutSubviews
{
    [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - Action
//
//- (void)handleLeft:(UIBarButtonItem *)sender {
//    [self.swipeableView swipeTopViewToLeft];
//}
//
//- (void)handleRight:(UIBarButtonItem *)sender {
//    [self.swipeableView swipeTopViewToRight];
//}
//
//- (void)handleUp:(UIBarButtonItem *)sender {
//    [self.swipeableView swipeTopViewToUp];
//}
//
//- (void)handleDown:(UIBarButtonItem *)sender {
//    [self.swipeableView swipeTopViewToDown];
//}
//
//- (void)handleReload:(UIBarButtonItem *)sender {
//    UIActionSheet *actionSheet =
//        [[UIActionSheet alloc] initWithTitle:@"Load Cards"
//                                    delegate:self
//                           cancelButtonTitle:@"Cancel"
//                      destructiveButtonTitle:nil
//                           otherButtonTitles:@"Programmatically", @"From Xib", nil];
//    [actionSheet showInView:self.view];
//}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    self.loadCardFromXib = buttonIndex == 1;
    self.colorIndex = 0;
    [self.swipeableView discardAllViews];
    [self.swipeableView loadViewsIfNeeded];
}

#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
    if (direction == 2)
    {
        THLog(@"收藏");
        [self.rk_uid intValue];
        [self.rk_job_id intValue];
        
        
        
    }
    else
    {
        THLog(@"取消");
    }
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    
    
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
    //开始，记录初始x,是oldx不为空
    self.oldx = location.x;
    [view addSubview:self.cancelView];
    self.cancelView.hidden = YES;
    [view addSubview:self.intestingView];
    self.intestingView.hidden = YES;
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
          translation.x, translation.y);
    
    if (self.oldx > location.x)
    {
        NSLog(@"左滑动");
        self.intestingView.hidden = YES;
        self.cancelView.hidden = NO;
        self.oldx = location.x;
    }
    else if(self.oldx < location.x)
    {
        NSLog(@"右滑动");
        self.cancelView.hidden = YES;
        self.intestingView.hidden = NO;
        self.oldx = location.x;
    }
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
    [self.cancelView removeFromSuperview];
    [self.intestingView removeFromSuperview];
    //    self.cancelView.hidden = YES;
    //    self.intestingView.hidden = YES;
    //    NSLog(@"didEndSwipingView %ld",self.colorIndex);
    //    self.oldx = 0;
    
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    //    NSLog(@"colorIndex%ld",self.colorIndex);
    //    NSLog(@"jobArr.count%ld",self.jobArr.count);
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    
    //取出jobArr对应模型，对子控件进行赋值操作
    if (self.jobArr.count > 0 && self.colorIndex <= self.jobArr.count)
    {
        findJobModel * model = self.jobArr[self.colorIndex - 1];
        //添加一个标签试试
        findJobCarViewS *fjcV = [[findJobCarViewS alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width,  view.frame.size.height)];
        fjcV.backgroundColor = [UIColor whiteColor];
        [fjcV setValueCar:model];
        
        //保存uid job_id
        self.rk_uid = [NSString stringWithFormat:@"%@",model.uid];
        self.rk_job_id = [NSString stringWithFormat:@"%@",model.job_id];
        
        fjcV.frame = CGRectMake(0,0,view.frame.size.width,  view.frame.size.height);
        [view addSubview:fjcV];
        
    }
    
    //当colorIndex = 9时，走这个方法。大于8，每页的条数
    if (self.colorIndex > self.jobArr.count )
    {
        self.colorIndex = 0;
        [self.jobArr removeAllObjects];
        
        self.colorIndex = 0;
        self.page ++;
        [self loadData:_mbPro page:self.page];
    }
    else
    {
        
    }
    
    //    view.backgroundColor = [self colorForName:self.colors[self.colorIndex]];
    //    view.backgroundColor = [UIColor grayColor];
    self.colorIndex++;
    
    //    if (self.loadCardFromXib) {
    //        UIView *contentView =
    //            [[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil][0];
    //        contentView.translatesAutoresizingMaskIntoConstraints = NO;
    ////        [view addSubview:contentView];
    //
    //        // This is important:
    //        // https://github.com/zhxnlai/ZLSwipeableView/issues/9
    //        NSDictionary *metrics =
    //            @{ @"height" : @(view.bounds.size.height),
    //               @"width" : @(view.bounds.size.width) };
    //        NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
    //        [view addConstraints:[NSLayoutConstraint
    //                                 constraintsWithVisualFormat:@"H:|[contentView(width)]"
    //                                                     options:0
    //                                                     metrics:metrics
    //                                                       views:views]];
    //        [view addConstraints:[NSLayoutConstraint
    //                                 constraintsWithVisualFormat:@"V:|[contentView(height)]"
    //                                                     options:0
    //                                                     metrics:metrics
    //                                                       views:views]];
    //    }
    //
    if (self.jobArr.count > 0)
    {
        return view;
    }
    else
    {
        return nil;
    }
    
}

- (void)tapClick
{
    NSLog(@"职位详情");
    TH_JobDetailVC * detail = [[TH_JobDetailVC alloc] init];
    detail.uid = [self.rk_uid intValue];
    detail.pid = [self.rk_job_id intValue];
    //    detail.saveBOOL = 1;
    [self.navigationController pushViewController:detail animated:YES];
    
}



#pragma mark - ()
- (UIColor *)colorForName:(NSString *)name {
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
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
