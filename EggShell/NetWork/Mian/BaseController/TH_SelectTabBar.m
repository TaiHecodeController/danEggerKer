//
//  TH_SelectTabBar.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/26.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TH_SelectTabBar.h"
static TH_SelectTabBar *gTabBar = nil;
@implementation TH_SelectTabBar
@synthesize miIndex, delegate, OnForumTabSelect;

+ (TH_SelectTabBar *)Share {
    return gTabBar;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        gTabBar = self;
        self.userInteractionEnabled = YES;
        self.backgroundColor =[UIColor whiteColor];
        NSArray *array = [NSArray arrayWithObjects:@"homesecond", @"playFunSecond", @"findJobSecond",@"mineSecond",  nil];
        NSArray *array1 = [NSArray arrayWithObjects:@"homesecondSelectet", @"playFunSecondSelectet", @"findJobSecondSelectet",@"mineSecondSelectet", nil];
        int width = self.frame.size.width/array.count;
        int x = 0;
        for (int i = 0; i<array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x, (self.frame.size.height-44)/2, width, 44);
            button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
            button.backgroundColor = self.backgroundColor;
            
            [button setImage:[UIImage imageNamed:[array objectAtIndex:i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[array1 objectAtIndex:i]]  forState:UIControlStateSelected];
            [button addTarget:self action:@selector(OnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            button.tag = i+1500;
            [self addSubview:button];
            x += width;
        }
        
        UIView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor grayColor];
//               [self addSubview:lineView];
        
        [self RefreshView];
    }
    return self;
}

- (void)OnBtnClick:(UIButton *)sender {
    float index = sender.tag-1500;
    if (delegate && [delegate respondsToSelector:@selector(CanSelectTab::)]) {
        if (![delegate CanSelectTab:self :index]) {
            return;
        }
    }
    self.miIndex = index;
    
    if (delegate && [delegate respondsToSelector:@selector(OnTabSelect:)]) {
        [delegate OnTabSelect:self];
    }
}

- (void)RefreshView {
    for (int i = 0; i < 5; i ++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+1500];
        if (button) {
            button.selected = (i == miIndex);
        }
    }
}

- (void)setMiIndex:(int)index {
    miIndex = index;
    [self RefreshView];
}

@end
