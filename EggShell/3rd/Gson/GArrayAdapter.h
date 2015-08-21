//
//  GArrayAdapter.h
//  json
//
//  Created by jikai on 14-11-28.
//  Copyright (c) 2014年 jikai. All rights reserved.
//

#import "GAdapter.h"

@interface GArrayFactory : GFactory
@end

@interface GArrayAdapter : GAdapter
@property GAdapter * ItemAdapter;
@end
