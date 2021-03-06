//
//  TH_CertificateVC.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TH_BaseVC.h"

@interface TH_CertificateVC : TH_BaseVC

@property (nonatomic, copy) NSString *cerName;
@property (nonatomic, copy) NSString *awardTime;
@property (nonatomic, copy) NSString *awardCompany;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *detailId;
@property (nonatomic, copy) NSString *resumeId;
//pushType 0添加进来 1编辑进来
@property (nonatomic, assign) int pushtype;

@end
