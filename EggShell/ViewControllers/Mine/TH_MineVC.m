//
//  TH_MineVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//
#import "TH_MineVC.h"
#import "MineVeiw.h"
#import "MineEditVC.h"
#import "TH_JobWishlistVC.h"
#import "TH_LoginVC.h"
#import "TH_AboutEggshellVC.h"
#import "AppDelegate.h"
#import "ManagerResumeVC.h"
#import "TH_cooperationVC.h"
#import "TH_FeedBackVC.h"
#import "VersionUpdateView.h"
#import "TH_ImagePickerVC.h"
@interface TH_MineVC ()<THMineViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)MineVeiw * mineView;
@end

@implementation TH_MineVC
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;

    self.view.backgroundColor = color(243, 243, 243);
    self.title = @"我的";
    [self createScro];
    [self createView];
    }
-(void)createScro
{
    UIScrollView * sro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-49)];
    [self.view addSubview:sro];
    self.scro = sro;
    self.scro.showsVerticalScrollIndicator = NO;
}
-(void)createView
{
    MineVeiw * minVew = [MineVeiw RegisterMineView];
    
    [minVew mineViewSetButtonTag];
    minVew.mineDelegate = self;
    minVew.frame = CGRectMake(-WIDETH, 0, WIDETH
                              , 450);
    minVew.backgroundColor = color(243, 243, 243);
    self.mineView = minVew;
    [self.scro addSubview:minVew];
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5
          initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
              minVew.frame = CGRectMake(0, 0, WIDETH, 450);
          } completion:nil];
    self.scro.contentSize = CGSizeMake(WIDETH,450+100);

    
}
-(void)homeView:(MineVeiw *)mineView DidClickButton:(THMineViewButtonType)button
{
    switch (button) {
        case THMineViewButtonTypeHeadPortraitBtn:
        {NSLog(@"编辑头像");
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            [actionSheet showInView:self.tableView];
            break;
        }
        case THMineViewButtonTypeEditInformationBtn:
        {NSLog(@"编辑资料");
            MineEditVC * edits = [[MineEditVC alloc] init];
            [self.navigationController pushViewController:edits animated:YES];
            break;
        }
        case THMineViewButtonTypeDeliveryJobsBtn:
        {NSLog(@"投递职位");
            TH_JobWishlistVC * edit = [[TH_JobWishlistVC alloc] init];
            edit.title = @"投递职位";
            [self.navigationController pushViewController:edit animated:YES];            break;
        }
        case THMineViewButtonTypeCollectionJobs:
        {NSLog(@"收藏职位");
            TH_JobWishlistVC * edit = [[TH_JobWishlistVC alloc] init];
            edit.title = @"收藏职位";
            [self.navigationController pushViewController:edit animated:YES];
            break;
        }
        case THMineViewButtonTypeResume:
        {NSLog(@"简历管理");
            ManagerResumeVC * manager = [[ManagerResumeVC alloc] init];
            [self.navigationController pushViewController:manager animated:YES];
            break;
        }
        case THMineViewButtonTypeAboutEggshellBtn:
        {NSLog(@"关于蛋壳儿");
            TH_AboutEggshellVC * aboutAgger = [[TH_AboutEggshellVC alloc] init];
            aboutAgger.title = @"关于蛋壳儿";
            [self.navigationController pushViewController:aboutAgger animated:YES];
            break;
        }
        case THMineViewButtonTypeChannelsCooperation :
        {NSLog(@"合作渠道");
            TH_cooperationVC* login = [[TH_cooperationVC alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            break;
        }
        case THMineViewButtonTypesignOut:
        {
            NSLog(@"退出登录");
            self.navigationController.navigationBarHidden = YES;
            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            appDelegate.mainTabBar = [[TH_MainTabBarController alloc] init];
            
            appDelegate.mainTabBar.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:appDelegate.mainTabBar animated:YES completion:nil];
            break;
        }
        case THMineViewButtonTypeLogin:
        {
            
            
            TH_LoginVC * login = [[TH_LoginVC alloc] init];
            [self.navigationController pushViewController:login animated:YES];
            break;
        }
        case THMineViewButtonTypeFeedback:
        {
            
            NSLog(@"意见反馈");
            TH_FeedBackVC * feed = [[TH_FeedBackVC alloc] init];
            feed.title = @"意见反馈";
            [self.navigationController pushViewController:feed animated:YES];
            break;
        }
        case THMineViewButtonTypeversion:
        {
            NSLog(@"skdfjbc");
            VersionUpdateView * view =[[[NSBundle mainBundle] loadNibNamed:@"VersionUpdate" owner:self options:nil] lastObject];
            ;
            view.frame = CGRectMake(0, 0, 250, 151);
            //    [UIView animateWithDuration:0.5 animations:^{
            //        view.center = self.view.center;
            //    }];
            
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            [self.view addSubview:view];
            [view showVersonView];
            
            break;
        }
            
        default:
            break;
    }
    
    
}
#pragma mark ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self openCamera];
            break;
        case 1:
            [self openPicture];
            break;
        case 2:
            
            break;
    }
}
#pragma mark -打开相机
- (void)openCamera
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark -打开图库
- (void)openPicture
{
    if (![TH_ImagePickerVC isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        return;
    
    TH_ImagePickerVC *picVC = [[TH_ImagePickerVC alloc] init];
    picVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picVC.delegate = self;
    [self presentViewController:picVC animated:YES completion:nil];
}
#pragma mark
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
   
    [self.mineView setIconImage:info[UIImagePickerControllerOriginalImage]];
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
