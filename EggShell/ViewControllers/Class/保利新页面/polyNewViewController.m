//
//  polyNewViewController.m
//  EggShell
//
//  Created by 太和 on 15/9/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "polyNewViewController.h"
#import "VideoDownloader.h"
//#import "DownloadDelegate.h"
#import "PLVMoviePlayerController.h"
#import "AppDelegate.h"

@interface polyNewViewController (){
//    VideoDownloader*_downloader;
//    NSString* _vid;
}

@property (nonatomic, strong) PLVMoviePlayerController *videoPlayer;

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (nonatomic, assign) BOOL isFullScrenn;


@end

@implementation polyNewViewController

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    NSLog(@"moviePlayBackDidFinish");
    
    NSDictionary *notificationUserInfo = [notification userInfo];
    NSNumber *resultValue = [notificationUserInfo objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    MPMovieFinishReason reason = [resultValue intValue];
    if (reason == MPMovieFinishReasonPlaybackError)
    {
        NSError *mediaPlayerError = [notificationUserInfo objectForKey:@"error"];
        if (mediaPlayerError)
        {
            NSLog(@"playback failed with error description: %@", [mediaPlayerError localizedDescription]);
        }
        else
        {
            NSLog(@"playback failed without any given reason");
        }
    }
    
    // Remove observer
    [[NSNotificationCenter 	defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:nil];
    
    
}



- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (IBAction)stopAction:(id)sender {
//    [_downloader stop];
//    
//}
//- (IBAction)deleteAction:(id)sender {
//    [_downloader deleteVideo:_vid level:1];
//    
//    
//}
/**
 点击播放按钮执行创建一个PolyvPlayerViewController实例，设置播放器大小为320x180，位置在左上角0，0坐标
 */
- (IBAction)playAction:(id)sender {
    if(self.videoPlayer.playbackState != MPMoviePlaybackStatePlaying){
        
        //从上次播放的时间开始
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        [self.videoPlayer setCurrentPlaybackTime:delegate.memoryTimer];
        
        [self.videoPlayer play];
    }
    
}

/**
 播放器切换另外一个视频
 */
- (IBAction)switchVid:(id)sender {
    [self.videoPlayer stop];
    
    //切换到另一个视频
    //    [self.videoPlayer setVid:@"sl8da4jjbx5d715bc3a8ce8f8194afab_s"];
    
    //播放下载好的视频
    [self.videoPlayer setVid:_vid];
    [self.videoPlayer play];
}
/**
 暂停播放器
 **/
- (IBAction)pauseAction:(id)sender {
    [self.videoPlayer pause];
}
/**
 启动下载器
 **/
- (IBAction)downloadAction:(id)sender {
//    [_downloader setDownloadDelegate:self];
//    [_downloader start:_vid level:1];
}

/**
 按了全屏按钮
 */

- (IBAction)fullscreenAction:(id)sender
{
    [self.videoPlayer setFullscreen:YES animated:YES];
    
}

/**
 关闭了播放器
 */
- (IBAction)closeAction:(id)sender {
    if(self.videoPlayer.playbackState == MPMoviePlaybackStatePlaying){
        
        //获取记忆时间
//        NSLog(@"记忆时间点%f",self.videoPlayer.currentPlaybackTime);
//        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        delegate.memoryTimer = self.videoPlayer.currentPlaybackTime;
        
        [self.videoPlayer stop];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)playerLoadStateDidChange:(NSNotification*)notification
{
    
    
    MPMoviePlayerController *moviePlayer = [notification object];
    
    if ([moviePlayer loadState] != MPMovieLoadStateUnknown) {
        NSLog(@"playerReady");
        
        // Remove observer
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
        
        // Add movie player as subview
        //[[self view] addSubview:[moviePlayer view]];
        
        
        
    }
    
}

- (void)viewDidLoad
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
//    _downloader = [[VideoDownloader alloc]init];
//    _vid = @"sl8da4jjbxc5feddbc7fcd1a765100a3_s";
    
    //自动选择码率
    self.videoPlayer = [[PLVMoviePlayerController alloc]initWithVid:_vid];
    
    //    NSTimeInterval timer;
    //    [self.videoPlayer setInitialPlaybackTime:timer];
    
    //NSLog(@"current bitrate:%d",[self.videoPlayer getLevel]);
    //播放流畅码率
    //self.videoPlayer = [[MPMoviePlayerController alloc]initWithVid:vid level:1];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerLoadStateDidChange:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    
    [self.view addSubview:self.videoPlayer.view];
    [self.videoPlayer.view setFrame:CGRectMake(0,0,self.view.frame.size.width,240)];
    
    UIButton *btn1 = [[UIButton alloc]init];
    btn1.frame = CGRectMake(0, 300, 100, 100);
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]init];
    btn2.frame = CGRectMake(0, 400, 100, 100);
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:btn2];
    
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)btn1Click
{
    if(self.videoPlayer.playbackState != MPMoviePlaybackStatePlaying){
        
        //从上次播放的时间开始
        //        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        //        [self.videoPlayer setCurrentPlaybackTime:delegate.memoryTimer];
        
        [self.videoPlayer play];
    }

}

- (void)btn2Click
{
//    NSLog(@"%ld",(long)self.videoPlayer.playbackState);
//    if(self.videoPlayer.playbackState == MPMoviePlaybackStatePlaying){
    
        //获取记忆时间
        //        NSLog(@"记忆时间点%f",self.videoPlayer.currentPlaybackTime);
        //        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        //        delegate.memoryTimer = self.videoPlayer.currentPlaybackTime;
        
        [self.videoPlayer stop];
        [self.videoPlayer.view removeFromSuperview];
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dataDownloadFailed:(NSString*)vid reason:(NSString *) reason{
    NSLog(@"%@",reason);
}


#pragma mark -- downloadDelegate

- (void) downloadDidFinished: (NSString *) vid{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频下载完成" message:vid delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
    
    //获取下载好的vid
    _vid = vid;
    
}

- (void) dataDownloadAtPercent:(NSString*)vid percent:(NSNumber *) percent{
    NSLog(@"%@",percent);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progressLabel setText:[NSString stringWithFormat:@"%@%%",percent]];
    });
    
    //_progressLabel.text=@"aaa";
}


@end
