//
//  CertificateView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CertificateView.h"

@implementation CertificateView

+(CertificateView*)setCertificateView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"Certificate" owner:self  options:nil]lastObject];
}
@end