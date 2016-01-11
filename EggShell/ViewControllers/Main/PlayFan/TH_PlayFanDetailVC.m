//
//  TH_PlayFanDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "TH_PlayFanDetailVC.h"
#import "playDetailTitleView.h"
#import "playfanDetailView.h"
#import "shareCustomView.h"
#import "TH_LoginVC.h"
#import "UMSocialQQHandler.h"
#import "UMSocial.h"

@interface TH_PlayFanDetailVC ()<shareCustomViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSDictionary *  dataDic;
//报名按钮
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIImageView *icon3;
@property (nonatomic, strong) UILabel *lab3;
//收藏图片
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIImageView *collectIcon;
@property (nonatomic, strong) UILabel *collectLab;

@property (nonatomic, strong) NSString *userUid;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation TH_PlayFanDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"])
    {
       
        [self querData1:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"]];
    }
    else
    {
        [self querData];
    }
    
    

}

-(void)createDetail
{
    //详情
    playDetailTitleView * titileView = [[playDetailTitleView alloc]init];
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.dataDic[@"traffic_route"] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    titileView.frame = CGRectMake(0, 0, WIDETH, WIDETH/16.0*9.0+5+10+15+10*5+13*5+20+15+labelSize.height);
    [titileView configValue:self.dataDic];
    [self.view addSubview:titileView];
    playfanDetailView *playDetailView = [[playfanDetailView alloc] init];
    
    //去掉html标签
    NSString *str =  [self flattenHTML:self.dataDic[@"content"] trimWhiteSpace:YES];
    
    CGSize labelSizeDeatil = [[str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];

    playDetailView.frame = CGRectMake(0, WIDETH/16.0*9.0+5+10+15+10*5+13*5+20+15+labelSize.height, WIDETH, labelSizeDeatil.height);
    [playDetailView conFingValue:self.dataDic];
    [self.view addSubview:playDetailView];
    
}

- (void)querData1:(NSString *)uid
{
    //value为空时，程序crash
    NSDictionary * param = @{@"id":self.activityId,@"uid":uid};
    [[TH_AFRequestState activityWithSucc:^(NSDictionary *dic){
        
        self.dataDic = dic[@"data"];
        [self createDetail];
        
        [self createView];
        [self createRightView];
        
        //配置报名收藏按钮状态
        [self setSignUpBtn:dic[@"data"]];
        
        THLog(@"block里");
        
    } withd:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    
    THLog(@"block外");

}

- (void)querData
{
    NSDictionary * param = @{@"id":self.activityId};
    [[TH_AFRequestState activityWithSucc:^(NSDictionary *dic){
        
        self.dataDic = dic[@"data"];
        [self createDetail];
        
        [self createView];
        [self createRightView];
        
         THLog(@"block里");
        
    } withd:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    
     THLog(@"block外");
}

-(void)createRightView
{
    /*btn**/
    UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
    [share addTarget:self action:@selector(editdownShareClick) forControlEvents:UIControlEventTouchUpInside];
    [share setBackgroundImage:[UIImage imageNamed:@"shareImage"] forState:UIControlStateNormal];
       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:share];
}
#pragma mark --- 分享
-(void)editdownShareClick
{
    shareCustomView *shareView = [[shareCustomView alloc] init];
    shareView.delegate = self;
    [shareView showInView:self.view];
}

#pragma mark ---分享点击事件
-(void)shareButtonActionWithTag:(NSInteger)btnTag
{
    NSLog(@"点击tag%ld",(long)btnTag);
    if (btnTag == 0)
    {
        //qq分享
        [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
        [UMSocialData defaultData].extConfig.qqData.title = @"QQ分享title";
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image: [UIImage imageNamed:@"qqshare"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
        
    }
    else if(btnTag == 1)
    {
        //新浪
    }
    else if (btnTag == 2)
    {
        //Qzone
        [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
        [UMSocialData defaultData].extConfig.qzoneData.title = @"Qzone分享title";
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享文字" image:[UIImage imageNamed:@"qqshare"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }
    else if (btnTag == 3)
    {
         //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
//        //纯图片分享类型方法为
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;

//        //纯文字分享类型方法为
//        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
//
//        //应用分享类型方法
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;

        //微信
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"微信好友title";

        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://baidu.com";
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:[UIImage imageNamed:@"qqshare"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];
    }
    else if (btnTag == 4)
    {
        //朋友圈
        //纯文字分享类型方法为
        //        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
        //
        //        //应用分享类型方法
        //        //纯图片分享类型方法为
        //        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
        [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"微信朋友圈title";
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:[UIImage imageNamed:@"qqshare"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                NSLog(@"分享成功！");
            }
        }];

    }
}
-(void)createView
{
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-64-44, WIDETH, 44)];
    bottomView.backgroundColor = UIColorFromRGB(0xB9FFAE);
    [self.view addSubview:bottomView];

    //底部view
    NSArray * titileArray = @[@"收藏",@"评论",@"我要报名"];
    
    for (int i=0; i < titileArray.count ; i++)
    {
        UIButton * bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH-2)/3.0*i+1*i, 0, (WIDETH-2)/3.0, 44)];
        bottomBtn.tag = 10+i;
        bottomBtn.backgroundColor = UIColorFromRGB(0x3ebb2b);
        [bottomView addSubview:bottomBtn];
//        [bottomBtn addTarget:self action:@selector(bottomClikc:) forControlEvents:UIControlEventTouchUpInside];
        
        if (bottomBtn.tag == 12)
        {
            self.btn3 = bottomBtn;
        }
        
        if (bottomBtn.tag == 10)
        {
            self.collectBtn = bottomBtn;
        }
        
        if (i==0)
        {
            [bottomBtn addTarget:self action:@selector(bottomClikcCollect) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * collectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bottomBtn.frame.size.width/2.0-24, 11, 19, 18)];
            collectImageView.image = [UIImage imageNamed:@"collectDetail"];
            [bottomBtn addSubview:collectImageView];
            self.collectIcon = collectImageView;
            UILabel * collectLable = [[UILabel alloc] initWithFrame:CGRectMake(bottomBtn.frame.size.width/2.0+5, 13, bottomBtn.frame.size.width/2.0, 15)];
            collectLable.text = @"收藏";
            collectLable.font = [UIFont systemFontOfSize:15];
            collectLable.textColor = [UIColor whiteColor];
            [bottomBtn addSubview:collectLable];
            self.collectLab = collectLable;
            
        }
        if (i==1)
        {
            [bottomBtn addTarget:self action:@selector(bottomComment) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * commentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bottomBtn.frame.size.width/2.0-25, 12, 20, 16.5)];
            commentImageView.image = [UIImage imageNamed:@"comment"];
            [bottomBtn addSubview:commentImageView];
            UILabel * commentLable = [[UILabel alloc] initWithFrame:CGRectMake(bottomBtn.frame.size.width/2.0+5, 13, bottomBtn.frame.size.width/2.0, 15)];
            commentLable.text = @"评论";
            commentLable.font = [UIFont systemFontOfSize:15];
            commentLable.textColor = [UIColor whiteColor];
            [bottomBtn addSubview:commentLable];
            
        }
        if (i==2)
        {
            [bottomBtn addTarget:self action:@selector(bottomClikcCommit) forControlEvents:UIControlEventTouchUpInside];
            UIImageView * registerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((bottomBtn.frame.size.width-89)/2.0, 11.5, 19, 17)];
            registerImageView.image = [UIImage imageNamed:@"register"];
            [bottomBtn addSubview:registerImageView];
            self.icon3 = registerImageView;
            UILabel * registerLable = [[UILabel alloc] initWithFrame:CGRectMake((bottomBtn.frame.size.width-89)/2.0+19+10, 13, 60, 15)];
            registerLable.text = @"我要报名";
            registerLable.font = [UIFont systemFontOfSize:15];
            registerLable.textColor = [UIColor whiteColor];
            [bottomBtn addSubview:registerLable];
            self.lab3 = registerLable;
        }
        
    }
    
}

- (void)setSignUpBtn:(NSDictionary *)dic
{
    if (self.iShistory == YES)
    {
        self.btn3.backgroundColor = [UIColor grayColor];
        self.lab3.text = @"已过期";
        self.btn3.enabled = NO;
    }
    else
    {
        if ([dic[@"is_appty_count"]integerValue] == 1)
        {
            //报名
            self.btn3.backgroundColor = UIColorFromRGB(0xeb7a23);
            self.lab3.text = @"已报名";
        }
        else if ([dic[@"is_appty_count"] integerValue] == 2)
        {
            //未报名
        }

    }
    
    if ([dic[@"is_collect_count"]integerValue] == 1)
    {
        //收藏
        self.collectLab.text = @"已收藏";
        self.collectIcon.image = [UIImage imageNamed:@"collectnum"];
//        self.collectBtn.backgroundColor = UIColorFromRGB(0xeb7a23);
    }
    else if ([dic[@"is_collect_count"] integerValue] == 2)
    {
        //未收藏
        self.collectBtn.backgroundColor = UIColorFromRGB(0x3ebb2b);
        self.collectLab.text = @"收藏";
        self.collectIcon.image = [UIImage imageNamed:@"collectDetail"];
    }
    
}
#pragma mark -- 收藏
-(void)bottomClikcCollect
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if([AppDelegate instance].userId)
    {
        
        //收藏
        [[TH_AFRequestState collectRequestWithSucc:^(NSDictionary *DataDic) {
            
            if ([DataDic[@"code"] integerValue] == 0 )
            {
                [MBProgressHUD creatembHub:DataDic[@"data"]];
                
                if ([DataDic[@"data"] isEqualToString:@"收藏成功"])
                {
                    self.collectLab.text = @"已收藏";
                    self.collectIcon.image = [UIImage imageNamed:@"collectnum"];
                    self.collectBtn.backgroundColor = UIColorFromRGB(0xeb7a23);
                }
                else
                {
                    self.collectBtn.backgroundColor =  UIColorFromRGB(0x3ebb2b);
                    self.collectLab.text = @"收藏";
                    self.collectIcon.image = [UIImage imageNamed:@"collectDetail"];
                }
            }
            else
            {
                [MBProgressHUD creatembHub:@"操作失败"];
            }
            
        } resp:nil activeId:self.activityId uid:userUid token:userToken] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    }else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录才能收藏" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alertView.delegate = self;
        alertView.tag = 1000;
        [alertView show];
    }

}
#pragma mark -- 评论 
-(void)bottomComment
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
}
#pragma mark -- 我要报名
-(void)bottomClikcCommit
{NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    
    [AppDelegate instance].userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if([AppDelegate instance].userId)
    {
        
        //报名
        [[TH_AFRequestState signUpRequestWithSucc:^(NSDictionary *DataDic) {
            
            THLog(@"%@",DataDic);
            
            if ([DataDic[@"code"] integerValue] == 0 )
            {
                [MBProgressHUD creatembHub:DataDic[@"data"]];
                
                if ([DataDic[@"data"] isEqualToString:@"报名成功"])
                {
                    self.btn3.backgroundColor = UIColorFromRGB(0xeb7a23);
                    self.lab3.text = @"已报名";
                }
                else
                {
                    self.btn3.backgroundColor = UIColorFromRGB(0x3ebb2b);
                    self.lab3.text = @"我要报名";
                }
            }
            else
            {
                [MBProgressHUD creatembHub:@"操作失败"];
            }
        } resp:nil activeId:self.activityId uid:userUid token:userToken] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
    }else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先登录才能报名" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        alertView.delegate = self;
        alertView.tag = 1001;
        [alertView show];
    }


}
#pragma mark -- alertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        //收藏
        if (alertView.tag == 1000) {
            if(buttonIndex == 1)
            {        TH_LoginVC * lvcs = [[TH_LoginVC alloc] init];
                lvcs.findJobDetailApplication = @"findJobDetailApplication";
                lvcs.loginBlock = ^()
                {
                                  [self bottomClikcCollect];
                };
                [self.navigationController pushViewController:lvcs animated:YES];
                
            }
        }
        //报名
        if (alertView.tag == 1001) {
            if(buttonIndex == 1)
            {        TH_LoginVC * lvcs = [[TH_LoginVC alloc] init];
                lvcs.findJobDetailApplication = @"findJobDetailApplication";
                lvcs.loginBlock = ^()
                {
                                   [self bottomClikcCommit];
                };
                [self.navigationController pushViewController:lvcs animated:YES];
                
            }
        }
        
    }
    
-(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}



@end
