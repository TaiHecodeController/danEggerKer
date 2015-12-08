//
//  ViewController.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import "ZLSwipeableViewController.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
#import "SearchModelShare.h"
/*数据请求**/
#import "AFAppRequest.h"
#import "findJobModel.h"

@interface ZLSwipeableViewController ()
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

@end

@implementation ZLSwipeableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view, typically from a nib.
    self.jobArr = [[NSMutableArray alloc]init];
    _mbPro = [MBProgressHUD mbHubShowControllerView:self];
    self.page = 1;
    [self loadData:_mbPro page:self.page];
    
    self.colorIndex = 0;
    self.colors = @[
        @"Turquoise",
        @"Green Sea",
        @"Emerald",
        @"Nephritis",
        @"Peter River",
        @"Belize Hole",
        @"Amethyst",
        @"Wisteria",
        @"Wet Asphalt",
        @"Midnight Blue",
        @"Sun Flower",
        @"Orange",
        @"Carrot",
        @"Pumpkin",
        @"Alizarin",
        @"Pomegranate",
        @"Clouds",
        @"Silver",
        @"Concrete",
        @"Asbestos"
    ];

    self.reloadBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reload"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(handleReload:)];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"←"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(handleLeft:)];
    self.upBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"↑"
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(handleUp:)];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"→"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(handleRight:)];
    self.downBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"↓"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(handleDown:)];

    UIBarButtonItem *fixedSpace =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                      target:nil
                                                      action:nil];
    UIBarButtonItem *flexibleSpace =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:nil
                                                      action:nil];
    self.toolbarItems = @[
        fixedSpace,
        _reloadBarButtonItem,
        flexibleSpace,
        _leftBarButtonItem,
        flexibleSpace,
        _upBarButtonItem,
        flexibleSpace,
        _rightBarButtonItem,
        flexibleSpace,
        _downBarButtonItem,
        fixedSpace
    ];

    ZLSwipeableView *swipeableView = [[ZLSwipeableView alloc] initWithFrame:CGRectZero];
    self.swipeableView = swipeableView;
    [self.view addSubview:self.swipeableView];

    // Required Data Source
    self.swipeableView.dataSource = self;

    // Optional Delegate
    self.swipeableView.delegate = self;

    self.swipeableView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *metrics = @{};

    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"|-50-[swipeableView]-50-|"
                                                      options:0
                                                      metrics:metrics
                                                        views:NSDictionaryOfVariableBindings(
                                                                  swipeableView)]];

    [self.view addConstraints:[NSLayoutConstraint
                                  constraintsWithVisualFormat:@"V:|-120-[swipeableView]-100-|"
                                                      options:0
                                                      metrics:metrics
                                                        views:NSDictionaryOfVariableBindings(
                                                                  swipeableView)]];
   
}

-(void)loadData:(id)notify page:(int)num
{
    [SearchModelShare sharedInstance].type = @"55";
    NSString *numStr = [NSString stringWithFormat:@"%d",num];
    
    self.state = [[TH_AFRequestState searchJobWithSucc:^(NSArray *DataArr) {
        
        if (DataArr.count > 0)
        {
            NSLog(@"DataArr:%@",DataArr);
//            [self.swipeableView discardAllViews];
            [self.jobArr removeAllObjects];
            [self.jobArr addObjectsFromArray:DataArr];
            if (self.page == 1)
            {
                
            }
            else
            {
                self.colorIndex = 1;
                [self.swipeableView discardAllViews];
                [self.swipeableView loadViewsIfNeeded];
//                [self nextViewForSwipeableView:self.swipeableView];
            }
            
//
        }
        else
        {
//            [MBProgressHUD creatembHub:@"暂无数据"];
        }
        
    } withfail:^(int errCode, NSError *err) {
        
    } withlongitude:[SearchModelShare sharedInstance].longitude dimensionality:[SearchModelShare sharedInstance].dimensionality keyword:[SearchModelShare sharedInstance].keyword page:numStr hy:[SearchModelShare sharedInstance].hy job_post:[SearchModelShare sharedInstance].job_post salary:[SearchModelShare sharedInstance].salary edu:[SearchModelShare sharedInstance].edu exp:[SearchModelShare sharedInstance].exp type:[SearchModelShare sharedInstance].type sdate:[SearchModelShare sharedInstance].sdate job1:[SearchModelShare sharedInstance].job1 cityid:[SearchModelShare sharedInstance].cityid provinceid:[SearchModelShare sharedInstance].provinceid  resp:[findJobModel class]] addNotifaction:notify];


}

- (void)viewDidLayoutSubviews
{
   [self.swipeableView loadViewsIfNeeded];
}
#pragma mark - Action

- (void)handleLeft:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (void)handleRight:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToRight];
}

- (void)handleUp:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToUp];
}

- (void)handleDown:(UIBarButtonItem *)sender {
    [self.swipeableView swipeTopViewToDown];
}

- (void)handleReload:(UIBarButtonItem *)sender {
    UIActionSheet *actionSheet =
        [[UIActionSheet alloc] initWithTitle:@"Load Cards"
                                    delegate:self
                           cancelButtonTitle:@"Cancel"
                      destructiveButtonTitle:nil
                           otherButtonTitles:@"Programmatically", @"From Xib", nil];
    [actionSheet showInView:self.view];
}

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
//    NSLog(@"did swipe in direction: %zd", direction);
    NSLog(@"%ld",self.colorIndex);
    
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view {
//    NSLog(@"did cancel swipe");
//     NSLog(@"%ld",self.colorIndex);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
//     NSLog(@"%ld",self.colorIndex);
//    //第8个开始滑动时，从新加载下一页数据
//    if (self.colorIndex == 8)
//    {
//        self.colorIndex = 0;
//        self.page ++;
//        [self loadData:_mbPro page:self.page];
//    }
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
//    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f", location.x, location.y,
//          translation.x, translation.y);
//     NSLog(@"%ld",self.colorIndex);
    
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
//    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
//     NSLog(@"%ld",self.colorIndex);
//    NSLog(@"didEndSwipingView %ld",self.colorIndex);
    
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView
{
    NSLog(@"colorIndex%ld",self.colorIndex);
    NSLog(@"jobArr.count%ld",self.jobArr.count);
    
    CardView *view = [[CardView alloc] initWithFrame:swipeableView.bounds];
    
    //取出jobArr对应模型
    if (self.jobArr.count > 0 && self.colorIndex <= self.jobArr.count)
    {
        findJobModel * model = self.jobArr[self.colorIndex - 1];
        //添加一个标签试试
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = CGRectMake(0, 0, 100, 100);
        lab.textColor = [UIColor blackColor];
        lab.text = model.job_id;
        [view addSubview:lab];

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
//
    }
    
    view.backgroundColor = [self colorForName:self.colors[self.colorIndex]];
    self.colorIndex++;

    if (self.loadCardFromXib) {
        UIView *contentView =
            [[NSBundle mainBundle] loadNibNamed:@"CardContentView" owner:self options:nil][0];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [view addSubview:contentView];

        // This is important:
        // https://github.com/zhxnlai/ZLSwipeableView/issues/9
        NSDictionary *metrics =
            @{ @"height" : @(view.bounds.size.height),
               @"width" : @(view.bounds.size.width) };
        NSDictionary *views = NSDictionaryOfVariableBindings(contentView);
        [view addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"H:|[contentView(width)]"
                                                     options:0
                                                     metrics:metrics
                                                       views:views]];
        [view addConstraints:[NSLayoutConstraint
                                 constraintsWithVisualFormat:@"V:|[contentView(height)]"
                                                     options:0
                                                     metrics:metrics
                                                       views:views]];
    }
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

#pragma mark - ()

- (UIColor *)colorForName:(NSString *)name {
    NSString *sanitizedName = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *selectorString = [NSString stringWithFormat:@"flat%@Color", sanitizedName];
    Class colorClass = [UIColor class];
    return [colorClass performSelector:NSSelectorFromString(selectorString)];
}

@end
