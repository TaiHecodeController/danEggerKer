//
//  SearchModelShare.m
//  EggShell
//
//  Created by 太和 on 15/9/5.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "SearchModelShare.h"

@implementation SearchModelShare

static SearchModelShare *_sharedInstance = nil;

+ (SearchModelShare *)sharedInstance
{
    @synchronized(self)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if(_sharedInstance == nil)
            {
                _sharedInstance = [[self alloc] init];
                
            }
        });
    }
    return _sharedInstance;
}

@end
