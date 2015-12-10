//
//  HotJobView.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/9.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{   HotJobViewButtonTypeeducationTrainBtn,
    HotJobViewButtonTypemarketingSpecialistBtn,
    HotJobViewButtonTypeonsultingSaleBtn,
    HotJobViewButtonTypetrainTeacherBtn,
    HotJobViewButtonTypeteachManagerBtn,
    HotJobViewButtonTypeteachqualitBtn,
    HotJobViewButtonTypeemploymentCommissionerBtn,
    HotJobViewButtonTypeComplexBtn,
    HotJobViewButtonTypesitePlanBtn,
    HotJobViewButtonTypewebsiteEditorBtn,
    HotJobViewButtonTypeoperationsCommissionerBtn,
    HotJobViewButtonTypebankTellerBtn,
    HotJobViewButtonTypeaccountingBtn,
    HotJobViewButtonTypetellerBtn,
    
}HotJobViewButtonType;
@class HotJobView;
@protocol HotJobViewDelegate <NSObject>
@optional
-(void)HotJobViewJob:(HotJobView*)HotJobView DidClickButton:(HotJobViewButtonType)button;
@end
@interface HotJobView : UIView
@property(nonatomic,assign)id<HotJobViewDelegate>HotJobViewDelegate;
//教育培训
@property(nonatomic,strong)  UIButton * educationTrainBtn;
//市场专员
@property(nonatomic,strong)  UIButton * marketingSpecialistBtn;
//咨询销售
@property(nonatomic,strong)  UIButton * onsultingSaleBtn;
//培训讲师
@property(nonatomic,strong)  UIButton * trainTeacherBtn;
//教学管理
@property(nonatomic,strong)  UIButton * teachManagerBtn;
//教质管理
@property(nonatomic,strong)  UIButton  *  teachqualitBtn;
//就业专员
@property(nonatomic,strong)  UIButton * employmentCommissionerBtn;
//综合类
@property(nonatomic,strong)  UIButton * ComplexBtn;
//网站策划
@property(nonatomic,strong)  UIButton * sitePlanBtn;
//网站编辑
@property(nonatomic,strong)  UIButton * websiteEditorBtn;
//运营专员
@property(nonatomic,strong)  UIButton * operationsCommissionerBtn;
//银行柜员
@property(nonatomic,strong)  UIButton * bankTellerBtn;
//会计
@property(nonatomic,strong)  UIButton *accountingBtn;
//出那员
@property(nonatomic,strong)  UIButton *tellerBtn;
-(void)setBtnTag;
@end
