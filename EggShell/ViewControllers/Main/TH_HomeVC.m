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

@interface TH_HomeVC ()<UIScrollViewDelegate,SGFocusImageFrameDelegate,THHomeVieWDelegate,THFaousVieWDelegate,MJRefreshBaseViewDelegate,UIAlertViewDelegate>
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
@property(nonatomic,assign)NSString * str1;
@property(nonatomic,assign)NSString * str2;
@property(nonatomic,assign)NSString * str3;
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
    
    //网络判断
    if ([MMNetWorkType getNetWorkType] ==BadNetWorkLink) {
        [MBProgressHUD creatembHub:@"当前处于无网络"];
        
        
    }else if([MMNetWorkType getNetWorkType] ==WWAN)
    {
     [MBProgressHUD creatembHub:@"您当前处于3G状态"];
    }
    {
        NSLog(@"当前是wifi状态");
         [MBProgressHUD creatembHub:@"您当前处于wifi状态"];
        
    }
    //状态栏
    [self setStatus];
    //ScroView
    [self createScro];
    //初始化轮播图
    [self configBannerView];
    [self quereData];
    //注册XIB
    [self createHomeView];
    
//    NSUserDefaults * versionId = [NSUserDefaults standardUserDefaults];
//    NSString * str = [versionId objectForKey:@"ver"];
//    if ([str isEqualToString:@""]) {
//        [self versionNew];
//        [versionId setObject:@"dd" forKey:@"ver"];
//        
//        
//        [versionId synchronize];
//    }

     
}
-(void)versionNew
{
    VersionUpdateView * view =[[[NSBundle mainBundle] loadNibNamed:@"VersionUpdate" owner:self options:nil] lastObject];
    ;
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
    _searchView.searchTextField.enabled = NO;
    [_searchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    _searchView.searchClick = ^
    {
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:[[SearchJobVC alloc] init] animated:YES];
    };
    _searChBgView = [[UIView alloc] initWithFrame:_searchView.bounds];
    _searChBgView.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:42 / 255.0 blue:48 / 255.0 alpha:1];
    _searChBgView.alpha = 0;
    
    [self.navigationController.view addSubview:_searChBgView];
    //在navigation页面创建点击手势
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
//    [self.tabBarController.view addGestureRecognizer:tap];
    
}
//取消textField编辑状态，收回键盘
-(void)tap
{
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:[[SearchJobVC alloc] init] animated:YES];
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
    _footer.frame = CGRectMake(0, MyHeight * 326+400, WIDETH, 64);
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [refreshView endRefreshing];
}
#pragma mark - - 创建HomeView
-(void)createHomeView
{
    NSLog(@"%f",MyHeight*160);
    
    self.findView = [[FindjobView alloc] initWithFrame:CGRectMake(0, 160*MyHeight, WIDETH,166*MyHeight)];
    self.findView.frame = CGRectMake(0, 160*MyHeight, WIDETH, MyHeight * 166);
    self.findView.backgroundColor = [UIColor whiteColor];
    NSLog(@"%f",self.findView.frame.size.height);
    
    self.findView.homeViewDelegate = self;
    [self.scro addSubview:self.findView];
    //注册HomeViews
    HomeView * homeView   = [HomeView homeViewFinJob] ;
    homeView.frame  = CGRectMake(0*WIDETH, MyHeight * 326, WIDETH, 436);
    homeView.famousDelegate = self;
    [homeView setHomeViewAdBtn];
    [homeView setHomeViewFcBtn];
    [homeView setHomeViewItBtn];
    [self.scro addSubview:homeView];
    
    self.scro.contentSize = CGSizeMake(WIDETH, MyHeight * 326+416+25);
}

-(void)homeViewFindJob:(HomeView *)homeView
{
    self.navigationController.navigationBarHidden = NO;
    CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)myselfView:(HomeView*)selfView didClickInterneButton:(THHomeViewButtonItType)buttonType
{self.navigationController.navigationBarHidden = NO;
    switch (buttonType) {
        case THHomeViewButtonTypeInternet:
        {
            NSLog(@"1..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
        case THHomeViewButtonTypeSitePlanning:
        {
            NSLog(@"1..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }

        case THHomeViewButtonTypeWebsiteEditor:
        {NSLog(@"1..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeOperationsCommissioner:
        {NSLog(@"1..4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }

        case THHomeViewButtonTypeSEO:
        {NSLog(@"1..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }

        case THHomeViewButtonTypeUIDesigner:
        {NSLog(@"1..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }

        case THHomeViewButtonTypenice:
        {NSLog(@"1..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
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
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
        case THHomeViewButtonTypeBank:
        {NSLog(@"2..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeObligation:
        {NSLog(@"2..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeClear:
        {NSLog(@"2..4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeTrader:
        {NSLog(@"2..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeAccounting:
        {NSLog(@"2..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTyCashier:
        {NSLog(@"2..7");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
       
            
        default:
            break;
    }

    NSLog(@"222");
}
-(void)myselfView:(HomeView*)selfView didClickAdvertisinButton:(THHomeViewButtonAdType)buttonType
{self.navigationController.navigationBarHidden = NO;
    switch (buttonType) {
        case THHomeViewButtonTypeAdvertising:
        {NSLog(@"3..1");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
        case THHomeViewButtonTypeClient:
        {NSLog(@"3..2");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeCreative:
        {NSLog(@"3..3");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            //    THHomeViewButtonTypeAdvertising,
            //    THHomeViewButtonTypeClient,
            //    THHomeViewButtonTypeCreative,
            //    THHomeViewButtonTypeBusiness,
            //    THHomeViewButtonTypePlan,
            //    THHomeViewButtonTypeEstate,
            //    THHomeViewButtonTyMap,

        case THHomeViewButtonTypeBusiness:
        {NSLog(@"3..\4");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypePlan:
        {NSLog(@"3..5");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTypeEstate:
        {NSLog(@"3..6");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];

            break;
        }
            
        case THHomeViewButtonTyMap:
        {NSLog(@"3..7");
                    TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
            
                   
        default:
            break;
    }

    NSLog(@"3333");
}

-(void)findViewFindJob:(FindjobView *)homeView DidClickButton:(THHomeViewButtonType)button
{
    self.navigationController.navigationBarHidden = NO;
    TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
    switch (button) {
        case THHomeViewButtonTypeFindJob:
        {
            NSLog(@"找工作");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找全职";
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
        case THHomeViewButtonTypeFindPartTime:
        {
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找兼职";
            NSLog(@"找兼职");
            [self.navigationController pushViewController:home animated:YES];
            break;
        }
        case THHomeViewButtonTypeInternshipSearch:
        {NSLog(@"找实习");
            TH_FindJobVC * home =[[TH_FindJobVC alloc] init];
            home.title = @"找实习";

            [self.navigationController pushViewController:home animated:YES];
            break;
        }
        case THHomeViewButtonTypeInformationDesk:
        {NSLog(@"信息台");
            TH_InformationDeskVC * information = [[TH_InformationDeskVC alloc] init];
            information.title = @"信息台";
            [self.navigationController pushViewController:information animated:YES];
            break;
        }
        case THHomeViewButtonTypeResumeWriting:
        {NSLog(@"写简历");
            if([AppDelegate instance].userId)
            {
                ManagerResumeVC * manaVC = [[ManagerResumeVC alloc] init];
                [self.navigationController pushViewController:manaVC animated:YES];
            }else
            {
                self.navigationController.navigationBarHidden = YES;
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您尚未登陆" delegate:self cancelButtonTitle:@"暂不登陆" otherButtonTitles:@"登陆", nil];
                [alertView show];
            }
           
            break;
        }
        case THHomeViewButtonTypePlayFan:
        {NSLog(@"玩出范");
            TH_PlayFanVC * play =[[ TH_PlayFanVC alloc] init];
            play.title = @"玩出范";
            [self.navigationController pushViewController:play animated:YES];
            break;
        }
        case THHomeViewButtonTypeMicroSocial:
        {NSLog(@"微社交");
            
            
//            CompanyDetailVC * detail = [[CompanyDetailVC alloc] init];
//            [self.navigationController pushViewController:detail animated:YES];
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"正在建设中,敬请期待" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
            
            
            break;
        }
          case THHomeViewButtonTypeOpenClass:
        {NSLog(@"公开课");
          TH_ClassVC * class =  [[TH_ClassVC alloc] init];
            [self.navigationController pushViewController:class animated:YES];
            
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
    _bannerView = [[SGFocusImageFrame alloc] initWithFrame:CGRectMake(0*MyWideth, -20, WIDETH, 180*MyHeight)];
    _bannerView.isAutoPlay = YES;
    _bannerView.delegate = self;
    _bannerView.changeFocusImageInterval = 2;
    [self.scro addSubview:_bannerView];
}

- (void)quereData
{
    self.dataDic = [NSMutableDictionary dictionaryWithCapacity:0 ];

       [TH_AFRequestState CarouselFigureRequestWithSucc:^(NSDictionary * arr) {
        
          self.dataDic = arr[@"data"];
           if (is3_5Inch||is4Inch) {
               self.str1 = self.dataDic[@"lunbo1"];
               self.str2 =self.dataDic[@"lunbo1.2"];
               self.str3 = self.dataDic[@"lunbo1.3"];
           }else if (is4_7Inch)
           {
               self.str1 = self.dataDic[@"lunbo2"];
               self.str2 =self.dataDic[@"lunbo2.2"];
               self.str3 = self.dataDic[@"lunbo2.3"];
           }else if (is5_5Inch)
           {
               self.str1 = self.dataDic[@"lunbo3"];
               self.str2 =self.dataDic[@"lunbo3.2"];
               self.str3 = self.dataDic[@"lunbo3.3"];
            }
         
           self.imageArr = [NSArray arrayWithObjects:@{@"photo":self.str1},@{@"photo":self.str2},@{@"photo":self.str3}, nil];
           [_bannerView setImageURLs:self.imageArr];
    } withfail:^(int errCode, NSError *err) {
        
    }];
}

/*
 bannerView item 点击方法
 */
- (void)foucusImageFrame:(SGFocusImageFrame *)imageFrame didSelectItem:(HomePageModel *)item
{
    NSLog(@"在此处进行跳转%@",item.extend);
}

#pragma mark - - 状态栏
-(void)setStatus
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

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

//删除搜索视图
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"_searChBgView%p",_searChBgView);
    [_searChBgView removeFromSuperview];
    [_searchView removeFromSuperview];

    _searchView = nil;
    _searChBgView = nil;
}

//隐藏导航栏,创建搜索视图
-(void)viewWillAppear:(BOOL)animated
{
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
    //搜索
    [self createSearch];
    
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
