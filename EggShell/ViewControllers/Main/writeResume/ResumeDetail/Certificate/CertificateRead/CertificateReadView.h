//
//  CertificateReadView.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteRusumeModel2.h"
@interface CertificateReadView : UIView
@property (weak, nonatomic) IBOutlet UIButton *bixuanxiang;
@property (weak, nonatomic) IBOutlet UILabel *resumNameTitle;

@property (weak, nonatomic) IBOutlet UILabel *TrainingTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *IssuanceLable;
@property (weak, nonatomic) IBOutlet UILabel *IssuedByLable;
@property (weak, nonatomic) IBOutlet UITextView *certificContent;
-(void)configValue:(WriteRusumeModel2*)model;
+(CertificateReadView*)setCertificateReadView;
@end
