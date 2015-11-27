//
//  SearchView.h
//  EggShell
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView<UITextFieldDelegate>

- (IBAction)citylistClick:(UIButton *)sender;
- (IBAction)scarchIconClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLab;
@property(strong,nonatomic)void(^searchClick)();
@end
