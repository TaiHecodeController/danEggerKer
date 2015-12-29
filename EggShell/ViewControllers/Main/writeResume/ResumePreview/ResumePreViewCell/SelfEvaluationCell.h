//
//  SelfEvaluationCell.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfEvaluationCell : UITableViewCell
@property(nonatomic,strong)UILabel * selfEvalueteContentLable;
-(void)configValue:(NSDictionary *)dataDic;

@end
