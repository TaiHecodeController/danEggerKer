//
//  Utils.h
//  EggShell
//
//  Created by mac on 15/8/8.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
//获得xib文件引用宏定义
#define alloc_with_xib(xib_file) \
+(id)alloc \
{ \
static BOOL loading = NO; \
\
if( loading ){ \
return [super alloc]; \
} \
\
loading = YES; \
id obj = [[NSBundle mainBundle]loadNibNamed:@#xib_file owner:nil options:nil][0]; \
\
loading = NO; \
\
return obj; \
}

#define APPID @""

@interface Utils : NSObject

@end
