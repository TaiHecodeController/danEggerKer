//
//  informantionModel.h
//  EggShell
//
//  Created by 李李贤军 on 15/9/5.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface informantionModel : NSObject<Expose>
@property(nonatomic,copy)NSString * address;
@property(nonatomic,copy)NSString * body;
@property(nonatomic,copy)NSString * ctime;
@property(nonatomic,copy)NSString * endtime;
@property(nonatomic,copy)NSString * id;
@property(nonatomic,copy)NSString * logo;
@property(nonatomic,copy)NSString * organizers;
@property(nonatomic,copy)NSString * starttime;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * traffic;
@property(nonatomic,copy)NSString * user;



@end
