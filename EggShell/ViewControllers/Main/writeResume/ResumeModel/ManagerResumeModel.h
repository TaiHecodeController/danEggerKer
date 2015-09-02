//
//  ManagerResumeModel.h
//  EggShell
//
//  Created by mac on 15/9/2.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface ManagerResumeModel : NSObject<Expose>
@property(strong,nonatomic)NSString * name;
@property(strong,nonatomic)NSString * ctime;
@property(strong,nonatomic)NSString * rid;
@end
