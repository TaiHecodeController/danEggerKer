//
//  THCoursePlayVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
// 

#import "THCoursePlayVC.h"
#import "Course PlayCell.h"
#import "CourePlayTitle.h"

#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import "MBProgressHUD.h"
#import "PLVMoviePlayerController.h"
//课程标题cell
#import "Course PlayCell.h"
#import "CourePlayTitle.h"
#import "UIBarButtonItem+DC.h"
#import "AppDelegate.h"

#define TopViewHeight 44
//#define BottomViewHeight 72
#define BottomViewHeight 44

#define VolumeStep 0.02f
#define BrightnessStep 0.02f
#define MovieProgressStep 5.0f

//#define IOS7 ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

typedef NS_ENUM(NSInteger, GestureType){
    GestureTypeOfNone = 0,
    GestureTypeOfVolume,
    GestureTypeOfBrightness,
    GestureTypeOfProgress,
};

//记住播放进度相关的数据库操作类
@interface DatabaseManager : NSObject
+ (id)defaultDatabaseManager;
- (void)addPlayRecordWithIdentifier:(NSString *)identifier progress:(CGFloat)progress;
- (CGFloat)getProgressByIdentifier:(NSString *)identifier;

@end

@interface THCoursePlayVC ()<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)BOOL isPlaying;
@property (nonatomic,strong)AVPlayer *player;
@property (nonatomic,strong)NSMutableArray *itemTimeList;
@property (nonatomic)CGFloat movieLength;
@property (nonatomic)double lastPlayTime;
@property (nonatomic)NSInteger currentPlayingItem;
@property (nonatomic,strong)MBProgressHUD *progressHUD;

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIButton *returnBtn;
@property (nonatomic,strong)UILabel *titleLable;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UIButton *playBtn;
@property (nonatomic,strong)UIButton *backwardBtn;
@property (nonatomic,strong)UIButton *forwardBtn;
@property (nonatomic,strong)UIButton *fastBackwardBtn;
@property (nonatomic,strong)UIButton *fastForeardBtn;

@property (nonatomic,strong)UISlider *movieProgressSlider;
@property (nonatomic,strong)UILabel *currentLable;
@property (nonatomic,strong)UILabel *remainingTimeLable;

@property (nonatomic,strong)UIImageView *brightnessView;
@property (nonatomic,strong)UIProgressView *brightnessProgress;

// 视频Logo
@property (nonatomic,strong)UIImageView *videoLogo;

@property (nonatomic,strong)UIView *progressTimeView;
@property (nonatomic,strong)UILabel *progressTimeLable_top;
@property (nonatomic,strong)UILabel *progressTimeLable_bottom;
@property (nonatomic,assign)CGFloat ProgressBeginToMove;

@property (nonatomic,weak)id timeObserver;

@property (nonatomic,assign)GestureType gestureType;

@property (nonatomic,assign)CGPoint originalLocation;

@property (nonatomic,assign)CGFloat systemBrightness;

@property (nonatomic,assign)BOOL isFirstOpenPlayer;//第一次打开需要读取历史观看进度

@property (nonatomic, strong) PLVMoviePlayerController *PLvideoPlayer;

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation THCoursePlayVC

#pragma mark - init
- (id)initNetworkMoviePlayerViewControllerWithURL:(NSURL *)url movieTitle:(NSString *)movieTitle{
    self = [super init];
    if (self) {
        _isPlaying = YES;
        _isFirstOpenPlayer = NO;
        _movieURL = url;
        _movieURLList = @[url];
        _movieTitle = movieTitle;
        _itemTimeList = [[NSMutableArray alloc]initWithCapacity:5];
        _mode = MoviePlayerViewControllerModeNetwork;
    }
    return self;
}

- (id)initNetworkMoviePlayerViewControllerWithURL:(NSURL *)url movieTitle:(NSString *)movieTitle withLastTime:(double) lastTime
{
    self = [super init];
    if (self) {
        _isPlaying = YES;
        _isFirstOpenPlayer = NO;
        _movieURL = url;
        _movieURLList = @[url];
        _movieTitle = movieTitle;
        _itemTimeList = [[NSMutableArray alloc]initWithCapacity:5];
        _mode = MoviePlayerViewControllerModeNetwork;
        _lastPlayTime = lastTime;
        
    }
    return self;
}


- (id)initLocalMoviePlayerViewControllerWithURL:(NSURL *)url movieTitle:(NSString *)movieTitle{
    self = [super init];
    if (self) {
        _isPlaying = YES;
        _isFirstOpenPlayer = NO;
        _movieURL = url;
        _movieURLList = @[url];
        _movieTitle = movieTitle;
        _itemTimeList = [[NSMutableArray alloc]initWithCapacity:5];
        _mode = MoviePlayerViewControllerModeLocal;
    }
    return self;
}
- (id)initLocalMoviePlayerViewControllerWithURLList:(NSArray *)urlList movieTitle:(NSString *)movieTitle{
    self = [super init];
    if (self) {
        _isPlaying = YES;
        _isFirstOpenPlayer = NO;
        _movieURL = nil;
        _movieURLList = urlList;
        _movieTitle = movieTitle;
        _itemTimeList = [[NSMutableArray alloc]initWithCapacity:5];
        _mode = MoviePlayerViewControllerModeLocal;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        // iOS 7
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }
//    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    
    [backBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self createTopView];
    //    [self createBottomView];
    [self createAvPlayer];
    [self createBrightnessView];
    [self createProgressTimeLable];
//    [self performSelector:@selector(hidenControlBar) withObject:nil afterDelay:3];
    [self.view bringSubviewToFront:_topView];
    [self.view bringSubviewToFront:_bottomView];
    
    //监控 app 活动状态，打电话/锁屏 时暂停播放
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:MPMoviePlayerDidEnterFullscreenNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    //    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    //    if (![userd boolForKey:@"isFirstOpenMoviePlayerViewController"]) {
    //        //第一次打开，显示引导页
    //        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    //        btn.contentMode = UIViewContentModeScaleAspectFill;
    //        if (self.view.frame.size.height>500) {
    //            [btn setImage:[UIImage imageNamed:@"player_guide_1136.png"] forState:UIControlStateNormal];
    //        }else{
    //            [btn setImage:[UIImage imageNamed:@"player_guide_960.png"] forState:UIControlStateNormal];
    //        }
    //        [btn addTarget:self action:@selector(firstCoverOnClick:) forControlEvents:UIControlEventTouchDown];
    //        [self.view addSubview:btn];
    //        [userd setBool:YES forKey:@"isFirstOpenMoviePlayerViewController"];
    //        [userd synchronize];
    //
    //    }
#pragma mark 设置logo
    //    UIImageView *LOGO = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"player_logo"]];
    //    LOGO.frame = CGRectMake(self.view.bounds.size.height-48-10, 10, 48, 56);
    //    [self.view addSubview:LOGO];
    
    self.title = @"课程播放";
    [self createCourePlay];
    [self createTableView];
}

#pragma mark -- 添加课程标题列表
-(void)createCourePlay
{
    
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDETH, 211)];
    
    bgImageView.image =[UIImage imageNamed:@"shipinchuangkou"];
    //    [self.view addSubview:bgImageView];
}
-(void)createTableView
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 211, WIDETH, HEIGHT - 211-64) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Course_PlayCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Course PlayCell" owner:self options:nil] firstObject];
    }
    
    [cell setOrderValue:(int)indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CourePlayTitle * coureTitle = [[[NSBundle mainBundle] loadNibNamed:@"CourePlaytitle" owner:self options:nil] lastObject];
    return coureTitle;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 66;
}

#pragma mark -- ========================================
- (void)viewWillAppear:(BOOL)animated{
//    [AppDelegate instance].ori_flag = 1;
    _systemBrightness = [UIScreen mainScreen].brightness;
    
    //    [MobClick beginLogPageView:@"视频播放"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
//    [AppDelegate instance].ori_flag = 0;
    [super viewWillDisappear:animated];
    //    [MobClick endLogPageView:@"视频播放"];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)createAvPlayer{
    
    CGRect playerFrame = CGRectMake(0, 0, self.view.layer.bounds.size.height, self.view.layer.bounds.size.width);
    _progressHUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_progressHUD];
    [_progressHUD show:YES];
    
    self.PLvideoPlayer = [[PLVMoviePlayerController alloc]initWithVid:[NSString stringWithFormat:@"%@",_movieURL]];
    [self.view addSubview:self.PLvideoPlayer.view];
    //    [self.PLvideoPlayer.view setFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)];
    [self.PLvideoPlayer.view setFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,211)];
    [self.PLvideoPlayer play];
    
    [_progressHUD removeFromSuperview];
    [_progressHUD show:NO];
    
    //    BACK(^{
    //
    //        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    //        __block CMTime totalTime = CMTimeMake(0, 0);
    //        [_movieURLList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    //            NSURL *url = (NSURL *)obj;
    //            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    //            totalTime.value += playerItem.asset.duration.value;
    //            totalTime.timescale = playerItem.asset.duration.timescale;
    //            [_itemTimeList addObject:[NSNumber numberWithDouble:((double)playerItem.asset.duration.value/totalTime.timescale)]];
    //        }];
    //        _movieLength = (CGFloat)totalTime.value/totalTime.timescale;
    //        _player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithURL:(NSURL *)_movieURLList[0]]];
    //
    //        MAIN((^{
    //            AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //
    //            playerLayer.frame = playerFrame;
    //            playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    ////            [self.view.layer addSublayer:playerLayer];
    //            [self.view.layer insertSublayer:playerLayer atIndex:0];
    //
    //            [_player play];
    //            _currentPlayingItem = 0;
    //
    //            //注册检测视频加载状态的通知
    //            [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //
    //            [_player.currentItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    //
    //            [_player.currentItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    //
    //
    //
    //            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //            //    [_player.currentItem  addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //
    //            //这里为了避免timer双重引用引起的内存泄漏
    //            __weak typeof(_player) player_ = _player;
    //            __weak typeof(_movieProgressSlider) movieProgressSlider_ = _movieProgressSlider;
    //            __weak typeof(_currentLable) currentLable_ = _currentLable;
    //            __weak typeof(_remainingTimeLable) remainingTimeLable_ = _remainingTimeLable;
    //            __weak typeof(_itemTimeList) itemTimeList_ = _itemTimeList;
    //            typeof(_movieLength) *movieLength_ = &_movieLength;
    //            typeof(_gestureType) *gestureType_ = &_gestureType;
    //            typeof(_currentPlayingItem) *currentPlayingItem_ = &_currentPlayingItem;
    //            //第一个参数反应了检测的频率
    //            _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(3, 30) queue:NULL usingBlock:^(CMTime time){
    //                if ((*gestureType_) != GestureTypeOfProgress) {
    //                    //获取当前时间
    //                    CMTime currentTime = player_.currentItem.currentTime;
    //                    double currentPlayTime = (double)currentTime.value/currentTime.timescale;
    //
    //                    NSInteger currentTemp = *currentPlayingItem_;
    //
    //                    while (currentTemp > 0) {
    //                        currentPlayTime += [(NSNumber *)itemTimeList_[currentTemp-1] doubleValue];
    //                        --currentTemp;
    //                    }
    //                    //转成秒数  是否是倒计时显示.
    //                    BOOL isDaojishi = NO;
    //                    CGFloat remainingTime;
    //                    if (isDaojishi) {
    //                        remainingTime = (*movieLength_) - currentPlayTime;
    //                    }else
    //                        remainingTime = (*movieLength_) - 0;
    //
    //                    movieProgressSlider_.value = currentPlayTime/(*movieLength_);
    //                    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentPlayTime];
    //                    NSDate *remainingDate = [NSDate dateWithTimeIntervalSince1970:remainingTime];
    //                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //                    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    //
    //                    [formatter setDateFormat:(currentPlayTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    //                    NSString *currentTimeStr = [formatter stringFromDate:currentDate];
    //                    [formatter setDateFormat:(remainingTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    //
    //                    NSString *remainingTimeStr;
    //                    if (isDaojishi) {
    //                        remainingTimeStr = [NSString stringWithFormat:@"-%@",[formatter stringFromDate:remainingDate]];
    //                    }else
    //                        remainingTimeStr =[formatter stringFromDate:remainingDate];
    //
    //                    currentLable_.text = currentTimeStr;
    //                    remainingTimeLable_.text = remainingTimeStr;
    //                }
    //            }];
    //
    //
    //        }));
    //
    //    });
    
}
-(void)startFullScreen
{
    THLog(@"进入全屏状态");
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        [[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIInterfaceOrientationPortrait];
//    }
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationLandscapeRight;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)exitFullScreen
{
    THLog(@"退出全屏状态");
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}


- (void)createTopView{
    CGFloat titleLableWidth = 400;
    CGFloat margin = 10;
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, TopViewHeight)];
    _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    
    UIImage *ruturnIcon = [UIImage imageNamed:@"bofang"];
    _returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(margin, margin, ruturnIcon.size.width, ruturnIcon.size.height)];
//    [_returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    //    [_returnBtn setImage:[UIImage imageNamed:@"public_nav_btn_return_n"] forState:UIControlStateNormal];//ZHBrowserIconBack
    [_returnBtn setBackgroundImage:[UIImage imageNamed:@"xiangxi"] forState:UIControlStateNormal];
    [_returnBtn setTitleColor:[UIColor colorWithRed:0.01f green:0.48f blue:0.98f alpha:1.00f] forState:UIControlStateNormal];
    [_returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_returnBtn addTarget:self action:@selector(returnBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_topView addSubview:_returnBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/2-titleLableWidth/2, 0, titleLableWidth, TopViewHeight)];
    _titleLable.backgroundColor = [UIColor clearColor];
    _titleLable.text = _movieTitle;
    _titleLable.textColor = [UIColor whiteColor];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:_titleLable];
    
    UIImage *downIcon = [UIImage imageNamed:@"bofang"];
    UIButton *downBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDETH - margin - downIcon.size.width, margin, downIcon.size.width, downIcon.size.height)];
    [downBtn setBackgroundImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
//    [downBtn setTitle:@"向下" forState:UIControlStateNormal];
    //    [_returnBtn setImage:[UIImage imageNamed:@"public_nav_btn_return_n"] forState:UIControlStateNormal];//ZHBrowserIconBack
    [downBtn setTitleColor:[UIColor colorWithRed:0.01f green:0.48f blue:0.98f alpha:1.00f] forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downBtn addTarget:self action:@selector(downBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [_topView addSubview:downBtn];
    
    [self.view addSubview:_topView];
}
- (void)createBottomView{
    CGRect bounds = self.view.bounds;
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, bounds.size.width-BottomViewHeight, bounds.size.height, BottomViewHeight)];
    _bottomView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.4f];
    
    // top
    CGFloat marginTop = 13;
    //    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.height/2-20, marginTop-12, 40, 40)];
    
    _playBtn = [[UIButton alloc]initWithFrame:CGRectMake(bounds.size.height/2-20, marginTop-12, 40, 40)];
    
    
    [_playBtn setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(pauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_playBtn];
    
    _fastBackwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_playBtn.frame.origin.x-56-21, marginTop, 21, 16)];
    _fastBackwardBtn.tag = 1;
    [_fastBackwardBtn setImage:[UIImage imageNamed:@"fast_backward_nor.png"] forState:UIControlStateNormal];
    [_fastBackwardBtn addTarget:self action:@selector(fastAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fastBackwardBtn];
    
    _fastForeardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_playBtn.frame.origin.x+_playBtn.frame.size.width+56, marginTop, 21, 16)];
    _fastForeardBtn.tag = 2;
    [_fastForeardBtn setImage:[UIImage imageNamed:@"fast_forward_nor.png"] forState:UIControlStateNormal];
    [_fastForeardBtn addTarget:self action:@selector(fastAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_fastForeardBtn];
    
    _forwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_fastForeardBtn.frame.origin.x+_fastForeardBtn.frame.size.width+56, marginTop, 16, 16)];
    _forwardBtn.tag = 1;
    [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateNormal];
    [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateHighlighted
     ];
    [_bottomView addSubview:_forwardBtn];
    
    _backwardBtn = [[UIButton alloc]initWithFrame:CGRectMake(_fastBackwardBtn.frame.origin.x-56-16, marginTop, 16, 16)];
    _backwardBtn.tag = 2;
    [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateNormal];
    [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateHighlighted];
    [_bottomView addSubview:_backwardBtn];
    
    if (_datasource) {
        if ([_datasource isHaveNextMovie]) {
            [_forwardBtn setImage:[UIImage imageNamed:@"forward_nor.png"] forState:UIControlStateNormal];
            [_forwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([_datasource isHavePreviousMovie]) {
            [_backwardBtn setImage:[UIImage imageNamed:@"backward_nor.png"] forState:UIControlStateNormal];
            [_backwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    //bottom
    CGFloat bottomOrigin_y = BottomViewHeight - 30;
    
    _playBtn.frame = CGRectMake(5, (BottomViewHeight-40)/2, 40, 40);
    
    _currentLable = [[UILabel alloc]initWithFrame:CGRectMake(_playBtn.frame.size.width+5 , bottomOrigin_y, 63, 20)];
    _currentLable.font = [UIFont systemFontOfSize:13];
    _currentLable.textColor = [UIColor whiteColor];
    _currentLable.backgroundColor = [UIColor clearColor];
    _currentLable.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_currentLable];
    
    _movieProgressSlider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetWidth(_currentLable.frame)+(_currentLable.frame.origin.x), bottomOrigin_y, bounds.size.height-(CGRectGetWidth(_currentLable.frame))*2-44-5, 20)];//height 34
    [_movieProgressSlider setMinimumTrackTintColor:[UIColor whiteColor]];
    [_movieProgressSlider setMaximumTrackTintColor:[UIColor colorWithRed:0.49f green:0.48f blue:0.49f alpha:1.00f]];
    [_movieProgressSlider setThumbImage:[UIImage imageNamed:@"progressThumb.png"] forState:UIControlStateNormal];
    [_movieProgressSlider addTarget:self action:@selector(scrubbingDidBegin) forControlEvents:UIControlEventTouchDown];
    [_movieProgressSlider addTarget:self action:@selector(scrubbingDidEnd) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchCancel)];
    [_bottomView addSubview:_movieProgressSlider];
    
    _remainingTimeLable = [[UILabel alloc]initWithFrame:CGRectMake(bounds.size.height-63, bottomOrigin_y, 63, 20)];
    _remainingTimeLable.font = [UIFont systemFontOfSize:13];
    _remainingTimeLable.textColor = [UIColor whiteColor];
    _remainingTimeLable.backgroundColor = [UIColor clearColor];
    _remainingTimeLable.textAlignment = NSTextAlignmentCenter;
    [_bottomView addSubview:_remainingTimeLable];
    
//    [self.view addSubview:_bottomView];
    
    [_fastBackwardBtn setHidden:YES];
    [_fastForeardBtn setHidden:YES];
    [_forwardBtn setHidden:YES];
    [_backwardBtn setHidden:YES];
    
    
}

- (void)createBrightnessView{
    _brightnessView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/2-63, self.view.frame.size.width/2-63, 125, 125)];
    _brightnessView.image = [UIImage imageNamed:@"video_brightness_bg.png"];
    
    _brightnessProgress = [[UIProgressView alloc]initWithFrame:CGRectMake(_brightnessView.frame.size.width/2-40, _brightnessView.frame.size.height-30, 80, 10)];
    _brightnessProgress.trackImage = [UIImage imageNamed:@"video_num_bg.png"];
    _brightnessProgress.progressImage = [UIImage imageNamed:@"video_num_front.png"];
    _brightnessProgress.progress = [UIScreen mainScreen].brightness;
    [_brightnessView addSubview:_brightnessProgress];
//    [self.view addSubview:_brightnessView];
    _brightnessView.alpha = 0;
}

- (void)createProgressTimeLable{
    _progressTimeView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.height/2-100, self.view.bounds.size.width/2-30, 200, 60)];
    _progressTimeLable_top = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    _progressTimeLable_top.textAlignment = NSTextAlignmentCenter;
    _progressTimeLable_top.textColor = [UIColor whiteColor];
    _progressTimeLable_top.backgroundColor = [UIColor clearColor];
    _progressTimeLable_top.font = [UIFont systemFontOfSize:25];
    _progressTimeLable_top.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _progressTimeLable_top.shadowOffset = CGSizeMake(1.0, 1.0);
    [_progressTimeView addSubview:_progressTimeLable_top];
    
    _progressTimeLable_bottom = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 200, 30)];
    _progressTimeLable_bottom.textAlignment = NSTextAlignmentCenter;
    _progressTimeLable_bottom.textColor = [UIColor whiteColor];
    _progressTimeLable_bottom.backgroundColor = [UIColor clearColor];
    _progressTimeLable_bottom.font = [UIFont systemFontOfSize:25];
    _progressTimeLable_bottom.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _progressTimeLable_bottom.shadowOffset = CGSizeMake(1.0, 1.0);
    [_progressTimeView addSubview:_progressTimeLable_bottom];
    
//    [self.view addSubview:_progressTimeView];
}
- (void)updateProfressTimeLable{
    double currentTime = floor(_movieLength *_movieProgressSlider.value);
    double changeTime = floor(_movieLength*ABS(_movieProgressSlider.value-_ProgressBeginToMove));
    //转成秒数
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentTime];
    NSDate *changeDate = [NSDate dateWithTimeIntervalSince1970:changeTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    [formatter setDateFormat:(currentTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    NSString *currentTimeStr = [formatter stringFromDate:currentDate];
    
    [formatter setDateFormat:(changeTime/3600>=1)? @"h:mm:ss":@"mm:ss"];
    NSString *changeTimeStr = [formatter stringFromDate:changeDate];
    
    _progressTimeLable_top.text = currentTimeStr;
    _progressTimeLable_bottom.text = [NSString stringWithFormat:@"[%@ %@]",(_movieProgressSlider.value-_ProgressBeginToMove) < 0? @"-":@"+",changeTimeStr];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //        [_player play];
        CGFloat progress  = _lastPlayTime;
        _movieProgressSlider.value = progress;
        _isFirstOpenPlayer = YES;
        [self scrubbingDidEnd];
    }else
    {
        
        //        [_player play];
        CGFloat progress  = 0;
        _movieProgressSlider.value = progress;
        _isFirstOpenPlayer = YES;
        [self scrubbingDidEnd];
        [_progressHUD hide:YES];
        
        
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    @try {
        
        if ([keyPath isEqualToString:@"status"]) {
            AVPlayerItem *playerItem = (AVPlayerItem*)object;
            if (playerItem.status == AVPlayerStatusFailed)
            {
                //            [g_AppDelegate showNormalyTextView:@"无法播放该视频" interval:1.5];
                UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"Error" message:@"无法播放该视频" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                
                return;
                
            }else
                if (playerItem.status == AVPlayerStatusReadyToPlay) {
                    //视频加载完成,去掉等待
                    [_progressHUD hide:YES];
                    
                    //获取上次播放进度,仅对本地有效
                    if (!_isFirstOpenPlayer) {
                        
                        //CGFloat progress = [[DatabaseManager defaultDatabaseManager] getProgressByIdentifier:_movieTitle];
                        
                        if (_lastPlayTime > 0) {
#pragma mark 时间节点改变.
                            // 解决我们上次播放节点设置.
                            CGFloat progress  = _lastPlayTime;
                            _movieProgressSlider.value = progress;
                            
                            [_player pause];
                            
                            //                    [self pauseBtnClick];
                            
                            double last = floor(_movieLength *_movieProgressSlider.value);
                            
                            
                            NSDate *PlayTime = [NSDate dateWithTimeIntervalSince1970:last];
                            
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
                            
                            [formatter setDateFormat:(last/3600>=1)? @"h:mm:ss":@"mm:ss"];
                            NSString *mStrlastPlayTime =[formatter stringFromDate:PlayTime];
                            
                            NSString *alertMsg  =[NSString stringWithFormat:@"您上次学习到: %@ \n是否接着上次学习",mStrlastPlayTime];
                            
                            UIAlertView *alertView;
                            alertView = [[UIAlertView alloc] initWithTitle:@"学习记录" message:alertMsg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                            [alertView show];
                            
                        }else
                        {
                            CGFloat progress  = 0;
                            _movieProgressSlider.value = progress;
                            _isFirstOpenPlayer = YES;
                            [self scrubbingDidEnd];
                        }
                        
                    }
                }
        }else if ([keyPath isEqualToString:@"playbackBufferEmpty"] && _player.currentItem.playbackBufferEmpty)
        {
            [_progressHUD show:YES];
            
        }else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"] && _player.currentItem.playbackLikelyToKeepUp)
        {
            [_progressHUD hide:YES];
            
        }
        //    if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        //        float bufferTime = [self availableDuration];
        //        NSLog(@"缓冲进度%f",bufferTime);
        //        float durationTime = CMTimeGetSeconds([[_player currentItem] duration]);
        //        NSLog(@"缓冲进度：%f , 百分比：%f",bufferTime,bufferTime/durationTime);
        //    }
        
    }
    @catch (NSException *exception) {
        NSLog(@"异常错误是:%@", exception);
    }
    @finally {
        
    }
    
}
//加载进度
//- (float)availableDuration
//{
//    NSArray *loadedTimeRanges = [[_player currentItem] loadedTimeRanges];
//    if ([loadedTimeRanges count] > 0) {
//        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
//        float startSeconds = CMTimeGetSeconds(timeRange.start);
//        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        return (startSeconds + durationSeconds);
//    }else{
//        return 0.0f;
//    }
//}

#pragma mark - action
/*
 *程序活动的动作
 */
- (void)becomeActive{
    [self pauseBtnClick];
}
/*
 *程序不活动的动作
 */
- (void)resignActive{
    [self pauseBtnClick];
}
//播放/暂停
- (void)pauseBtnClick
{
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
        [_player play];
        [_playBtn setImage:[UIImage imageNamed:@"pause_nor.png"] forState:UIControlStateNormal];
        
    }else{
        [_player pause];
        [_playBtn setImage:[UIImage imageNamed:@"play_nor.png"] forState:UIControlStateNormal];
    }
}
//#define RateStep 0.5
//快退／快进
- (void)fastAction:(UIButton *)btn{
    if (btn.tag == 1) {
        [self movieProgressAdd:-MovieProgressStep];
    }else if (btn.tag == 2){
        [self movieProgressAdd:MovieProgressStep];
    }
}
//上一部／下一部
- (void)forWordOrBackWardMovieAction:(UIButton *)btn{
    _movieProgressSlider.value = 0.f;
    [_progressHUD show:YES];
    //下一部
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
    NSDictionary *dic = nil;
    if (btn.tag == 1) {
        dic = [_datasource nextMovieURLAndTitleToTheCurrentMovie];
    }else if(btn.tag == 2){
        dic = [_datasource previousMovieURLAndTitleToTheCurrentMovie];
    }
    _movieURL = (NSURL *)[dic objectForKey:KURLOfMovieDicTionary];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:_movieURL];
    [_player replaceCurrentItemWithPlayerItem:playerItem];
    _movieTitle = [dic objectForKey:KTitleOfMovieDictionary];
    _titleLable.text = _movieTitle;
    //注册检测视频加载状态的通知
    [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    //检测上一部/下一部电影的存在性
    if (_datasource && [_datasource isHaveNextMovie]) {
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_nor.png"] forState:UIControlStateNormal];
        [_forwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateNormal];
        [_forwardBtn setImage:[UIImage imageNamed:@"forward_disable.png"] forState:UIControlStateHighlighted];
        [_forwardBtn removeTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (_datasource && [_datasource isHavePreviousMovie]) {
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_nor.png"] forState:UIControlStateNormal];
        [_backwardBtn addTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateNormal];
        [_backwardBtn setImage:[UIImage imageNamed:@"backward_disable.png"] forState:UIControlStateHighlighted];
        [_backwardBtn removeTarget:self action:@selector(forWordOrBackWardMovieAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

//视频播放到结尾
- (void)playerItemDidReachEnd:(NSNotification *)notification{
    if (_currentPlayingItem+1 == _movieURLList.count) {
        [self popView];
    }else{
        ++_currentPlayingItem;
        [_player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:_movieURLList[_currentPlayingItem]]];
        if (_isPlaying == YES){
            [_player play];
        }
        //        [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    }
}
//声音增加
- (void)volumeAdd:(CGFloat)step{
    [MPMusicPlayerController applicationMusicPlayer].volume += step;;
}
//亮度增加
- (void)brightnessAdd:(CGFloat)step{
    [UIScreen mainScreen].brightness += step;
    _brightnessProgress.progress = [UIScreen mainScreen].brightness;
}
//快进／快退
- (void)movieProgressAdd:(CGFloat)step{
    _movieProgressSlider.value += (step/_movieLength);
    [self scrubberIsScrolling];
}
//首次打开引导的点击消失
- (void)firstCoverOnClick:(UIButton *)button{
    [button removeFromSuperview];
}
//返回事件
- (void)popView
{
    //保存本次播放进度
    //    [[DatabaseManager defaultDatabaseManager] addPlayRecordWithIdentifier:_movieTitle progress:_movieProgressSlider.value];
    
    [_player removeTimeObserver:_timeObserver];
    [self removeObserversFromVideoPlayerItem];
    [_player replaceCurrentItemWithPlayerItem:nil];//自动移除 observer
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.timeObserver = nil;
        self.player = nil;
        [UIScreen mainScreen].brightness = _systemBrightness;
        if ([_delegate respondsToSelector:@selector(movieFinished:)]) {
            [_delegate movieFinished:_movieProgressSlider.value];
        }
    }];
    
    if(self.PLvideoPlayer.playbackState == MPMoviePlaybackStatePlaying){
        [self.PLvideoPlayer stop];
    }
    
}

// 移除观察者.
- (void)removeObserversFromVideoPlayerItem
{
    [_player.currentItem removeObserver:self forKeyPath:@"status"];
//    [_player.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
//    [_player.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    //    [_player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

//按动滑块
-(void)scrubbingDidBegin
{
    _gestureType = GestureTypeOfProgress;
    _ProgressBeginToMove = _movieProgressSlider.value;
    _progressTimeView.hidden = NO;
}
//拖动进度条
-(void)scrubberIsScrolling
{
    if (_mode == MoviePlayerViewControllerModeNetwork) {
        [_progressHUD show:YES];
    }
    double currentTime = floor(_movieLength *_movieProgressSlider.value);
    
    int i = 0;
    double temp = [((NSNumber *)_itemTimeList[i]) doubleValue];
    while (currentTime > temp) {
        ++i;
        temp += [((NSNumber *)_itemTimeList[i]) doubleValue];
    }
    if (i != _currentPlayingItem) {
        [_player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:(NSURL *)_movieURLList[i]]];
        //        [_player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        _currentPlayingItem = i;
    }
    temp -= [((NSNumber *)_itemTimeList[i]) doubleValue];
    
    [self updateProfressTimeLable];
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(currentTime-temp, 1);
    [_player seekToTime:dragedCMTime completionHandler:
     ^(BOOL finish){
         if (_isPlaying == YES){
             [_player play];
         }
     }];
}
//释放滑块
-(void)scrubbingDidEnd
{
    _gestureType = GestureTypeOfNone;
    _progressTimeView.hidden = YES;
    [self scrubberIsScrolling];
}

- (void)leftBtnClick
{
    THLog(@"左侧按钮被点击");
    [self popView];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark touch event

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self.view];
    CGFloat offset_x = currentLocation.x - _originalLocation.x;
    CGFloat offset_y = currentLocation.y - _originalLocation.y;
    if (CGPointEqualToPoint(_originalLocation,CGPointZero)) {
        _originalLocation = currentLocation;
        return;
    }
    _originalLocation = currentLocation;
    
    CGRect frame = [UIScreen mainScreen].bounds;
    if (_gestureType == GestureTypeOfNone) {
        if ((currentLocation.x > frame.size.height*0.8) && (ABS(offset_x) <= ABS(offset_y))){            _gestureType = GestureTypeOfVolume;
        }else if ((currentLocation.x < frame.size.height*0.2) && (ABS(offset_x) <= ABS(offset_y))){            _gestureType = GestureTypeOfBrightness;
        }else if ((ABS(offset_x) > ABS(offset_y))) {
            _gestureType = GestureTypeOfProgress;
            _progressTimeView.hidden = NO;
        }
    }
    if ((_gestureType == GestureTypeOfProgress) && (ABS(offset_x) > ABS(offset_y))) {
        if (offset_x > 0) {
            //            NSLog(@"横向向右");
            _movieProgressSlider.value += 0.005;
        }else{
            //            NSLog(@"横向向左");
            _movieProgressSlider.value -= 0.005;
        }
        [self updateProfressTimeLable];
    }else if ((_gestureType == GestureTypeOfVolume) && (currentLocation.x > frame.size.height*0.8) && (ABS(offset_x) <= ABS(offset_y))){
        if (offset_y > 0){
            [self volumeAdd:-VolumeStep];
        }else{
            [self volumeAdd:VolumeStep];
        }
    }else if ((_gestureType == GestureTypeOfBrightness) && (currentLocation.x < frame.size.height*0.2) && (ABS(offset_x) <= ABS(offset_y))){
        if (offset_y > 0) {
            _brightnessView.alpha = 1;
            [self brightnessAdd:-BrightnessStep];
        }else{
            _brightnessView.alpha = 1;
            [self brightnessAdd:BrightnessStep];
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _originalLocation = CGPointZero;
    _ProgressBeginToMove = _movieProgressSlider.value;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    if (_gestureType == GestureTypeOfNone && !CGRectContainsPoint(_bottomView.frame, point) && !CGRectContainsPoint(_topView.frame, point)) {
        //这说明是轻拍收拾，隐藏／现实状态栏
        [UIView animateWithDuration:0.25 animations:^{
            CGRect topFrame = _topView.frame;
            CGRect bottomFrame = _bottomView.frame;
            if (topFrame.origin.y<0) {
                //显示
                topFrame.origin.y = 0;
                //!!!: 这里计算把底部视图y计算采用的是：self.view.frame.size.height 不是width
                bottomFrame.origin.y = self.view.frame.size.height-BottomViewHeight;
                [self performSelector:@selector(hidenControlBar) withObject:nil afterDelay:3];
            }else{
                //隐藏
                topFrame.origin.y = -TopViewHeight;
                bottomFrame.origin.y = self.view.frame.size.width;
            }
            _topView.frame = topFrame;
            _bottomView.frame = bottomFrame;
        }];
    }else if (_gestureType == GestureTypeOfProgress){
        _gestureType = GestureTypeOfNone;
        _progressTimeView.hidden = YES;
        [self scrubberIsScrolling];
    }else{
        _gestureType = GestureTypeOfNone;
        _progressTimeView.hidden = YES;
        if (_brightnessView.alpha) {
            [UIView animateWithDuration:1 animations:^{
                _brightnessView.alpha = 0;
            }];
        }
    }
}

- (void)hidenControlBar{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect topFrame = _topView.frame;
        CGRect bottomFrame = _bottomView.frame;
        topFrame.origin.y = -TopViewHeight;
        bottomFrame.origin.y = self.view.frame.size.width;
        _topView.frame = topFrame;
        _bottomView.frame = bottomFrame;
    }];
}
#pragma mark - 系统相关
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark -- respondEvent
- (void)returnBtnClick
{
    THLog(@"returnBtnClick被点击");
//    CGAffineTransform landscapeTransform = CGAffineTransformMakeRotation(M_PI / 2);
//    self.PLvideoPlayer.view.transform = landscapeTransform;
//    self.PLvideoPlayer.view.frame = CGRectMake(0, 0, 320, 568);
    
}

- (void)downBtnClick
{
    THLog(@"downBtnClick被点击");
}
//横屏
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    [AppDelegate instance].ori_flag = 1;
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

//- (void)dealloc{
//    NSLog(@"dealloc");
//    [super dealloc];
//}
@end


/*
 * DatabaseManager
 * 通过把播放过的影片的进度信息保存在plist 文件中，实现记住播放历史的功能
 * plist 文件采用队列形式，队列长度为50
 */

NSString *const MoviePlayerArchiveKey_identifier = @"identifier";
NSString *const MoviePlayerArchiveKey_date = @"date";
NSString *const MoviePlayerArchiveKey_progress = @"progress";

NSInteger const MoviePlayerArchiveKey_MaxCount = 50;

@implementation DatabaseManager
- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (DatabaseManager *)defaultDatabaseManager{
    static DatabaseManager *manager = nil;
    if (manager == nil) {
        manager = [[DatabaseManager alloc]init];
    }
    return manager;
}
+ (NSString *)pathOfArchiveFile{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath lastObject];
    NSString *plistFilePath = [documentPath stringByAppendingPathComponent:@"playRecord.plist"];
    return plistFilePath;
}
- (void)addPlayRecordWithIdentifier:(NSString *)identifier progress:(CGFloat)progress{
    
    NSMutableArray *recardList = [[NSMutableArray alloc]initWithContentsOfFile:[DatabaseManager pathOfArchiveFile]];
    if (!recardList) {
        recardList = [[NSMutableArray alloc]init];
    }
    if (recardList.count==MoviePlayerArchiveKey_MaxCount) {
        [recardList removeObjectAtIndex:0];
    }
    
    NSDictionary *dic = @{MoviePlayerArchiveKey_identifier:identifier,MoviePlayerArchiveKey_date:[NSDate date],MoviePlayerArchiveKey_progress:@(progress)};
    [recardList addObject:dic];
    [recardList writeToFile:[DatabaseManager pathOfArchiveFile] atomically:YES];
}

- (CGFloat)getProgressByIdentifier:(NSString *)identifier{
    NSMutableArray *recardList = [[NSMutableArray alloc]initWithContentsOfFile:[DatabaseManager pathOfArchiveFile]];
    __block CGFloat progress = 0;
    [recardList enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *dic = obj;
        if ([dic[MoviePlayerArchiveKey_identifier] isEqualToString:identifier]) {
            progress = [dic[MoviePlayerArchiveKey_progress] floatValue];
            *stop = YES;
        }
    }];
    if (progress > 0.9 || progress < 0.05) {
        return 0;
    }
    return progress;
}



@end
