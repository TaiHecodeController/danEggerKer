//
//  SelfEvaluationView.h
//  EggShell
//
//  Created by 李李贤军 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfEvaluationView : UIView
@property (weak, nonatomic) IBOutlet UITextView *selfEvaluation;

+(SelfEvaluationView*)setSelfEvaluationView;
-(void)configValue:(NSDictionary *)dataDic;
@end
