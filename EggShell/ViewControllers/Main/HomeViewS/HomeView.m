//
//  HomeView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/7.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "HomeView.h"
@interface HomeView()

@end
@implementation HomeView
+(instancetype)homeViewFinJob
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeViews" owner:self options:nil] lastObject];

}
-(void)setHomeViewItBtn
{

    self.InternetBtn.tag = THHomeViewButtonTypeInternet;
    self.PlanningBtn.tag = THHomeViewButtonTypeSitePlanning;
    self.WebsiteEditorBtn.tag = THHomeViewButtonTypeWebsiteEditor;
    self.OperationsCommissionerBtn.tag =THHomeViewButtonTypeOperationsCommissioner;
    self.SEOBtn
    .tag = THHomeViewButtonTypeSEO;
    self.UIDesignerBtn.tag = THHomeViewButtonTypeUIDesigner;
    self.niceBtn.tag = THHomeViewButtonTypenice;

}
-(void)setHomeViewFcBtn
{
//    THHomeViewButtonTypeFinancial,
//    THHomeViewButtonTypeBank,
//    THHomeViewButtonTypeObligation,
//    THHomeViewButtonTypeClear,
//    THHomeViewButtonTypeTrader,
//    THHomeViewButtonTypeAccounting,
//    THHomeViewButtonTyCashier,
    self.FinancialBtn.tag = THHomeViewButtonTypeFinancial;
    self.BankBtn.tag = THHomeViewButtonTypeBank;
    self.ObligatioBtn.tag = THHomeViewButtonTypeObligation;
    self.ClearBtn.tag = THHomeViewButtonTypeClear;
    self.TraderBtn.tag = THHomeViewButtonTypeTrader;
    self.AccountingBtn.tag = THHomeViewButtonTypeAccounting;
    self.CashierBtn.tag = THHomeViewButtonTyCashier;
    
    
}
-(void)setHomeViewAdBtn
{
//    THHomeViewButtonTypeAdvertising,
//    THHomeViewButtonTypeClient,
//    THHomeViewButtonTypeCreative,
//    THHomeViewButtonTypeBusiness,
//    THHomeViewButtonTypePlan,
//    THHomeViewButtonTypeEstate,
//    THHomeViewButtonTyMap,
    self.AdvertisingBtn.tag = THHomeViewButtonTypeAdvertising;
    self.ClienBtn.tag = THHomeViewButtonTypeClient;
    self.CreativeBtn.tag = THHomeViewButtonTypeCreative;
    self.BusinessBtn.tag = THHomeViewButtonTypeBusiness;
    self.PlanBtn.tag = THHomeViewButtonTypePlan;
    self
    .EstatBtn.tag = THHomeViewButtonTypeEstate;
    self.MapBtn.tag = THHomeViewButtonTyMap;
    
    
}
#pragma mark - - 企业
- (IBAction)btnClick:(UIButton *)sender {
    [self.famousDelegate homeViewFindJob:self];
}
#pragma mark -- 互联网

- (IBAction)InternetBtnClick:(UIButton *)sender {
    
    if ([self.famousDelegate respondsToSelector:@selector(myselfView:didClickInterneButton:)]) {
        [self.famousDelegate myselfView:self didClickInterneButton:(THHomeViewButtonItType)sender.tag];
    }
}

#pragma mark -- 金融

- (IBAction)FinancialBtnClick:(UIButton *)sender {
    if ([self.famousDelegate respondsToSelector:@selector(myselfView:didClickFinancialButton:)]) {
        [self.famousDelegate myselfView:self didClickFinancialButton:(THHomeViewButtonFcType)sender.tag];
    }
}

#pragma mark -- 广告

- (IBAction)AdvertisingBtnClick:(UIButton *)sender {
    if ([self.famousDelegate respondsToSelector:@selector(myselfView:didClickAdvertisinButton:)]) {
        [self.famousDelegate myselfView:self didClickAdvertisinButton:(THHomeViewButtonAdType)sender.tag];
    }
}

@end