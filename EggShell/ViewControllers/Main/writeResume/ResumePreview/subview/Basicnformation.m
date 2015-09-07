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
-(void)configVulue:(NSDictionary *)dataDic
{
    if(dataDic.count == 0)
    {
        self.hidden = YES;
    }else
    {
        self.hidden = NO;
    }
    self.nameSexAge.text = [NSString stringWithFormat:@"%@ %@ %@岁",dataDic[@"uname"],dataDic[@"sex"][@"name"],dataDic[@"birthday"]];
    self.adademic.text = dataDic[@"edu"][@"name"];
    self.experience.text = dataDic[@"exp"][@"name"];
    self.address.text = dataDic[@"address"];
    self.email.text= dataDic[@"email"];
    self.phoneNum.text = dataDic[@"telphone"];
    
}
@end