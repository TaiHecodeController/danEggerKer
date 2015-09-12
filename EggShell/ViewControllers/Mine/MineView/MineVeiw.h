//
//  MineVeiw.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{   THMineViewButtonTypeHeadPortraitBtn,
    THMineViewButtonTypeEditInformationBtn,
    THMineViewButtonTypeDeliveryJobsBtn,
    THMineViewButtonTypeCollectionJobs,
    THMineViewButtonTypeResume,
    THMineViewButtonTypeChannelsCooperation,
    THMineViewButtonTypeAboutEggshellBtn,
    THMineViewButtonTypesignOut,
    THMineViewButtonTypeLogin,
    THMineViewButtonTypeFeedback,
    THMineViewButtonTypeversion,
        
}THMineViewButtonType;

@class MineVeiw;
@protocol THMineViewDelegate <NSObject>
-(void)homeView:(MineVeiw*)mineView DidClickButton:(THMineViewButtonType)button;

@end
@interface MineVeiw : UIView

@property (weak, nonatomic) IBOutlet UIView *loginBgview;
@property (weak, nonatomic) IBOutlet UIButton *lginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userLable;
@property (weak, nonatomic) IBOutlet UIButton *headPotrait;
@property (weak, nonatomic) IBOutlet UILabel *DeliveryJobNum;
@property (weak, nonatomic) IBOutlet UILabel *FavoriteJobNum;
@property (weak, nonatomic) IBOutlet UILabel *ResumeNum;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;

+(MineVeiw*)RegisterMineView;
-(void)mineViewSetButtonTag;
- (void)setIconImage:(UIImage *)image;

@property(nonatomic,assign)id<THMineViewDelegate> mineDelegate;
@end
