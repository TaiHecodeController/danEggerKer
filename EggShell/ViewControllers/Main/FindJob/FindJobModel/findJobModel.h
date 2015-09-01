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
@property(nonatomic,assign)NSString *com_name;
@property(nonatomic,assign)NSString *edu;
@property(nonatomic,assign)NSString *id;
@property(nonatomic,assign)NSString *lastupdate;
@property(nonatomic,assign)NSString *name;
@property(nonatomic,assign)NSString *provinceid;
@property(nonatomic,assign)NSString *salary;
@property(nonatomic,assign)NSString *uid;
@end
