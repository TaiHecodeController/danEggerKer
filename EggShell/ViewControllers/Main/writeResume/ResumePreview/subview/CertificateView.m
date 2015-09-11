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
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i
{
    if(dataArray.count == 0)
    {
        return;
    }
//    NSDictionary * dataDic = [dataArray firstObject];
    NSDictionary *dataDic = dataArray[i];
    if(dataDic.count == 0)
    {
        return;
    }
    
    self.awardTime.text = dataDic[@"sdate"];
    self.certificateName.text = dataDic[@"name"];
    if (i == 0)
    {
        _titleLab.text = @"证书";
        _titleLab.textColor =[UIColor redColor];
    }
    self.awardCompany.text = dataDic[@"title"];
    self.certificateIntroduce.text = dataDic[@"content"];
}
@end
