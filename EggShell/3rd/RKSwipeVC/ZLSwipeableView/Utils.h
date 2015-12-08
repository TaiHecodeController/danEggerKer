//
//  Utils.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"
//获得xib文件引用宏定义
#define alloc_with_xib(xib_file) \
+(id)alloc \
{ \
static BOOL loading = NO; \
\
if( loading ){ \
return [super alloc]; \
} \
\
loading = YES; \
id obj = [[NSBundle mainBundle]loadNibNamed:@#xib_file owner:nil options:nil][0]; \
\
loading = NO; \
\
return obj; \
}

#define APPID @"1037707953"

CGVector CGVectorFromCGPoint(CGPoint point);

CGFloat CGPointMagnitude(CGPoint point);

CGPoint CGPointNormalized(CGPoint point);

CGPoint CGPointMultiply(CGPoint point, CGFloat factor);

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromVector(CGVector directionVector);

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromPoint(CGPoint point);

@interface Utils : NSObject

//手机号检测
+(BOOL)checkTel:(NSString *)str;
//邮箱检测
+ (BOOL) validateEmail:(NSString *)email;

+ (NSString *)changeTimeToString:(NSTimeInterval)time;

@end
