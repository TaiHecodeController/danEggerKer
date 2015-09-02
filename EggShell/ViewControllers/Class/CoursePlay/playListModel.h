//
//  playListModel.h
//  EggShell
//
//  Created by 太和 on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface playListModel : NSObject<Expose>

@property (nonatomic, copy) NSString *c_id;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *video_about;
@property (nonatomic, copy) NSString *video_hour;
@property (nonatomic, copy) NSString *video_id;
@property (nonatomic, copy) NSString *video_name;
@property (nonatomic, copy) NSString *video_obvious;
@property (nonatomic, copy) NSString *video_teacher;
@property (nonatomic, copy) NSString *vimage;

@end
