
//
//  SelfEvaluationCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "SelfEvaluationCell.h"

@implementation SelfEvaluationCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    
    self.selfEvalueteContentLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 50)];
    self.selfEvalueteContentLable.font = [UIFont systemFontOfSize:12];
    self.selfEvalueteContentLable.textColor = UIColorFromRGB(0x000000);
    self.selfEvalueteContentLable.text = @"暂无";
    [self.contentView addSubview:self.selfEvalueteContentLable];
}
-(void)configValue:(NSDictionary *)dataDic
{
    if(dataDic.count == 0)
    {
        return;
    }
    self.selfEvalueteContentLable.text = dataDic[@"content"];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
