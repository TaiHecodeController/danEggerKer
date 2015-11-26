//
//  AllPosionModel.h
//  EggShell
//
//  Created by 李李贤军 on 15/11/25.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
@interface AllPosionModel : NSObject<Expose>
@property(nonatomic,copy)NSString * cj_id;
@property(nonatomic,copy)NSString * cj_name;
@property(nonatomic,copy)NSString * count;
@property(nonatomic,copy)NSString * edate;
@property(nonatomic,copy)NSString * jobhits;
@property(nonatomic,copy)NSString * lastupdate;
@property(nonatomic,copy)NSString * status;
@property(nonatomic,copy)NSString *cellselected;

@end
