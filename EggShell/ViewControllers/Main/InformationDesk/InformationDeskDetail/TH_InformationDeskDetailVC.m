//
//  TH_InformationDeskDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_InformationDeskDetailVC.h"
#import "infDestDetailView.h"
#import "playFanModel.h"
#import "AFAppRequest.h"
@interface TH_InformationDeskDetailVC ()
@property(nonatomic,strong)UIScrollView * scro;
@property (nonatomic,strong)AFRequestState * state;
@property (assign) CGSize textSize;
@property(nonatomic,strong)UITextView * contentLable;
@end

@implementation TH_InformationDeskDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"informationdeskdetail"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"informationdeskdetail"];
}

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSco];
    [self registerView];
    
    UIButton *btn = [UIButton new];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor darkGrayColor];
//    [self.view addSubview:btn];
    
//    [self loadData];
    
}

- (void)btnClick
{
    [self.navigationController popToViewController:self.navigationController.topViewController animated:YES];
    
}
-(void)loadData
{

    _state = [TH_AFRequestState playClassDetailRequestWithSucc:^(NSArray *dataDic) {
    
        
    } withType:self.typeNum withId:[self.classId intValue]];
              
}
-(void)createSco
{

    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro = scro;
    self.scro.backgroundColor = [UIColor whiteColor];
    self.scro.showsVerticalScrollIndicator = NO;

    [self.view addSubview:scro];
      }
-(void)registerView
{
    infDestDetailView * detail = [[[NSBundle mainBundle] loadNibNamed:@"infDestDetailView" owner:self options:nil] lastObject];
   
    detail.frame = CGRectMake(0, 0, WIDETH, 340);
    detail.RouteLable.editable = NO;
    detail.RouteLable.showsVerticalScrollIndicator = NO;

    [self.scro addSubview:detail];
    if (self.detaildic) {
        [detail setValues:self.detaildic];
//        
//         self.textSize = [self.detaildic.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
//        UILabel * contentLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 340, WIDETH-30, self.textSize.height)];
//        contentLable.backgroundColor = [UIColor whiteColor];
////        contentLable.text =self.detaildic.content;
//        NSAttributedString *comAttributedString = [[NSAttributedString alloc] initWithData:[self.detaildic.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        contentLable.attributedText = comAttributedString;
//        self.contentLable = contentLable;
//        self.contentLable.numberOfLines = 0;
//        self.contentLable.textColor = UIColorFromRGB(0x646464);
//        self.contentLable.font = [UIFont systemFontOfSize:13];
//        [self.scro addSubview:contentLable];
//        
       
        //足迹内容
        self.textSize = [self.detaildic.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
        UITextView * contentLable = [[UITextView alloc] initWithFrame:CGRectMake(15, 340, WIDETH-30, self.textSize.height)];
        contentLable.editable = NO;
        self.contentLable = contentLable;
        
//        NSString *htmlString = self.detaildic.content;
        //去掉html标签
        NSString *str =  [self flattenHTML:self.detaildic.content trimWhiteSpace:YES];
       
        self.textSize = [[str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
//        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//        self.contentLable.attributedText = attributedString;
        self.contentLable.text =  [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        self.contentLable.textColor = UIColorFromRGB(0x646464);
        self.contentLable.font = [UIFont systemFontOfSize:13];
        [self.scro addSubview:self.contentLable];
  }

    self.scro.contentSize = CGSizeMake(WIDETH, 410 + self.textSize.height);
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)te
{
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">【活动意义】&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">遇到心动的他（她）不知道如何搭讪？&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">跟TA聊天却只碰到嗯，呵呵，去洗澡？&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">约会时双方各玩各的手机，谁都不知道开口说什么？&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">表白之后却被告知你是个好人，但是我们不合适？&nbsp;</span><br />
//    <br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">每个在恋爱路上的男孩纸都会碰到这些问题，问题的根本原因就在于&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">父母没有教会你如何恋爱，因为父母那一辈的人很多都是包办婚姻，&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">学校没有教会你如何恋爱，因为老师希望你好好学习不要早恋。&nbsp;</span><br />
//    <br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">所以，任何事情都是需要去学习的，以前落下来的课还是要补上的，这就是我们开办这场恋爱艺术交友沙龙的原因。&nbsp;</span><br />
//    <br />
//    <br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">【活动内容】&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">1，男女思维差异，如何站在女性角度思考问题&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">2，突破自己内心的恐惧，勇敢追求心爱的异性&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">3，你的形象值千金，如何包装成对方喜欢的风格&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">4，恋爱过程中遇到的种种问题如何解决&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">5，我们将以游戏的聊天的方式带入，希望能有所学习&nbsp;</span><br />
//    <br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">【活动对象】&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">1，资深宅男、宅女&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">2，失恋患者&nbsp;</span><br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">3，已经有心动女生不知道如何追求的朋友&nbsp;</span><br />
//    <br />
//    <br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">参加流程：&nbsp;</span><br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">1、关注微信公众号：飘零人生浮世绘&nbsp;</span><br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">2、通过公众号信息，得到口令&nbsp;</span><br />
//    <span style="color:#111111;font-family:Helvetica, Arial, sans-serif;line-height:15.552px;background-color:#FFFFFF;">3、回复口令并添加微信：chenxx001321，获悉具体活动时间</span>

}



@end
