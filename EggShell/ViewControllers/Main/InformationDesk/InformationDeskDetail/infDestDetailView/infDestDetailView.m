//
//  infDestDetailView.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/13.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "infDestDetailView.h"

@implementation infDestDetailView

-(void)setValues:(playFanModel*)model
{
    self.holdLable.text = model.organizers;
    self.timelLable.text = model.endtime;
    self.contactLable.text = model.every_time;
    self.contactPesonLable.text = model.user;
    self.RouteLable.text = model.address;
    self.MeetingPlaceLable.text = model.address;
    self.contentLable.text = model.content;

}
-(void)setValuess:(informantionModel*)model
{
    self.holdLable.text = model.organizers;
    self.timelLable.text = model.endtime;
    self.contactLable.text = model.telphone;
    self.contactPesonLable.text = model.user;
    self.RouteLable.text = model.address;
    self.MeetingPlaceLable.text = model.address;
    self.contentLable.text = model.content;
}
@end
