
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
    self.selfEvalueteContentLable.numberOfLines = 0;
    [self.contentView addSubview:self.selfEvalueteContentLable];
}
-(void)configValue:(NSDictionary *)dataDic
{
    self.selfEvalueteContentLable.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
    self.selfEvalueteContentLable.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.selfEvalueteContentLable.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.selfEvalueteContentLable.text sizeWithFont:self.selfEvalueteContentLable.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.selfEvalueteContentLable.frame = CGRectMake(15, 10, WIDETH-30, labelSize.height);
   
    //计算出自适应的高度
    frame.size.height = labelSize.height+20;
    
    self.frame = frame;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
