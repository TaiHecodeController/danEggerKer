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
@interface TH_PlayFanDetailVC ()<shareCustomViewDelegate>
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
        
    } withd:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];

}

- (void)querData
{
    NSDictionary * param = @{@"id":self.activityId};
    [[TH_AFRequestState activityWithSucc:^(NSDictionary *dic){
        
        self.dataDic = dic[@"data"];
        [self createDetail];
        
        [self createView];
        [self createRightView];
        
    } withd:param] addNotifaction:[MBProgressHUD mbHubShowMBProgressHubView:self]];
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
    NSLog(@"点击tag%ld",btnTag);
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
        [bottomBtn addTarget:self action:@selector(bottomClikc:) forControlEvents:UIControlEventTouchUpInside];
        
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
        self.collectBtn.backgroundColor = UIColorFromRGB(0xeb7a23);
    }
    else if ([dic[@"is_collect_count"] integerValue] == 2)
    {
        //未收藏
        self.collectBtn.backgroundColor = UIColorFromRGB(0x3ebb2b);
        self.collectLab.text = @"收藏";
        self.collectIcon.image = [UIImage imageNamed:@"collectDetail"];
    }
    
}

#pragma mark -- 收藏 评论 我要报名
- (void)bottomClikc:(UIButton*)sender
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    NSString *userToken = [df objectForKey:@"md5_token"];
    NSString * userUid = [df objectForKey:@"uid"];
    
    if (sender.tag ==10)
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
    }
    if (sender.tag==11)
    {
        NSLog(@"评论");
    }
    if (sender.tag==12)
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
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
