//
//  NSIndexPath+RK_row_col.h
//  EggShell
//
//  Created by 太和 on 15/8/24.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (RK_row_col)

+ (NSIndexPath *)indexPathForColumn:(NSUInteger)column inRow:(NSUInteger)row;

- (NSUInteger)columnIndex;

- (NSUInteger)rowIndex;

@end
