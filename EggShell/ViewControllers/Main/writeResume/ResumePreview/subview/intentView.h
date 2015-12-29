//
//  intentView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface intentView : UIView
@property (weak, nonatomic) IBOutlet UILabel *exceptJob;
@property (weak, nonatomic) IBOutlet UILabel *exceptIndustry;
@property (weak, nonatomic) IBOutlet UILabel *exceptSalary;
@property (weak, nonatomic) IBOutlet UILabel *workAddress;
@property (weak, nonatomic) IBOutlet UILabel *arriveTime;
@property (weak, nonatomic) IBOutlet UILabel *workState;
@property (weak, nonatomic) IBOutlet UILabel *workNature;
//编辑点击事件
@property (weak, nonatomic) IBOutlet UIButton *editBtnClick;
/*按钮点击事件**/
@property(nonatomic,strong)void(^EditClikBlock)();
+(intentView*)setIntentView;
-(void)configValue:(NSString*)model;
@end
