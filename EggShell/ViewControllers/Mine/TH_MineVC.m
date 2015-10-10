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
#import "VPImageCropperViewController.h"
#import "LoginAndRegisterRequest.h"
#import "AFAppRequest.h"
#import "MyMD5.h"

@interface TH_MineVC ()<THMineViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,VPImageCropperDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)AFRequestState * state;
@property(nonatomic,copy)NSString * uidStr;
@end

@implementation TH_MineVC
#define ORIGINAL_MAX_WIDTH 640.0f
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
     [self baseIofomationLogin];
    
    [MobClick beginLogPageView:@"minevc"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"minevc"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = color(243, 243, 241);
    self.title = @"我的";
    [self createScro];
    [self createView];
    [self baseIofomationLogin];
  
}
-(void)baseIofomationLogin
{
    /*是否登录相关处理**/
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        self.mineView.lginBtn.userInteractionEnabled = YES;
        [self.mineView.lginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        self.mineView.DeliveryJobNum.text = @"(0)";
        self.mineView.FavoriteJobNum.text = @"(0)";
        self.mineView.ResumeNum.text = @"(0)";
        self.mineView.userLable.hidden = YES;
        self.mineView.phoneLable.hidden  = YES;
        self.mineView.loginBgview.hidden = YES;
        self.mineView.lginBtn.hidden = NO;
    }else
    {
        [self baseIofomation];
        
    }
}
-(void)baseIofomation
{
    self.mineView.userLable.hidden = NO;
    self.mineView.phoneLable.hidden  = NO;
    self.mineView.loginBgview.hidden = NO;

    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * uid =[user objectForKey:@"uidAndToken"][@"uid"];
    NSString * token = [user objectForKey:@"uidAndToken"][@"token"];
    NSString * tokenSerit = [NSString stringWithFormat:@"%@%@",token,uid];
    NSString * mymd5_token  = [MyMD5 md5:tokenSerit];
    [user setObject:mymd5_token forKey:@"md5_ken"];
    if ([mymd5_token length]==0||[uid length]==0) {
        mymd5_token = @"";
        uid = @"";
    }
    NSDictionary * dic = @{@"token":mymd5_token,@"uid":uid};
    [[LoginAndRegisterRequest getImagewithSucc:^(NSDictionary * succ) {
       
        
        if ([succ[@"data"][@"name"]length]==0) {
            self.mineView.phoneLable.text =[user objectForKey:@"loginPhone"];
            
        }else{
            self.mineView.phoneLable.text =succ[@"data"][@"name"];
        }
        
        
        if ([succ[@"data"][@"favjob"] length]==0) {
            self.mineView.DeliveryJobNum.text = [NSString stringWithFormat:@"(%d)",0];

        }else{
        self.mineView.DeliveryJobNum.text = [NSString stringWithFormat:@"(%@)",succ[@"data"][@"favjob"]];
        }
        
        if ([succ[@"data"][@"usejob"] length]==0) {
            self.mineView.FavoriteJobNum.text = [NSString stringWithFormat:@"(%d)",0];
        }else
        {
        self.mineView.FavoriteJobNum.text = [NSString stringWithFormat:@"(%@)",succ[@"data"][@"usejob"]];
        }if ([succ[@"data"][@"expect"]length]==0) {
            self.mineView.ResumeNum.text = [NSString stringWithFormat:@"(%d)",0];
        }else
        {
        self.mineView.ResumeNum.text = [NSString stringWithFormat:@"(%@)",succ[@"data"][@"expect"]];
        }
        if ([succ[@"data"][@"description"]length]==0) {
            self.mineView.userLable.text = @"学习是一种信仰";
        }else
        {
        self.mineView.userLable.text = succ[@"data"][@"description"];
        }
        //获取照片
        [self.mineView.headPotrait setButtonImageWithUrl:succ[@"data"][@"resume_photo"]];
        self.mineView.lginBtn.hidden = YES;
        
    } withUid:dic withFail:^(int errCode, NSError *err) {
        if (errCode ==1017) {
            self.mineView.DeliveryJobNum.text = [NSString stringWithFormat:@"(%d)",0];
            self.mineView.DeliveryJobNum.text = [NSString stringWithFormat:@"(%d)",0];
             self.mineView.FavoriteJobNum.text = [NSString stringWithFormat:@"(%d)",0];
             self.mineView.ResumeNum.text = [NSString stringWithFormat:@"(%d)",0];
            self.mineView.userLable.text = @"学习是一种信仰";
            [MBProgressHUD creatembHub:@"用户不存在"];
            
        }
           }] addNotifaction:[MBProgressHUD mbHubShow]];
}
-(void)createScro
{
    UIScrollView * sro = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT-49)];
    [self.view addSubview:sro];
    self.scro
    .backgroundColor =color(243, 243, 241);
    self.scro = sro;
    self.scro.showsVerticalScrollIndicator = NO;
}
-(void)createView
{
    MineVeiw * minVew = [MineVeiw RegisterMineView];
    
    [minVew mineViewSetButtonTag];
    minVew.mineDelegate = self;
    
    minVew.frame = CGRectMake(-WIDETH, 0, WIDETH
                              , 490);
    minVew.backgroundColor =    color(243, 243, 241);
    self.mineView = minVew;
    [self.scro addSubview:minVew];
    
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5
              initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                  minVew.frame = CGRectMake(0, 0, WIDETH, 490);
              } completion:nil];
        self.scro.contentSize = CGSizeMake(WIDETH,450+60);
    
    
    [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:0.5
          initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//              minVew.frame = CGRectMake(0, 0, WIDETH, 490);
          } completion:nil];
    self.scro.contentSize = CGSizeMake(WIDETH,450+110);

}
#pragma mark-- homeView delegate
-(void)homeView:(MineVeiw *)mineView DidClickButton:(THMineViewButtonType)button
{
    switch (button) {
        case THMineViewButtonTypeHeadPortraitBtn:
        {
            NSLog(@"编辑头像");
            NSUserDefaults * uid =[NSUserDefaults standardUserDefaults];
            //    NSString * uidStr = [uid objectForKey:@"uid"];
            //
            self.uidStr = [uid objectForKey:@"uid"];
            if (!self.uidStr) {
                [MBProgressHUD creatembHub:@"请先登录才能编辑头像"];
            }else
            {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
            [actionSheet showInView:self.tableView];
            }
            break;
        }
        case THMineViewButtonTypeEditInformationBtn:
        {   NSLog(@"编辑资料");
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            if (![userDefault objectForKey:@"uid"])
            {
                UIAlertView * alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"先登录才能编辑" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alertView.delegate = self;
                alertView.tag = 100;
                [alertView show];
                
            }else
            {
                MineEditVC * edits = [[MineEditVC alloc] init];
                [self.navigationController pushViewController:edits animated:YES];
                
            }
            break;
        }
        case THMineViewButtonTypeDeliveryJobsBtn:
        {
            NSLog(@"投递职位");
             NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            if(![userDefault objectForKey:@"uid"])
            {UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先登录才能查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                alertView.delegate  = self;
                alertView.tag  = 101;
                [alertView show];
            }else
            {
                TH_JobWishlistVC * edit = [[TH_JobWishlistVC alloc] init];
                edit.title = @"投递职位";
                edit.pushType = 0;
                [self.navigationController pushViewController:edit animated:YES];
            }
              break;
        }
        case THMineViewButtonTypeCollectionJobs:
        {
//            [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            if(![userDefault objectForKey:@"uid"])
            {

            NSLog(@"收藏职位");
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先登录才能查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                alertView.delegate = self;
                alertView.tag  = 103;
                [alertView show];
            
            }else
            {
                
                TH_JobWishlistVC * edit = [[TH_JobWishlistVC alloc] init];
                edit.title = @"收藏职位";
                edit.pushType = 1;
                [self.navigationController pushViewController:edit animated:YES];

            }
            break;
        }
        case THMineViewButtonTypeResume:
        {   NSLog(@"简历管理");
            
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            if(![userDefault objectForKey:@"uid"])
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"先登录才能查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
                alertView.delegate = self;
                alertView.tag  = 104;
                [alertView show];
            
            }else
            {
               
                ManagerResumeVC * manaVC = [[ManagerResumeVC alloc] init];
                [self.navigationController pushViewController:manaVC animated:YES];
            }
            
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
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alertView.delegate = self;
            alertView.tag = 105;
            [alertView show];
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
            
            if (![AppDelegate instance].doubleUpdateVersion>[AppDelegate instance].doubleCurrentVersion) {
//              [MBProgressHUD creatembHub:@"暂无新版本"];
            }else
            {
            VersionUpdateView * view =[[[NSBundle mainBundle] loadNibNamed:@"VersionUpdate" owner:self options:nil] lastObject];
            ;
            view.frame = CGRectMake(0, 0, 250, 151);
                [UIView animateWithDuration:0.5 animations:^{
                    view.center = self.view.center;
                }];
            
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            [self.view addSubview:view];
            [view showVersonView];
            
            view.currentBlock = ^(UIView * backView)
            {
               
                [view removeFromSuperview];
                [backView removeFromSuperview];
            } ;
            view.updataBlock = ^(UIView*view)
            { [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[AppDelegate instance].trackViewUrl]];
               
            };
            }
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -- 退出登录
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {

            TH_LoginVC * login = [[TH_LoginVC alloc] init];
            login.jobWilstRegist = @"jobWilstRegist";
                        
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    
    if (alertView.tag == 101) {
        if (buttonIndex ==1 ) {
            TH_LoginVC * login = [[TH_LoginVC alloc] init];
            login.jobWilstRegist = @"jobWilstRegist";
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    
    if (alertView.tag ==103) {
        if (buttonIndex ==1) {
            TH_LoginVC * login = [[TH_LoginVC alloc] init];
          login.jobWilstRegist = @"jobWilstRegist";
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    
    if (alertView.tag == 104) {
        if (buttonIndex == 1) {
            TH_LoginVC * login = [[TH_LoginVC alloc] init];
            login.jobWilstRegist = @"jobWilstRegist";
            [self.navigationController pushViewController:login animated:YES];

        }
    }
    if (alertView.tag == 105) {
        if (buttonIndex == 1) {
            NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
            
                        self.navigationController.navigationBarHidden = YES;
                        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                        appDelegate.mainTabBar = [[TH_MainTabBarController alloc] init];
                        [userDefault removeObjectForKey:@"uid"];
                        [userDefault synchronize];
                        appDelegate.mainTabBar.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                        [self presentViewController:appDelegate.mainTabBar animated:YES completion:nil];
        }
    }
//    if (alertView.tag == 105) {
//        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//        if (buttonIndex ==1) {
//            self.navigationController.navigationBarHidden = YES;
//            AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//            appDelegate.mainTabBar = [[TH_MainTabBarController alloc] init];
//            [userDefault removeObjectForKey:@"uid"];
//            [userDefault synchronize];
//            appDelegate.mainTabBar.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//            [self presentViewController:appDelegate.mainTabBar animated:YES completion:nil];
//        }
//
//          if (alertView.tag == 100)
//        {
//             if (buttonIndex ==1)
//             {
//            TH_LoginVC * login = [[TH_LoginVC alloc] init];
//            [self.navigationController pushViewController:login animated:YES];
//             }
//        }
//          if(alertView.tag==103)
//        { if (buttonIndex ==1)
//        {
//            TH_LoginVC * login = [[TH_LoginVC alloc] init];
//            [self.navigationController pushViewController:login animated:YES];
//        }
//
//        }
//       if (alertView.tag == 104)
//        {
//             if (buttonIndex ==1)
//             {
//            TH_LoginVC * login = [[TH_LoginVC alloc] init];
//            [self.navigationController pushViewController:login animated:YES];
//             }
//        }
//        if (alertView.tag == 101)
//        {
//            if (buttonIndex ==1)
//            {
//                TH_LoginVC * login = [[TH_LoginVC alloc] init];
//                [self.navigationController pushViewController:login animated:YES];
//            }
//        }
//
//        
//    }
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
    
    //    UINavigationController * picNav = [[UINavigationController alloc] initWithRootViewController:picVC];
    [self presentViewController:picVC animated:YES completion:nil];
    //    [self.navigationController pushViewController:picVC animated:YES];
}
#pragma mark
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, WIDETH, WIDETH) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            
        }];
    }];
}
//裁剪代理
-(void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    NSUserDefaults * uid =[NSUserDefaults standardUserDefaults];
//    NSString * uidStr = [uid objectForKey:@"uid"];
//    
    self.uidStr = [uid objectForKey:@"uid"];
    
    [[LoginAndRegisterRequest uploadImage:^(NSDictionary * dic) {
        
        [MBProgressHUD creatembHub:@"上传图片成功"];
         [self.mineView setIconImage:editedImage];
        
    } :editedImage withUid:self.uidStr] addNotifaction:[MBProgressHUD  mbHubShow]];
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
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
