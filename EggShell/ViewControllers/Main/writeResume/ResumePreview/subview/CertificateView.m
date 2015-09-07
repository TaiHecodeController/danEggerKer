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
-(void)configValue:(NSArray *)dataArray
{
    if(dataArray.count == 0)
    {
        return;
    }
    NSDictionary * dataDic = [dataArray firstObject];
    if(dataDic.count == 0)
    {
        return;
    }
    self.awardTime.text = dataDic[@"sdate"];
    self.certificateName.text = dataDic[@"name"];
    self.awardCompany.text = dataDic[@"title"];
    self.certificateIntroduce.text = dataDic[@"content"];
}
@end
