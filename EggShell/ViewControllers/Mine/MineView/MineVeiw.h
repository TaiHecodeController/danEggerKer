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


+(MineVeiw*)RegisterMineView;
-(void)mineViewSetButtonTag;
- (void)setIconImage:(UIImage *)image;

@property(nonatomic,strong)id<THMineViewDelegate> mineDelegate;
@end
