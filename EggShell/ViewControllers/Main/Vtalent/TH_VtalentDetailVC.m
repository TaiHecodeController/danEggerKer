//
//  TH_VtalentDetailVC.m
//  EggShell
//
//  Created by 李李贤军 on 15/11/24.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_VtalentDetailVC.h"

@interface TH_VtalentDetailVC ()
@property (assign) CGSize textSize;
@property(nonatomic,strong)UITextView * contentLable;
@property(nonatomic,strong)UIScrollView * scro;
@end

@implementation TH_VtalentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"V达人";
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    self.scro =scro;
    self.scro.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scro];
    [self createView];
}
-(void)createView
{

    UIView * titileBgView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, 131*MyWideth)];
    titileBgView.backgroundColor = [UIColor whiteColor ];
    [self.scro addSubview:titileBgView];
 //蛋壳儿精英
    UILabel * eliteLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10*MyWideth, WIDETH - 10, 16*MyWideth)];
    eliteLable.text = self.titleStr;
    eliteLable.font = [UIFont systemFontOfSize:15*MyWideth];
    eliteLable.textColor = UIColorFromRGB(0x323232);
    [titileBgView addSubview:eliteLable];
    //头像
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10*MyWideth+10*MyWideth+15*MyWideth, 135*MyWideth, 76*MyWideth)];
    [logoImageView sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"studentsphoto"]] placeholderImage:[UIImage imageNamed:@"tu"]];
    [titileBgView addSubview:logoImageView];
    //大使姓名
    UILabel * lableNameLable = [[UILabel alloc] initWithFrame:CGRectMake(10+135*MyWideth+10, 41*MyWideth, 150, 15*MyWideth)];
    lableNameLable.font = [UIFont systemFontOfSize:15*MyWideth];
//    lableNameLable.text = @"王鑫";
    lableNameLable.text = self.dataDic[@"studentsname"];
    lableNameLable.textColor = UIColorFromRGB(0x000000);
    [titileBgView addSubview:lableNameLable];
    //地址
    UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+135*MyWideth+10,  53*MyWideth+15*MyWideth,150, 12*MyWideth)];
    addressLabel.font = [UIFont systemFontOfSize:12*MyWideth];
    addressLabel.textColor = UIColorFromRGB(0x646464);
//   addressLabel.text = @"北京";
   addressLabel.text = self.dataDic[@"cityname"];
    [titileBgView addSubview:addressLabel];
    //性质
    UILabel * natureLable  = [[UILabel alloc] initWithFrame:CGRectMake(10+135*MyWideth+10, 53*MyWideth+15*MyWideth+24*MyWideth, WIDETH - (10+135*MyWideth+10),  3 * 12*MyWideth)];
    natureLable.font =[ UIFont systemFontOfSize:12*MyWideth];
    natureLable.textColor = UIColorFromRGB(0x646464);
    natureLable.numberOfLines = 0;
//    natureLable.text = @"学习是一种信仰";
    natureLable.text = self.dataDic[@"motto"];
    [titileBgView addSubview:natureLable];
    //分割线
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 131*MyWideth, WIDETH, 10*MyWideth)];
    lineView.backgroundColor = UIColorFromRGB(0xF3F3F1);
    [self.scro addSubview:lineView];
//    //足记
//    UIView *rememberBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 131*MyWideth+10*MyWideth,WIDETH, 100 )];
//    [self.view addSubview:rememberBgView];
    //精英足记
    UILabel * rememberLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 131*MyWideth+10*MyWideth+10*MyWideth, WIDETH-10, 15*MyWideth)];
    rememberLable.text = self.detailStr;
//    rememberLable.backgroundColor = [UIColor whiteColor ];
    rememberLable.font = [UIFont systemFontOfSize:15*MyWideth];
    rememberLable.textColor = UIColorFromRGB(0x323232);
    [self.scro addSubview:rememberLable];
    
    NSString * detaildicStr = self.dataDic[@"content"];
    //足迹内容
    self.textSize = [detaildicStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
    UITextView * contentLable = [[UITextView alloc] initWithFrame:CGRectMake(6, 131*MyWideth+10*MyWideth+15*MyWideth+10*MyWideth, WIDETH-12, self.textSize.height)];
    contentLable.editable = NO;
    self.contentLable = contentLable;
   NSString *htmlString = [CommonFunc textFromBase64String:detaildicStr];
    //去掉html标签
    NSString *str =  [self flattenHTML:htmlString trimWhiteSpace:YES];

//   NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    self.contentLable.attributedText = attributedString;
    self.textSize = [ [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(WIDETH - 30, 2000)];
    self.contentLable.text =  [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    self.contentLable.backgroundColor = [UIColor whiteColor];
    self.contentLable.textColor = UIColorFromRGB(0x646464);
      self.contentLable.font = [UIFont systemFontOfSize:12];
    [self.scro addSubview:self.contentLable];
    
   
    
    
    //        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //        self.contentLable.attributedText = attributedString;
    
    
    self.scro.contentSize = CGSizeMake(WIDETH, 131*MyWideth+10*MyWideth+15*MyWideth+10*MyWideth+self.textSize.height+60);

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
  }


@end
