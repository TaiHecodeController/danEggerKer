//
//  CertificateView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateView : UIView
@property (weak, nonatomic) IBOutlet UILabel *awardTime;
@property (weak, nonatomic) IBOutlet UILabel *certificateName;
@property (weak, nonatomic) IBOutlet UILabel *awardCompany;
@property (weak, nonatomic) IBOutlet UITextView *certificateIntroduce;

+(CertificateView*)setCertificateView;
-(void)configValue:(NSString*)model;
@end
