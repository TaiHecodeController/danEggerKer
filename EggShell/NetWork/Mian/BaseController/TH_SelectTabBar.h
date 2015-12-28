//
//  TH_SelectTabBar.h
//  EggShell
//
//  Created by 李李贤军 on 15/12/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TH_SelectTabBar;
@protocol SelectTabBarDelegate <NSObject>

- (void)OnTabSelect:(TH_SelectTabBar *)sender;
- (BOOL)CanSelectTab:(TH_SelectTabBar *)sender :(int)index;
@end
@interface TH_SelectTabBar : UIImageView
{

}
@property(nonatomic, assign) int miIndex;
@property(nonatomic, assign) id delegate;
@property(nonatomic, assign) SEL OnForumTabSelect;

+ (TH_SelectTabBar *)Share;
@end
