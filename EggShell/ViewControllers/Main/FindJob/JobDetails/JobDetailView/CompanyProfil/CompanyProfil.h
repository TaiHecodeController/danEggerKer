//
//  CompanyProfil.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/10.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyProfil;
@protocol comanyProFileDelegate <NSObject>

-(void)CompanyProfilView :(CompanyProfil*)companyView;

@end

@interface CompanyProfil : UIView
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property(nonatomic,strong)id<comanyProFileDelegate>companyDelegate;
@property (weak, nonatomic) IBOutlet UIButton *showAll;

-(void)companyProfilSelcet;
@end
