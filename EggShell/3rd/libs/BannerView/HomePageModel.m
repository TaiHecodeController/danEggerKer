//
//  HomePageModel.m
//  主界面banner model
//
//  Created by liaoyp on 10/10/25
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel

/**
 *  是否是网页分享
 */
-(BOOL) isTypeAppViewShare{
    
    return [_type isEqualToString:TYPE_APPVIEW_SHARE ];
}

/**
 *  是否是网页
 */
-(BOOL) isTypeWebView{
    
    return [_type isEqualToString:TYPE_WEBVIEW ];
}

/**
 *  是否是课程列表
 */
-(BOOL) isTypeCourseList{
    
    return [_type isEqualToString:TYPE_COURSE_LIST ];
}

/**
 *  是否是课程详情
 */
-(BOOL) isTypeCourseDetail{
    
    return [_type isEqualToString:TYPE_COURSE_DETAIL ];
}

/**
 *  是否是视频列表
 */
-(BOOL) isTypeCourseVideoList{
    
    return [_type isEqualToString:TYPE_COURSE_VIDEO_LIST ];
}

/**
 *  是否是扫码上课
 */
-(BOOL) isTypeScanCode
{
    return [_type isEqualToString:TYPE_SCANCODE ];
}

/**
 *  <#Description#>
 *
 *  @return <#return value description#>
 */
-(BOOL) isTypeAPPNewVersionShare{
    
    return [_type isEqualToString:TYPE_APPUPDATE_SHARE ];
}


@end
