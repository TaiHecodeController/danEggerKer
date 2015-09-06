//
//  Utils.m
//  EggShell
//
//  Created by mac on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "Utils.h"



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
