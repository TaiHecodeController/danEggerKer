//
//  ResumeCell.m
//  EggShell
//
//  Created by mac on 15/8/31.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "ResumeCell.h"
#import "TH_ResumePreviewVC.h"

@implementation ResumeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)iSSelectClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)lookResumeClick:(UIButton *)sender {
    TH_ResumePreviewVC  * presum = [[TH_ResumePreviewVC alloc] init];
    presum.title = @"简历预览";
    [self.Controller.navigationController pushViewController:presum animated:YES];
}
@end
