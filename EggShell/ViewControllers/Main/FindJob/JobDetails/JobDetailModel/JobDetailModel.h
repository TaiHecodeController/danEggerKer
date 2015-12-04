//
//  JobDetailModel.h
//  EggShell
//
//  Created by 太和 on 15/9/1.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"
#import "companyInformationModel.h"

@interface list_item : NSObject<Expose>

@property (nonatomic, copy) NSString *com_name;
@property (nonatomic, copy) NSString *edu;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *lastupdate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *provinceid;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *uid;

@end


@interface JobDetailModel : NSObject<Expose>

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *cj_name;
@property (nonatomic, copy) NSString *com_name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *cj_description;
@property (nonatomic, copy) NSString *edu;
@property (nonatomic, copy) NSString *exp;
@property (nonatomic, copy) NSString *hy;
@property (nonatomic, copy) NSString *cj_id;
@property (nonatomic, copy) NSString *lastupdate;
@property (nonatomic, copy) NSString *linkmail;
@property (nonatomic, copy) NSString *linktel;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *mun;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *provinceid;
@property (nonatomic, copy) NSString *salary;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sdate;
@property (nonatomic, copy) NSString *edate;
@property (nonatomic, copy) NSString *iscollect;
@property (nonatomic, copy) NSString *number;

array_item_def(lists)
@property (nonatomic, strong) NSArray *lists;
//@property (nonatomic, copy) NSString *name;

@end
