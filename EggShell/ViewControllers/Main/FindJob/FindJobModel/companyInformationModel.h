//
//  companyInformationModel.h
//  EggShell
//
//  Created by 太和 on 15/9/1.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gson.h"

@interface companyInformationModel : NSObject<Expose>

@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *hy;
@property (nonatomic, copy) NSString *linkmail;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *mun;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *uid;

@end
