//
//  CertificateCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateCell : UITableViewCell
@property(nonatomic,strong)UILabel * awardTime;
@property(nonatomic,strong)UILabel * certificateName;
@property(nonatomic,strong)UILabel * awardCompany;
@property(nonatomic,strong)UILabel * certificateIntroduce;
-(void)configValue:(NSArray *)dataArray withArrIndex:(int)i;
@end
