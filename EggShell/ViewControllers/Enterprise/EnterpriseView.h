//
//  EnterpriseView.h
//  EggShell
//
//  Created by 李李贤军 on 15/11/23.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    THEnterpriseTypeReceiveResumeLable,
    THEnterpriseTypeTalentPoolBtn,
    THEnterpriseTypeAllPositionBtn,
    THEnterpriseTypeRecruitmentPositionBtn,
    THEnterpriseTypeOutDatePosionBtn
   
}THEnterpriseType;

@class EnterpriseView;
@protocol THEnterprisedDelegate <NSObject>
-(void)enterprise:(EnterpriseView*)Enterprise DidClickButton:(THEnterpriseType)buttonType;
@end
@interface EnterpriseView : UIView
@property (weak, nonatomic) IBOutlet UIButton *ExitSignBtn;
@property (weak, nonatomic) IBOutlet UIButton *ReceiveResumeLable;
@property (weak, nonatomic) IBOutlet UIButton *talentPoolBtn;
@property (weak, nonatomic) IBOutlet UIButton *allPositionBtn;
@property (weak, nonatomic) IBOutlet UIButton *recruitmentPositionBtn;
@property (weak, nonatomic) IBOutlet UIButton *outDatePosionBtn;

@property(nonatomic,weak)id <THEnterprisedDelegate>enterDelegate;
+(EnterpriseView*)setEnterpriseView;
-(void)setEnterpriseValue;

@end
