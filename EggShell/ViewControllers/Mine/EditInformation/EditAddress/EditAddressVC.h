//
//  EditAddressVC.h
//  EggShell
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *province;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (weak, nonatomic) IBOutlet UIButton *replace;
- (IBAction)provinceClick:(UIButton *)sender;
- (IBAction)cityClick:(UIButton *)sender;

- (IBAction)finishClick:(UIButton *)sender;
- (IBAction)replaceClick:(UIButton *)sender;

@end
