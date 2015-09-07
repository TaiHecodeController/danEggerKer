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
@end

@implementation TH_InformationDeskDetailVC

- (void)viewDidLoad {
    [self createSco];
    [self registerView];
    
    
    [self loadData];
    
    
}
-(void)loadData
{

    _state = [TH_AFRequestState playClassDetailRequestWithSucc:^(NSArray *dataDic) {
    
        
    } withType:self.typeNum withId:[self.classId intValue]];
              
}
-(void)createSco
{

    UIScrollView * scro =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, HEIGHT)];
    [self.view addSubview:scro];
    self.scro.showsVerticalScrollIndicator = NO;
    self.scro = scro;
}
-(void)registerView
{ infDestDetailView * detail = [[[NSBundle mainBundle] loadNibNamed:@"infDestDetailView" owner:self options:nil] lastObject];
   
    detail.frame = CGRectMake(0, 0, WIDETH, HEIGHT);
    detail.contentLable.userInteractionEnabled = NO;
    if (self.detaildic) {
        [detail setValues:self.detaildic];
    }if (self.informodel) {
        [detail setValuess:self.informodel];
    }
    
    [self.scro addSubview:detail];
    self.scro.contentSize = CGSizeMake(WIDETH, 568);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
