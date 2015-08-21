//
//  SGFocusImageItem.h
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "HomePageModel.h"

@interface SGFocusImageItem : HomePageModel

@property (nonatomic, assign)  NSInteger tag;

- (id)initWithDictionary:(NSDictionary *)item withTag:(NSInteger)tag;
@end
