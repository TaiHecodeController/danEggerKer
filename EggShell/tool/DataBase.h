//
//  DataBase.h
//  EggShell
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DataBase : NSObject
+(instancetype)shareDB;
-(void)deleteDB;
-(void)insertDB:(NSString *)searchText;
-(NSMutableArray *)selectFromDB;
@end
