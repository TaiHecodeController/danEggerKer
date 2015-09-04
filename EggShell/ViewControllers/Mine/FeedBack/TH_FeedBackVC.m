//
//  TH_FeedBackVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/17.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_FeedBackVC.h"
#import "AFAppRequest.h"
@interface TH_FeedBackVC ()<UITextViewDelegate>
@property(nonatomic,strong)UIScrollView * scro;
@property(nonatomic,strong)UILabel * placeHoderLable;
@property(nonatomic,strong)UITextField * textqqField;
@property(nonatomic,strong)UITextField * emailTextFiled ;
@property(nonatomic,strong)UIView * titleView;
@property(nonatomic,strong)UILabel * ContactTextLable;
@property(nonatomic,strong)UIView *bgqqView;
@property(nonatomic,strong)UIView *emailBgview;
@property(nonatomic,strong)UIButton * subMitBtn;
@property(nonatomic,strong)UITextView * textView;
@end

@implementation TH_FeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xF3F3F1);
    
    UIScrollView * sco =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:sco];
    self.scro = sco;
    [self createTextView];
    /*隐藏键盘**/
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    /*显示键盘**/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    
    //    /*收回键盘**/
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    
    [self LodDatarequest];
}
-(void)LodDatarequest
{
    
    
    
    
    
}

-(void)createTextView{
    
    
    UIView * titleView =[[UIView alloc] initWithFrame:CGRectMake(30, 30, WIDETH-60, 160)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.cornerRadius = 3;
    titleView.layer.masksToBounds = YES;
    titleView.layer.borderWidth = 0.5;
    titleView.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    [self.scro addSubview:titleView];
    self.titleView = titleView;
    UITextView * textView =[[UITextView alloc] initWithFrame:CGRectMake(5, 5, titleView.width-10, 150)];
    //    textView.text = @"请留下你的宝贵意见，我们会尽快处理...";
    textView.font =[UIFont systemFontOfSize:12];
    textView.delegate = self;
    textView.textColor  = [UIColor blackColor];
    //    UIColorFromRGB(0xC8C8C8);
    self.textView = textView;
    [titleView addSubview:textView];
    
    UILabel * placeHoderLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, textView.width, 12)];
    placeHoderLable.text = @"请留下你的宝贵意见，我们会尽快处理...";
    placeHoderLable.textColor = UIColorFromRGB(0xC8C8C8);
    placeHoderLable.font = [UIFont systemFontOfSize:12];
    self.placeHoderLable = placeHoderLable;
    [textView addSubview:placeHoderLable];
    /*留下联系方式**/
    UILabel * ContactTextLable = [[UILabel alloc]
                                  initWithFrame:CGRectMake(30, 215, WIDETH-60, 12)];
    ContactTextLable.text = @"留下你的联络方式，方便我们与你取得联系";
    ContactTextLable.textColor = UIColorFromRGB(0x323232);
    ContactTextLable.font =[UIFont systemFontOfSize:12];
    self.ContactTextLable = ContactTextLable;
    [self.scro addSubview:ContactTextLable];
    /*可选项**/
    UIButton * optionalBtn = [[UIButton alloc] initWithFrame:CGRectMake(263, 211, 40, 20)];
    [optionalBtn setBackgroundImage:[UIImage imageNamed:@"lanniu2"] forState:UIControlStateNormal];
    [optionalBtn setTitle:@"可选项" forState:UIControlStateNormal];
    [optionalBtn setTitleColor:[UIColor whiteColor
                                ] forState:UIControlStateNormal];
    optionalBtn.titleLabel.font =[UIFont systemFontOfSize:10];
    [self.scro addSubview:optionalBtn];
    
    /*qq号码**/
    UIView *bgqqView =[[UITextField alloc] initWithFrame:CGRectMake(30, 245, WIDETH-60, 35)];
    bgqqView.backgroundColor =[UIColor whiteColor];
    bgqqView.layer.borderWidth = 0.5;
    bgqqView.layer.cornerRadius = 3;
    bgqqView.layer.masksToBounds = YES;
    bgqqView.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    self.bgqqView = bgqqView;
    [self.scro addSubview:bgqqView];
    
    UITextField * textqqField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, WIDETH-70, 35)];
    textqqField.placeholder = @"QQ号码";
    textqqField.textColor = UIColorFromRGB(0xC8C8C8);
    textqqField.font = [UIFont systemFontOfSize:12];
    textqqField.textColor = [UIColor blackColor];
    textqqField.keyboardType = UIKeyboardTypeNumberPad;
    self.textqqField = textqqField;
    [bgqqView addSubview:textqqField];
    
    /*邮箱**/
    UIView *emailBgview = [[UIView alloc] initWithFrame:CGRectMake(30, 290, WIDETH-60, 35)];
    emailBgview.backgroundColor =[UIColor whiteColor];
    emailBgview.layer.cornerRadius = 3;
    emailBgview.layer.masksToBounds = YES;
    emailBgview.layer.borderColor = bgqqView.layer.borderColor = UIColorFromRGB(0xDDDDDD).CGColor;
    emailBgview.layer.borderWidth = 0.5;
    self.emailBgview = emailBgview;
    [self.scro addSubview:emailBgview];
    UITextField * emailTextFiled =[[UITextField alloc] initWithFrame:CGRectMake(10, 0, WIDETH-70, 35)];
    emailTextFiled.placeholder = @"邮箱地址";
    emailTextFiled.font =[UIFont systemFontOfSize:12];
    emailTextFiled.textColor = UIColorFromRGB(0xC8C8C8);
    emailTextFiled.textColor = [UIColor blackColor];
    self.emailTextFiled = emailTextFiled;
    [emailBgview addSubview:emailTextFiled];
    /*提交**/
    UIButton * subMitBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDETH-150)/2.0, 340, 150, 30)];
    [subMitBtn setBackgroundImage:[UIImage imageNamed:@"lanniu2"] forState:UIControlStateNormal];
    [subMitBtn setTitle:@"提交" forState:UIControlStateNormal];
    subMitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [subMitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [subMitBtn addTarget:self action:@selector(subClick) forControlEvents:UIControlEventTouchUpInside];
    self.subMitBtn = subMitBtn;
    [self.scro addSubview:subMitBtn];
    
}
-(void)subClick
{
    NSUserDefaults * userID= [NSUserDefaults standardUserDefaults];
    NSString * userId =  [userID objectForKey:@"uid"];
    
    NSString * textView       = [self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString  * qqtext ;
    NSString  *emailText ;
    if ([self.textqqField.text length] ==0) {
        qqtext = @"";
    }
    else
    {
        qqtext        = self.textqqField.text;
        
    }
    if([self.emailTextFiled.text length]== 0) {
        emailText = @"";
    }else
    {
        emailText =self.emailTextFiled.text;
    }
    
    NSDictionary * contentDic = @{@"opinion":textView, @"qq":qqtext,@"email":emailText};
    [TH_AFRequestState feedbackReRequestWithSucc:^(NSArray *DataDic) {
        
    } withUserId:userId withContent:contentDic withfail:^(int errCode, NSError *err) {
        
    }];
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap
{
    [self.view endEditing:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [self.placeHoderLable removeFromSuperview];
}

-(void)showKeyBoard:(NSNotification*)notification
{
    
    /*获取键盘的高度**/
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%d",height);
    self.scro.contentSize = CGSizeMake(WIDETH, 450+height);
    [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT+height) animated:YES];
    
    
    
    
}
-(void)hideKeyBoard:(NSNotification*)notification
{
    self.scro.contentSize = CGSizeMake(WIDETH, 450);
    [self.scro scrollRectToVisible:CGRectMake(0, 0, WIDETH, HEIGHT) animated:YES];
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
