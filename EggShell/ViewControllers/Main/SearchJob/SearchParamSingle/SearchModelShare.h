//
//  SearchModelShare.h
//  EggShell
//
//  Created by 太和 on 15/9/5.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModelShare : NSObject

//
@property (nonatomic, copy) NSString *longitude;
//
@property (nonatomic, copy) NSString *dimensionality;
//
@property (nonatomic, copy) NSString *keyword;
//
@property (nonatomic, copy) NSString *page;
//
@property (nonatomic, copy) NSString *hy;
//
@property (nonatomic, copy) NSString *job_post;
//
@property (nonatomic, copy) NSString *salary;
//
@property (nonatomic, copy) NSString *edu;
//
@property (nonatomic, copy) NSString *exp;
//
@property (nonatomic, copy) NSString *type;
//
@property (nonatomic, copy) NSString *sdate;
//
@property (nonatomic, copy) NSString *job1;
//
@property (nonatomic, copy) NSString *cityid;
//全城ID
@property (nonatomic, copy) NSString *provinceid;

@property(nonatomic,copy) NSString * job1_son;

@property(nonatomic)int tip;
+ (SearchModelShare *)sharedInstance;
//判断是不是第一次进入控制器


@end
