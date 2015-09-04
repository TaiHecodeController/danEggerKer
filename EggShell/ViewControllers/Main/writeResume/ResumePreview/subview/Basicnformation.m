//
//  Basicnformation.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "Basicnformation.h"

@implementation Basicnformation

+(Basicnformation*)setBaseView
{
return [[[NSBundle mainBundle] loadNibNamed:@
         "BasicInformation"owner:self options:nil] lastObject];
}
-(void)configVulue:(NSString * )model
{
    
    self.nameSexAge.text = model;
    self.adademic.text = model;
    self.experience.text = model;
    self.address.text = model;
    self.phoneNum.text = model;
    self.email.text = model;
}
@end