//
//  MMNetWorkType.m
//  LoveShopingMother
//
//  Created by 李贤军 on 15/8/27.
//  Copyright (c) 2015年 aitaomama-ios. All rights reserved.
//

#import "MMNetWorkType.h"

#import "Reachability.h"
@implementation MMNetWorkType
+(NetWorkType)getNetWorkType
{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            // 没有网络连接
            NSLog(@"无网络");
            return BadNetWorkLink;
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            NSLog(@"移动网络");
            return WWAN;
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            NSLog(@"wifi");
            return Wifi;
            break;
    }
    return BadNetWorkLink;
}@end
