//
//  NSIndexPath+RK_row_col.m
//  EggShell
//
//  Created by 太和 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "NSIndexPath+RK_row_col.h"

@implementation NSIndexPath (RK_row_col)

+ (NSIndexPath *)indexPathForColumn:(NSUInteger)column inRow:(NSUInteger)row
{
    NSUInteger indexs[] = {column, row};
    
    return [NSIndexPath indexPathWithIndexes:indexs length:sizeof(indexs)];
}

- (NSUInteger)columnIndex
{
    return [self indexAtPosition:0];
}

- (NSUInteger)rowIndex
{
    return [self indexAtPosition:1];
}


@end
