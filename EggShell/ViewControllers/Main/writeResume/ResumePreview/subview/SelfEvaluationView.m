//
//  SelfEvaluationView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "SelfEvaluationView.h"

@implementation SelfEvaluationView
+(SelfEvaluationView*)setSelfEvaluationView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"myself" owner:self options:nil] lastObject];
}
-(void)configValue:(NSDictionary *)dataDic
{
    if(dataDic.count == 0)
    {
        return;
    }
    self.selfEvaluation.text = dataDic[@""];
    
}
@end
