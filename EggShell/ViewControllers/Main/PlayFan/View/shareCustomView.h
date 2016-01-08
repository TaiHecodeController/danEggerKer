//
//  shareCustomView.h
//  EggShell
//
//  Created by 李李贤军 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol shareCustomViewDelegate <NSObject>

@optional
-(void)shareButtonActionWithTag:(NSInteger)btnTag;
@end

@interface shareCustomView : UIView
- (void)showInView:(UIView *) view;

@property (nonatomic ,weak) id<shareCustomViewDelegate>delegate;
@end
