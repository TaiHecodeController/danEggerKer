//
//  Utils.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "Utils.h"

CGVector CGVectorFromCGPoint(CGPoint point) { return CGVectorMake(point.x, point.y); }

CGFloat CGPointMagnitude(CGPoint point) { return sqrtf(powf(point.x, 2) + powf(point.y, 2)); }

CGPoint CGPointNormalized(CGPoint point) {
    CGFloat magnitude = CGPointMagnitude(point);
    return CGPointMake(point.x / magnitude, point.y / magnitude);
}

CGPoint CGPointMultiply(CGPoint point, CGFloat factor) {
    return CGPointMake(point.x * factor, point.y * factor);
}

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromVector(CGVector directionVector) {
    ZLSwipeableViewDirection direction = ZLSwipeableViewDirectionNone;
    if (ABS(directionVector.dx) > ABS(directionVector.dy)) {
        if (directionVector.dx > 0) {
            direction = ZLSwipeableViewDirectionRight;
        } else {
            direction = ZLSwipeableViewDirectionLeft;
        }
    } else {
        if (directionVector.dy > 0) {
            direction = ZLSwipeableViewDirectionDown;
        } else {
            direction = ZLSwipeableViewDirectionUp;
        }
    }

    return direction;
}

ZLSwipeableViewDirection ZLSwipeableViewDirectionFromPoint(CGPoint point) {
    return ZLSwipeableViewDirectionFromVector(CGVectorFromCGPoint(point));
}

@implementation Utils

+(BOOL)checkTel:(NSString *)str

{
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        
        [MBProgressHUD creatembHub:@"请输入正确的手机号"];
        
        return NO;
        
    }
    
    
    
    return YES;
    
}

+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[0-9a-z._%+-]+@[a-z0-9.-]+.com";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSString *)changeTimeToString:(NSTimeInterval )time
{
    NSDate * confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatt stringFromDate:confromTimesp];
    
}

@end
