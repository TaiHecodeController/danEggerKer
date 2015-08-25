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
@end