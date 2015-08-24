//
//  infDestDetailView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "infDestDetailView.h"

@implementation infDestDetailView

-(void)setValue:(playFanModel*)model
{
    self.holdLable.text = model.organizers;
    self.timelLable.text = model.endtime;
    self.contactLable.text = model.telphone;
    self.contactPesonLable.text = model.user;
    self.RouteLable.text = model.address;

}
@end
