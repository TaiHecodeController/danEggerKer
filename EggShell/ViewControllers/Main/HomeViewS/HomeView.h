//
//  HomeView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/7.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{   THHomeViewButtonTypeInternet,
    THHomeViewButtonTypeSitePlanning,
    THHomeViewButtonTypeWebsiteEditor,
THHomeViewButtonTypeOperationsCommissioner,
    THHomeViewButtonTypeSEO,
    THHomeViewButtonTypeUIDesigner,
    THHomeViewButtonTypenice,
    
}THHomeViewButtonItType;
typedef enum
{   THHomeViewButtonTypeFinancial,
    THHomeViewButtonTypeBank,
    THHomeViewButtonTypeObligation,
    THHomeViewButtonTypeClear,
    THHomeViewButtonTypeTrader,
    THHomeViewButtonTypeAccounting,
    THHomeViewButtonTyCashier,
    
}THHomeViewButtonFcType;
typedef enum
{   THHomeViewButtonTypeAdvertising,
    THHomeViewButtonTypeClient,
    THHomeViewButtonTypeCreative,
    THHomeViewButtonTypeBusiness,
    THHomeViewButtonTypePlan,
    THHomeViewButtonTypeEstate,
    THHomeViewButtonTyMap,
    
}THHomeViewButtonAdType;
@class HomeView;
@protocol THFaousVieWDelegate <NSObject>
@optional
-(void)homeViewFindJob:(HomeView*)homeView withTag:(NSInteger)setTag;
-(void)myselfView:(HomeView*)selfView didClickInterneButton:(THHomeViewButtonItType)buttonType;
-(void)myselfView:(HomeView*)selfView didClickFinancialButton:(THHomeViewButtonFcType)buttonType;
-(void)myselfView:(HomeView*)selfView didClickAdvertisinButton:(THHomeViewButtonAdType)buttonType;

@end
@interface HomeView : UIView
/*民企推荐**/
@property (weak, nonatomic) IBOutlet UIButton *first;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *three;

@property (weak, nonatomic) IBOutlet UIButton *fourth;
@property (weak, nonatomic) IBOutlet UIButton *five;
@property (weak, nonatomic) IBOutlet UIButton *six;

/*互联网**/

@property (weak, nonatomic) IBOutlet UIButton *InternetBtn;
@property (weak, nonatomic) IBOutlet UIButton *PlanningBtn;
@property (weak, nonatomic) IBOutlet UIButton *WebsiteEditorBtn;
@property (weak, nonatomic) IBOutlet UIButton *OperationsCommissionerBtn;
@property (weak, nonatomic) IBOutlet UIButton *SEOBtn;
@property (weak, nonatomic) IBOutlet UIButton *UIDesignerBtn;
@property (weak, nonatomic) IBOutlet UIButton *niceBtn;

/*金融银行**/
@property (weak, nonatomic) IBOutlet UIButton *FinancialBtn;
@property (weak, nonatomic) IBOutlet UIButton *BankBtn;
@property (weak, nonatomic) IBOutlet UIButton *ObligatioBtn;
@property (weak, nonatomic) IBOutlet UIButton *ClearBtn;
@property (weak, nonatomic) IBOutlet UIButton *TraderBtn;

@property (weak, nonatomic) IBOutlet UIButton *AccountingBtn;
@property (weak, nonatomic) IBOutlet UIButton *CashierBtn;

/*广告媒体**/

@property (weak, nonatomic) IBOutlet UIButton *AdvertisingBtn;
@property (weak, nonatomic) IBOutlet UIButton *ClienBtn;
@property (weak, nonatomic) IBOutlet UIButton *CreativeBtn;
@property (weak, nonatomic) IBOutlet UIButton *BusinessBtn;
@property (weak, nonatomic) IBOutlet UIButton *PlanBtn;

@property (weak, nonatomic) IBOutlet UIButton *EstatBtn;
@property (weak, nonatomic) IBOutlet UIButton *MapBtn;

+(instancetype)homeViewFinJob;
-(void)setHomeViewItBtn;
-(void)setHomeViewFcBtn;
-(void)setHomeViewAdBtn;
-(void)config:(NSArray*)arr;
@property(nonatomic,strong)id<THFaousVieWDelegate>famousDelegate;

@end
