//
//  intentView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "intentView.h"

@implementation intentView

+(intentView*)setIntentView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"intentView" owner:self options:nil] lastObject];
}
-(void)configValue:(NSDictionary*)dataDic
{
    self.exceptJob.text = dataDic[@"job"][@"name"];
    self.exceptIndustry.text = dataDic[@"hy"][@"name"];
    self.exceptSalary.text = dataDic[@"salary"][@"name"];
    self.workAddress.text = dataDic[@"area"][@"name"];
    self.arriveTime.text = dataDic[@"dgtime"][@"name"];
    self.workNature.text = dataDic[@"ctype"][@"name"];
    self.workState.text = dataDic[@"jobst"][@"name"];
}
@end
