//
//  findJobModel.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/1.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface findJobModel : NSObject<Expose>
@property(nonatomic,copy)NSString *com_name;
@property(nonatomic,copy)NSString *edu;
@property(nonatomic,copy)NSString *job_id;
@property(nonatomic,copy)NSString *lastupdate;
@property(nonatomic,copy)NSString *job_name;
@property(nonatomic,copy)NSString *provinceid;
@property(nonatomic,copy)NSString *salary;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *cellselected;
@end
