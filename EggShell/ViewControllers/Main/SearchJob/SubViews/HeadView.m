//
//  HeadView.m
//  EggShell
//
//  Created by mac on 15/8/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)selectCityCilck:(UIButton *)sender {
}
- (IBAction)searchClick:(UIButton *)sender {
    self.searchClick(self.seachText.text);
}
@end
