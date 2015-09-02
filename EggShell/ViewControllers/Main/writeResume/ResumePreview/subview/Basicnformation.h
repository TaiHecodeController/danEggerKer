//
//  Basicnformation.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Basicnformation : UIView

+(Basicnformation*)setBaseView;
@property (weak, nonatomic) IBOutlet UILabel *nameSexAge;
@property (weak, nonatomic) IBOutlet UILabel *adademic;
@property (weak, nonatomic) IBOutlet UILabel *experience;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *email;

@end
