//
//  MineEditInfoView.h
//  EggShell
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineEditInfoView : UIScrollView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *phoneNum;
@property (weak, nonatomic) IBOutlet UITextView *name;
@property (weak, nonatomic) IBOutlet UITextView *sex;
@property (weak, nonatomic) IBOutlet UITextView *city;
@property (weak, nonatomic) IBOutlet UITextView *Introduce;
@property (weak, nonatomic) IBOutlet UITextView *birthDay;
@property (weak, nonatomic) IBOutlet UITextView *email;
@property (weak, nonatomic) IBOutlet UITextView *QQNum;
@property (weak, nonatomic) IBOutlet UIImageView *LvImage;
@property (weak, nonatomic) IBOutlet UITextView *registerTime;
@end
