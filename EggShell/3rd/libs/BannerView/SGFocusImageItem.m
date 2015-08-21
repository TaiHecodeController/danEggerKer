//
//  SGFocusImageItem.m
//  ScrollViewLoop
//
//  Created by Vincent Tang on 13-7-18.
//  Copyright (c) 2013年 Vincent Tang. All rights reserved.
//

#import "SGFocusImageItem.h"

@implementation SGFocusImageItem

- (id)initWithDictionary:(NSDictionary *)item withTag:(NSInteger)tag
{
    self = [super initWithDictionary:item];
    if (self)
    {
        self.tag = tag;
    }
    return self;
}
@end
