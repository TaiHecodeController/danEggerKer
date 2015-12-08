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
    self.contactLable.text = model.telphone;
    self.contactPesonLable.text = model.user;
    self.RouteLable.text = model.traffic_route;
    self.MeetingPlaceLable.text = model.address;
//    self.contentLable.text = model.content;
    
//    NSAttributedString *comAttributedString = [[NSAttributedString alloc] initWithData:[model.content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    self.contentLable.attributedText = comAttributedString;
//
    
[self.logoImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"tu001"]];
//    self.logoImage.contentMode = UIViewContentModeScaleAspectFill;
}
-(void)setValuess:(informantionModel*)model
{
    
    
    self.holdLable.text = model.organizers;
    self.timelLable.text = model.endtime;
    self.contactLable.text = model.phone;
    self.contactPesonLable.text = model.user;
    self.RouteLable.text = model.traffic;
    self.MeetingPlaceLable.text = model.address;
//    NSAttributedString *comAttributedString = [[NSAttributedString alloc] initWithData:[model.body dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    self.contentLable.attributedText = comAttributedString;
//
   [self.logoImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"tu001"]];
}
@end
