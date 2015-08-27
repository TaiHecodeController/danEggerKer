//
//  MMNetWorkType.h
//  LoveShopingMother
//
//  Created by 李贤军 on 15/8/27.
//  Copyright (c) 2015年 aitaomama-ios. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,NetWorkType) {
    //以下是枚举成员
    BadNetWorkLink= 0,
    Wifi= 1,
    WWAN= 2,
};

@interface MMNetWorkType : NSObject
+(NetWorkType)getNetWorkType;
@end
