//
//  CertificateReadView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CertificateReadView.h"

@implementation CertificateReadView

+(CertificateReadView*)setCertificateReadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"CertificateRead" owner:self options:nil] lastObject];
}
-(void)configValue:(WriteRusumeModel2 *)model
{
    self.TrainingTitleLable.text = model.name;
    self.IssuanceLable.text = model.sdate;
    self.IssuedByLable.text = model.position;
    self.certificContent.text = model.content;
}
@end
