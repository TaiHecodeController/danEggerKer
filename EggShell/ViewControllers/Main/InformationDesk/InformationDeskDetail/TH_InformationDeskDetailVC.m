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
@property(nonatomic,strong)UILabel * contentLable;
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
    
    
//    [self loadData];
    
    
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
{ infDestDetailView * detail = [[[NSBundle mainBundle] loadNibNamed:@"infDestDetailView" owner:self options:nil] lastObject];
   
    detail.frame = CGRectMake(0, 0, WIDETH, 340);
    detail.RouteLable.editable = NO;
    detail.RouteLable.showsVerticalScrollIndicator = NO;

    [self.scro addSubview:detail];
    if (self.detaildic) {
        [detail setValues:self.detaildic];
        
         self.textSize = [self.detaildic.content sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
        UILabel * contentLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 340, WIDETH-30, self.textSize.height)];
//        contentLable.text =self.detaildic.content;
        NSAttributedString *comAttributedString = [[NSAttributedString alloc] initWithData:[self.detaildic.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        contentLable.attributedText = comAttributedString;
        

        self.contentLable = contentLable;
        self.contentLable.numberOfLines = 0;
        self.contentLable.textColor = UIColorFromRGB(0x646464);
        self.contentLable.font = [UIFont systemFontOfSize:13];
        [self.scro addSubview:contentLable];
        
        
    }if (self.informodel) {
        [detail setValuess:self.informodel];
        
         self.textSize = [self.informodel.body sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
        UILabel * contentLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 340, WIDETH-30, self.textSize.height)];
        self.contentLable = contentLable;
        [self.scro addSubview:contentLable];
        self.contentLable.numberOfLines = 0;
         self.contentLable.textColor = UIColorFromRGB(0x646464);
        self.contentLable.font = [UIFont systemFontOfSize:13];
//        contentLable.text =self.informodel.body;
        NSAttributedString *comAttributedString = [[NSAttributedString alloc] initWithData:[self.informodel.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        contentLable.attributedText = comAttributedString;

        
        

    }
    
    
  self.scro.contentSize = CGSizeMake(WIDETH, 350+self.textSize.height+30);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
