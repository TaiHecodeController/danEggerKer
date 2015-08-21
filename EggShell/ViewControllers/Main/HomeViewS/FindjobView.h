//
//  FindjobView.h
//  maishipei
//
//  Created by 李李贤军 on 15/8/12.
//  Copyright (c) 2015年 XH. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{   THHomeViewButtonTypeFindJob,
    THHomeViewButtonTypeFindPartTime,
    THHomeViewButtonTypeInternshipSearch,
    THHomeViewButtonTypeInformationDesk,
    THHomeViewButtonTypeResumeWriting,
    THHomeViewButtonTypePlayFan,
    THHomeViewButtonTypeMicroSocial,
    THHomeViewButtonTypeOpenClass,
}THHomeViewButtonType;
@class FindjobView;
@protocol THHomeVieWDelegate <NSObject>
@optional
-(void)findViewFindJob:(FindjobView*)homeView DidClickButton:(THHomeViewButtonType)button;
@end
@interface FindjobView : UIView
{

}

@property(nonatomic,strong)UIButton * findjobBtn;
@property(nonatomic,strong)UILabel * findjobLable;
@property(nonatomic,strong)id<THHomeVieWDelegate>homeViewDelegate;
@property(nonatomic,strong)UIButton  * FindPartTimeBtn;
@property(nonatomic,strong)UILabel * FindPartTimeLable;


@property(nonatomic,strong)UIButton * InternshipSearchBtn;
@property(nonatomic,strong)UILabel * InternshipSearchLable;

@property(nonatomic,strong)UIButton * InformationDeskBtn;
@property(nonatomic,strong)UILabel * InformationDeskLable;

@property(nonatomic,strong)UIButton * fesumeWritingBtn;
@property(nonatomic,strong)UILabel * fesumeWritingLable;

@property(nonatomic,strong)UIButton * PlayFanBtn;
@property(nonatomic,strong)UILabel * PlayFanLable;

@property(nonatomic,strong)UIButton  * MicroSocialBtn;
@property(nonatomic,strong)UILabel * MicroSocialLable;

@property(nonatomic,strong)UIButton * openClassBtn;
@property(nonatomic,strong)UILabel * openClassLable;

@end
