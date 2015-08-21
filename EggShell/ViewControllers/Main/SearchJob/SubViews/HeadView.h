//
//  HeadView.h
//  EggShell
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
//block回调的方式传递事件
@interface HeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UIButton *selectOtherCity;
- (IBAction)selectCityCilck:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *seachText;
- (IBAction)searchClick:(UIButton *)sender;
@property (strong,nonatomic)void(^searchClick)(NSString *);
@end
