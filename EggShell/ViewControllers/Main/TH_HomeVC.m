//
//  TH_HomeVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_HomeVC.h"

#import "TH_FindJobVC.h"

#import "SearchView.h"
#import "AppDelegate.h"

#import "TH_FindPartTimeVC.h"
#import "TH_FindPracticeVC.h"

#import "TH_ClassVC.h"

#import "SearchJobVC.h"
#import "DataBase.h"
#import "CompanyDetailVC.h"

#import "WriteResumeViewController.h"

#import "TH_PlayFanVC.h"
#import "TH_InformationDeskVC.h"
#import "FindjobView.h"
#import "HomeView.h"
#import "VersionUpdateView.h"
#import "ManagerResumeVC.h"
#import "TH_LoginVC.h"
#import "TH_SwipeFindJobListVC.h"

/*数据请求**/
#import "AFAppRequest.h"
#import "SearchModelShare.h"
#import "homedel.h"
/*企业**/
#import "EnterpriseDetailVC.h"
/*V达人**/
#import "TH_VtalentVC.h"
#import "AllowedDirectionDemoViewController.h"
//#import "RKSwipeViewController.h"

#import "ZLSwipeableViewController.h"


#import "HotJobView.h"
#import "FamousRecommendedView.h"
//#import "ThFindJobVC.h"

@interface TH_HomeVC ()<UIScrollViewDelegate,SGFocusImageFrameDelegate,THHomeVieWDelegate,THFaousVieWDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate,HotJobViewDelegate,FamousRecommendedViewDelegate>

{
    UIView * _navBackView;
    SearchView * _searchView;
    
}

@property (nonatomic, strong)SGFocusImageFrame *bannerView;
@property (nonatomic, strong) NSMutableArray *arr;
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UIView * searChBgView;
@property(nonatomic,strong)FindjobView * findView;
@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,strong)NSDictionary * dataDic;
@property(nonatomic,strong)NSArray *imageArr;
@property(nonatomic,copy)NSString * str1;
@property(nonatomic,copy)NSString * str2;
@property(nonatomic,copy)NSString * str3;
@property(nonatomic,strong)AFRequestState * enterState;
@property(nonatomic,strong)NSArray * enterArray;
@property(nonatomic,strong)HomeView * homeView;
@property(nonatomic,strong)FamousRecommendedView * Famous;
@end
@implementation TH_HomeVC

- (NSMutableArray *)arr
{
    if (_arr == nil)
    {
        self.arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:@"jgPush" object:nil];
    
    //网络判断
    if ([MMNetWorkType getNetWorkType] ==BadNetWorkLink)
    {
        [MBProgressHUD creatembHub:@"当前处于无网络"];
        
    }
    else if([MMNetWorkType getNetWorkType] ==WWAN)
    {
        [MBProgressHUD creatembHub:@"您当前处于非wifi网络"];
    }
    else
    {
        [MBProgressHUD creatembHub:@"您当前处于wifi网络"];
    }
    //状态栏
    //    [self setStatus];
    //ScroView
    [self createScro];
    //初始化轮播图
    [self configBannerView];
    [self quereData];
    //注册XIB
    [self createHomeView];
    //名企推荐
    [self loadData];
    
    self.navigationController.delegate = self;
    
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)test:(NSNotification*)notification
{
    
    NSDictionary * dic = notification.userInfo;
    
    
    self.navigationController.navigationBarHidden = NO;
    EnterpriseDetailVC * enter = [[EnterpriseDetailVC alloc] init];
    [self.navigationController pushViewController:enter animated:YES];
    
}

-(void)loadData
{
    self.enterArray =[NSArray array];
    [TH_AFRequestState PrivateRecommendationWithSucc:^(NSDictionary *arr) {
        
        self.enterArray  = arr[@"data"];
        [self.Famous configValue:self.enterArray];
        
    } ];
    
}
-(void)versionNew
{
    VersionUpdateView * view =[[[NSBundle mainBundle] loadNibNamed:@"VersionUpdate" owner:self options:nil] lastObject];
    
    view.frame = CGRectMake(0, 0, 250, 151);
    //    [UIView animateWithDuration:0.5 animations:^{
    //        view.center = self.view.center;
    //    }];
    
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    [view showVersonView];
    
}
#pragma mark - - 搜素
-(void)createSearch
{
    
    _searchView = [[[NSBundle mainBundle] loadNibNamed:@"SearchView" owner:self options:nil] firstObject];
    _searchView.frame = CGRectMake(0, 0, WIDETH, 64);
    [self.tabBarController.view addSubview:_searchView];
    
    //企业端按钮
    //    _searchView.rightView.hidden = YES;
    //    [_searchView.goEnterFaceBtn addTarget:self action:@selector(gointerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _searchView.searchTextField.enabled = NO;
    [_searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    
    __weak typeof(self) weakSelf = self;
    _searchView.searchClick = ^
    {
        weakSelf.navigationController.navigationBarHidden = NO;
        [weakSelf.navigationController pushViewController:[[SearchJobVC alloc] init] animated:YES];
    };
    _searChBgView = [[UIView alloc] initWithFrame:_searchView.bounds];
    _searChBgView.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:42 / 255.0 blue:48 / 255.0 alpha:1];
    _searChBgView.alpha = 0;
    
    [self.navigationController.view addSubview:_searChBgView];
    //在navigation页面创建点击手势
    //    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    //    [self.tabBarController.view addGestureRecognizer:tap];
    
}
-(void)gointerBtnClick
{
    self.navigationController.navigationBarHidden = NO;
    EnterpriseDetailVC * enter = [[EnterpriseDetailVC alloc] init];
    [self.navigationController pushViewController:enter animated:YES];
    
}
//取消textField编辑状态，收回键盘
-(void)tap
{
    self.navigationController.navigationBarHidden = NO;
    SearchJobVC *vc = [[SearchJobVC alloc]init];
    vc.pushType = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - - scorView
-(void)createScro
{
    UIScrollView * scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT -49)];
    self.scro           = scro;
    self.scro.showsVerticalScrollIndicator  = NO;
    self.scro.delegate  = self;
    self.scro.backgroundColor = color(243, 243, 241);
    [self.view addSubview:scro];
    
    //创建上下拉刷新
    _header = [MJRefreshHeaderView header];
    _header.delegate = self;
    _header.scrollView = self.scro;
    _header.frame = CGRectMake(0, -84, WIDETH, 64);
    
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = self.scro;
    _footer.frame = CGRectMake(0, MyWideth * 300+400+26, WIDETH, 64);
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}

#pragma mark - - 创建HomeView
-(void)createHomeView
{
    NSLog(@"%f",MyHeight*160);
    
    self.findView = [[FindjobView alloc] initWithFrame:CGRectMake(0, 160*MyWideth, WIDETH,140*MyWideth+26)];
    self.findView.frame = CGRectMake(0, 160*MyWideth, WIDETH, MyWideth * 140+26);
    self.findView.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f",self.findView.frame.size.height);
    
    self.findView.homeViewDelegate = self;
    [self.scro addSubview:self.findView];
    //    //注册HomeViews
    //    HomeView * homeView   = [HomeView homeViewFinJob];
    //    homeView.frame  = CGRectMake(0*WIDETH, MyHeight * 326, WIDETH, 436);
    //
    //    homeView.famousDelegate = self;
    //    [homeView setHomeViewAdBtn];
    //    [homeView setHomeViewFcBtn];
    //    [homeView setHomeViewItBtn];
    //    self.homeView = homeView;
    //
    //    [self.scro addSubview:homeView];
    
    HotJobView * hotView = [[HotJobView alloc] initWithFrame:CGRectMake(0, MyWideth * 300+26, WIDETH, 205)];
    hotView.HotJobViewDelegate = self;
    [hotView setBtnTag];
    hotView.backgroundColor = [UIColor whiteColor];
    [self.scro addSubview:hotView];
    
    FamousRecommendedView * Famous = [[FamousRecommendedView alloc] initWithFrame:CGRectMake(0, MyWideth * 300+205+26, WIDETH, 235)];
    Famous.famousRecommendedViewDelegate = self;
    self.Famous = Famous;
    Famous.backgroundColor = [UIColor whiteColor];
    [self.scro addSubview:Famous];
    
    //    self.scro.contentSize = CGSizeMake(WIDETH, MyHeight * 326+416+25);
    self.scro.contentSize = CGSizeMake(WIDETH, MyWideth * 300+205+215+25+26);
}
#pragma mark -- 名企推荐
-(void)FamousRecommendedViewJob:(FamousRecommendedView*)HotJobView DidClickButton:(int)tag
{
    
    self.navigationController.navigationBarHidden = NO;
    CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
    if (!self.enterArray.count>0) {
        [self.navigationController pushViewController:detail animated:YES];
        return;
    }
    homedel * data =(homedel *)[ Gson fromObj:self.enterArray[tag] Cls:[homedel class]];
    detail.businessUid = data.uid;
    detail.businessMid = data.mid;
    [self.navigationController pushViewController:detail animated:YES];
    
}
#pragma mark --- 热门职位
-(void)HotJobViewJob:(HotJobView*)HotJobView DidClickButton:(HotJobViewButtonType)button
{
    
    self.navigationController.navigationBarHidden = NO;
    switch (button) {
        case HotJobViewButtonTypeeducationTrainBtn:
        {
            //            NSLog(@"1..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教育培训";
            //            [SearchModelShare sharedInstance].hy = @"842";
            home.hy = @"842";
            //            home.rk_pushType = homePushType;
            //            home.jobId  = [NSString stringWithFormat:@"%d",35];
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
            
        case HotJobViewButtonTypemarketingSpecialistBtn:
        {
            //            NSLog(@"1..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"市场专员";
            //            [SearchModelShare sharedInstance].job1_son = @"962";
            home.job1_son = @"962";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypeonsultingSaleBtn:
        {
            //            NSLog(@"1..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"咨询销售";
            //            [SearchModelShare sharedInstance].job1_son = @"994";
            home.job1_son = @"994";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypetrainTeacherBtn:
        {
            //            NSLog(@"1..4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"培训讲师";
            //            [SearchModelShare sharedInstance].job1_son = @"1050";
            home.job1_son = @"1050";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypeteachManagerBtn:
        {
            //            NSLog(@"1..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教学管理";
            //            [SearchModelShare sharedInstance].job1_son = @"1029";
            home.job1_son = @"1029";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypeteachqualitBtn:
        {
            //            NSLog(@"1..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教质管理";
            //            [SearchModelShare sharedInstance].job1_son = @"1032";
            home.job1_son = @"1032";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypeemploymentCommissionerBtn:
        {
            //            NSLog(@"1..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"就业专员";
            //            [SearchModelShare sharedInstance].job1_son = @"1027";
            home.job1_son = @"1027";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypeComplexBtn:
        {
            //            NSLog(@"2..8");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"综合类";
            //            [SearchModelShare sharedInstance].job1 = @"1048";
            home.job1 = @"1048";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case HotJobViewButtonTypesitePlanBtn:
        {
            //            NSLog(@"2..9");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"互联网";
            //            [SearchModelShare sharedInstance].job1_son = @"48";
            home.job1_son = @"48";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case HotJobViewButtonTypewebsiteEditorBtn:
        {
            //            NSLog(@"2..10");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"金融证券";
            //            [SearchModelShare sharedInstance].job1_son = @"58";
            home.job1_son = @"58";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case HotJobViewButtonTypeoperationsCommissionerBtn:
        {
            //            NSLog(@"2..11");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"公关媒介";
            //            [SearchModelShare sharedInstance].job1_son = @"74";
            home.job1_son = @"74";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case HotJobViewButtonTypebankTellerBtn:
        {
            //            NSLog(@"2..12");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"市场营销";
            //            [SearchModelShare sharedInstance].job1_son = @"75";
            home.job1_son = @"75";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case HotJobViewButtonTypeaccountingBtn:
        {
            //            NSLog(@"2..13");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"销售管理";
            //            [SearchModelShare sharedInstance].job1_son = @"53";
            //            home.rk_pushType = homePushType;
            home.job1_son = @"75";
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case HotJobViewButtonTypetellerBtn:
        {
            //            NSLog(@"2..14");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"人事管理";
            //            [SearchModelShare sharedInstance].job1_son = @"634";
            home.job1_son = @"634";
            //            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        default:
            break;
    }
    //    NSLog(@"111");
    
}
#pragma mark -- 名企推荐
-(void)homeViewFindJob:(HomeView *)homeView withTag:(NSInteger)setTag
{
    self.navigationController.navigationBarHidden = NO;
    CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
    if (!self.enterArray.count>0) {
        [self.navigationController pushViewController:detail animated:YES];
        return;
    }
    self.navigationController.navigationBarHidden = NO;
    if (setTag ==100) {
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[0] Cls:[homedel class]];
        detail.businessUid = data.uid;
        detail.businessMid = data.mid;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (setTag == 101)
    {
        CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[1] Cls:[homedel class]];
        detail.businessUid = data.uid;
        detail.businessMid = data.mid;
        [self.navigationController pushViewController:detail animated:YES];
        
    }else if (setTag == 102)
    {
        
        CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[2] Cls:[homedel class]];
        detail.businessUid = data.uid;
        detail.businessMid = data.mid;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if (setTag == 103)
    {
        
        CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[3] Cls:[homedel class]];
        detail.businessUid =data.uid;
        detail.businessMid = data.mid;
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    else if (setTag == 104)
    {
        
        CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[4] Cls:[homedel class]];
        detail.businessUid = data.uid;
        detail.businessMid = data.mid;
        [self.navigationController pushViewController:detail animated:YES];
        
    }
    else if (setTag == 105)
    {
        
        CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
        homedel * data =(homedel *)[ Gson fromObj:self.enterArray[5] Cls:[homedel class]];
        detail.businessUid =data.uid;
        detail.businessMid =data.mid;
        
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

#pragma mark --
-(void)myselfView:(HomeView*)selfView didClickInterneButton:(THHomeViewButtonItType)buttonType
{self.navigationController.navigationBarHidden = NO;
    switch (buttonType) {
        case THHomeViewButtonTypeInternet:
        {
            NSLog(@"1..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教育培训";
            //            [SearchModelShare sharedInstance].job1 = @"960";
            home.job1 = @"960";
            home.rk_pushType = homePushType;
            //            home.jobId  = [NSString stringWithFormat:@"%d",35];
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
            
        case THHomeViewButtonTypeSitePlanning:
        {
            NSLog(@"1..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"市场专员";
            //            [SearchModelShare sharedInstance].job_post = @"962";
            home.job_post = @"962";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeWebsiteEditor:
        {NSLog(@"1..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"咨询销售";
            //            [SearchModelShare sharedInstance].job_post = @"994";
            home.job_post = @"994";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeOperationsCommissioner:
        {NSLog(@"1..4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"培训讲师";
            //            [SearchModelShare sharedInstance].job_post = @"988";
            home.job_post = @"988";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeSEO:
        {NSLog(@"1..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教学管理";
            //            [SearchModelShare sharedInstance].job_post = @"986";
            home.job_post = @"986";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeUIDesigner:
        {NSLog(@"1..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"教质管理";
            //            [SearchModelShare sharedInstance].job_post = @"995";
            home.job_post = @"995";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypenice:
        {NSLog(@"1..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"就业专员";
            //            [SearchModelShare sharedInstance].job_post = @"996";
            home.job_post = @"996";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
            
            
        default:
            break;
    }
    NSLog(@"111");
}
-(void)myselfView:(HomeView*)selfView didClickFinancialButton:(THHomeViewButtonFcType)buttonType
{self.navigationController.navigationBarHidden = NO;
    switch (buttonType) {
        case THHomeViewButtonTypeFinancial:
        {NSLog(@"2..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"互联网";
            //            [SearchModelShare sharedInstance].job1 = @"35";
            home.job1 = @"35";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case THHomeViewButtonTypeBank:
        {NSLog(@"2..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"网站策划";
            //            [SearchModelShare sharedInstance].job_post = @"131";
            home.job_post = @"131";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeObligation:
        {NSLog(@"2..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"网站编辑";
            //            [SearchModelShare sharedInstance].job_post = @"132";
            home.job_post = @"132";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeClear:
        {NSLog(@"2..4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"运营专员";
            //            [SearchModelShare sharedInstance].job_post = @"125";
            home.job_post = @"125";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeTrader:
        {NSLog(@"2..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"SEM专员";
            //            [SearchModelShare sharedInstance].job_post = @"141";
            home.job_post = @"141";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeAccounting:
        {NSLog(@"2..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"UI设计师";
            //            [SearchModelShare sharedInstance].job_post =  @"127";
            home.job_post = @"127";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTyCashier:
        {NSLog(@"2..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"美工";
            //            [SearchModelShare sharedInstance].job_post = @"133";
            home.job_post = @"133";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        default:
            break;
    }
    
    //    NSLog(@"222");
}

-(void)myselfView:(HomeView*)selfView didClickAdvertisinButton:(THHomeViewButtonAdType)buttonType
{self.navigationController.navigationBarHidden = NO;
    switch (buttonType) {
        case THHomeViewButtonTypeAdvertising:
        {NSLog(@"3..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"金融银行";
            [SearchModelShare sharedInstance].job1 = @"37";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
        case THHomeViewButtonTypeClient:
        {NSLog(@"3..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"银行柜员";
            [SearchModelShare sharedInstance].job_post = @"296";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeCreative:
        {NSLog(@"3..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"业务专员";
            [SearchModelShare sharedInstance].job_post = @"285";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeBusiness:
        {NSLog(@"3..\4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title =  @"清算员";
            [SearchModelShare sharedInstance].job_post = @"292";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypePlan:
        {NSLog(@"3..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"资金专员";
            [SearchModelShare sharedInstance].job_post =  @"261";
            
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTypeEstate:
        {NSLog(@"3..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"会计";
            [SearchModelShare sharedInstance].job_post = @"251";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            
            break;
        }
            
        case THHomeViewButtonTyMap:
        {NSLog(@"3..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"出纳员";
            [SearchModelShare sharedInstance].job_post = @"252";
            home.rk_pushType = homePushType;
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
            
        default:
            break;
    }
    
    NSLog(@"3333");
}


#pragma mark -- 社交圈、玩出范、v达人、去学习、找工作、找兼职、找实习、写简历
-(void)findViewFindJob:(FindjobView *)homeView DidClickButton:(THHomeViewButtonType)button
{
    self.navigationController.navigationBarHidden = NO;
    switch (button) {
        case THHomeViewButtonTypeFindJob:
        {
            NSLog(@"社交圈");
            TH_InformationDeskVC * information = [[TH_InformationDeskVC alloc] init];
            information.title = @"社交圈";
            [self.navigationController pushViewController:information animated:YES];
            break;
        }
        case THHomeViewButtonTypeFindPartTime:
        {
            NSLog(@"玩出范");
            TH_PlayFanVC * play =[[ TH_PlayFanVC alloc] init];
            play.title = @"玩出范";
            [self.navigationController pushViewController:play animated:YES];
            
            break;
        }
        case THHomeViewButtonTypeInternshipSearch:
        {
//            NSLog(@"V达人");
            
            TH_VtalentVC * talent = [[TH_VtalentVC alloc] init];
            [self.navigationController pushViewController:talent animated:YES];
            
            break;
        }
        case THHomeViewButtonTypeInformationDesk:
        {
            NSLog(@"去学习");
            TH_ClassVC * class =  [[TH_ClassVC alloc] init];
            class.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:class animated:YES];
            break;
        }
        case THHomeViewButtonTypeResumeWriting:
        {
            TH_SwipeFindJobListVC *vc = [[TH_SwipeFindJobListVC alloc]init];
            vc.title = @"找工作";
            vc.type = @"55";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case THHomeViewButtonTypePlayFan:
        {
            TH_SwipeFindJobListVC *vc = [[TH_SwipeFindJobListVC alloc]init];
            vc.title = @"找兼职";
            vc.type = @"56";
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
            
        }
        case THHomeViewButtonTypeMicroSocial:
        {
            
            NSLog(@"找实习");
            TH_SwipeFindJobListVC *vc = [[TH_SwipeFindJobListVC alloc]init];
            vc.title = @"找实习";
            vc.type = @"129";
            [self.navigationController pushViewController:vc animated:YES];
            
            break;
        }
        case THHomeViewButtonTypeOpenClass:
        {
            
            NSLog(@"写简历");
            [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
            if([AppDelegate instance].userId)
            {
                ManagerResumeVC * manaVC = [[ManagerResumeVC alloc] init];
                [self.navigationController pushViewController:manaVC animated:YES];
            }else
            {
                self.navigationController.navigationBarHidden = YES;
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                [alertView show];
            }
            
            break;
        }
        default:
            break;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        self.navigationController.navigationBarHidden = NO;
        TH_LoginVC * lvc = [[TH_LoginVC alloc] init];
        [self.navigationController pushViewController:lvc animated:YES];
        
    }
}

#pragma mark - - 轮播图
- (void)configBannerView
{
    //建立banner图
    _bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0*MyWideth, -20, WIDETH, 182*MyWideth)];
    _bannerView.isAutoPlay = YES;
    _bannerView.delegate = self;
    _bannerView.changeFocusImageInterval = 2;
    [self.scro addSubview:_bannerView];
}
#pragma mark -- banner数据请求
- (void)quereData
{
    NSArray * imsgeArray = @[@"lunbo21",@"lunbo31",@"lunbo11"];
    
    NSArray *imageArr = [NSArray arrayWithObjects:@{@"photo":imsgeArray[0]},@{@"photo":imsgeArray[1]},@{@"photo":imsgeArray[2]}, nil];
    
    //加载数据
    [_bannerView setImageURLs:imageArr];
    //    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0 ];
    //
    //    [TH_AFRequestState CarouselFigureRequestWithSucc:^(NSDictionary * arr) {
    //
    //        self.dataDic = arr[@"data"];
    //        if (is3_5Inch||is4Inch) {
    //            self.str1 = self.dataDic[@"lunbo1.2"];
    //            self.str2 =self.dataDic[@"lunbo1.3"];
    //            self.str3 = self.dataDic[@"lunbo1"];
    //        }else if (is4_7Inch)
    //        {
    //            self.str1 = self.dataDic[@"lunbo2.2"];
    //            self.str2 =self.dataDic[@"lunbo2.3"];
    //            self.str3 = self.dataDic[@"lunbo2"];
    //        }else if (is5_5Inch)
    //        {
    //            self.str1 = self.dataDic[@"lunbo3.2"];
    //            self.str2 =self.dataDic[@"lunbo3.3"];
    //            self.str3 = self.dataDic[@"lunbo3"];
    //        }
    //
    //        self.imageArr = [NSArray arrayWithObjects:@{@"photo":self.str1},@{@"photo":self.str2},@{@"photo":self.str3}, nil];
    //
    //        [_bannerView setImageURLs:self.imageArr];
    //    } withfail:^(int errCode, NSError *err) {
    //
    //    }];
}

/*
 bannerView item 点击方法
 */
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(HomePageModel *)item
{
    NSLog(@"在此处进行跳转%@",item.extend);
}

//#pragma mark - - 状态栏
//-(void)setStatus
//{
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _searChBgView.alpha = scrollView.contentOffset.y / 250;
}

-(void)getBackView:(UIView *)superView
{
    if([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
    {
        _navBackView = superView;
        //设置背景色
        _navBackView.backgroundColor = [UIColor redColor];
        _navBackView.alpha = 0.0;
        ;
        
    }else if([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")])
    {
        superView.hidden = YES;
    }
    
    for(UIView * view in superView.subviews)
    {
        [self getBackView:view];
    }
}



#pragma mark -- lifecircle
//隐藏导航栏,创建搜索视图
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    //搜索
    [self createSearch];
    
    [MobClick beginLogPageView:@"homevc"];
    
}

//删除搜索视图
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"_searChBgView%p",_searChBgView);
    [_searChBgView removeFromSuperview];
    [_searchView removeFromSuperview];
    
    _searchView = nil;
    _searChBgView = nil;
    [MobClick endLogPageView:@"homevc"];
}

-(void)dealloc
{
    [_header free];
    [_footer free];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
