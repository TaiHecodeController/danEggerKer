//
//  TalentModel.h
//  EggShell
//
//  Created by 太和 on 15/11/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface TalentModel : NSObject<Expose>

@property (nonatomic, copy) NSString *com_id;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *eid;
@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *hopeprofess;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *cellselected;

@end
