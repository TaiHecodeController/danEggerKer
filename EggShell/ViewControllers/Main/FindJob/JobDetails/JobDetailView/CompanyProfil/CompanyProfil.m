//
//  CompanyProfil.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "CompanyProfil.h"

@implementation CompanyProfil

-(void)awakeFromNib
{
    
}


- (IBAction)companyClick:(UIButton *)sender {
    if ([self.companyDelegate respondsToSelector:@selector(CompanyProfilView:)]) {
        [self.companyDelegate CompanyProfilView:self];
    }
    
}
-(void)companyProfilSelcet
{
    [self.showAll setTitle:@"点击收起" forState:UIControlStateSelected];
    [self.showAll setTitleColor:UIColorFromRGB(0xF44336) forState:UIControlStateNormal];
    
}
@end
