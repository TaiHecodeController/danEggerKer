//
//  HomePageModel.h
//  FollowMe
//
//  Created by Frank on 14-8-22.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import "BaseModel.h"

static  NSString *const  TYPE_NONE = @"none";
static  NSString *const  TYPE_COURSE_LIST = @"course_list";
static  NSString *const  TYPE_COURSE_DETAIL = @"course_detail";
static  NSString *const  TYPE_COURSE_VIDEO_LIST = @"course_video_list";
static  NSString *const  TYPE_APPVIEW_SHARE = @"appview_share";
static  NSString *const  TYPE_WEBVIEW = @"webview";
static  NSString *const  TYPE_SCANCODE = @"scan_code";
static  NSString *const  TYPE_APPUPDATE_SHARE   = @"appdown";


@interface HomePageModel : BaseModel

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *extend;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSDictionary *activity;

-(BOOL) isTypeCourseList;
-(BOOL) isTypeCourseDetail;
-(BOOL) isTypeCourseVideoList;
-(BOOL) isTypeAppViewShare;
-(BOOL) isTypeWebView;
-(BOOL) isTypeScanCode;
-(BOOL) isTypeAPPNewVersionShare;


@end
