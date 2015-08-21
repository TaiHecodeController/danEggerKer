//
//  DataBase.m
//  EggShell
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "DataBase.h"
@interface DataBase()
@property (strong,nonatomic)FMDatabase * db;
@end
@implementation DataBase

+(instancetype)shareDB
{
    static DataBase * dataBase = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[DataBase alloc] init];
    });
    return dataBase;
}

/**
 * 创建数据库
 */
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        //获取沙河下Caches文件夹路径
        NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        filePath = [filePath stringByAppendingString:@"/TH_Sql.sqlite"];
        NSLog(@"DBPath:%@",filePath);
        
        //创建数据库文件
        FMDatabase * db = [FMDatabase databaseWithPath:filePath];
        if([db open])
        {
            BOOL flag = [db executeUpdate:@"create table if not exists search_record(id integer primary key autoincrement,searchText,text)"];
            if(flag)
            {
                NSLog(@"创建成功");
            }else
            {
                NSLog(@"创建失败");
            }
        }
        self.db = db;
    }
    return self;
}

/**
 * 插入数据
 */
-(void)insertDB:(NSString *)searchText
{
    BOOL flag = [self.db executeUpdate:@"insert into search_record(searchText) values(?)",searchText];
    if(flag)
    {
        NSLog(@"insert success");
    }else
    {
        NSLog(@"insert failure");
    }
}

/**
 * 获取表中数据
 */
-(NSMutableArray *)selectFromDB
{
    NSMutableArray * array = [NSMutableArray array];
    FMResultSet * result = [self.db executeQuery:@"select * from search_record"];
    NSString * searchResult;
    while ([result next]) {
        searchResult = [result stringForColumn:@"searchText"];
        [array addObject:searchResult];
    }
    return array;
}

/**
 * 删除数据
 */
-(void)deleteDB
{
    if([self.db executeUpdate:@"DROP TABLE %@",@"search_record"])
    {
        NSLog(@"delete success");
    }else
    {
        NSLog(@"delete failure");
    }
}
@end
