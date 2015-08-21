//
//  jobListCell.m
//  EggShell
//
//  Created by 太和 on 15/8/18.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "jobListCell.h"

@interface jobListCell ()

@property (nonatomic, strong) UIView *lineView;

@end

@implementation jobListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
        _positionSecBtn = [[UIButton alloc]init];
        [_positionSecBtn setImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
        [_positionSecBtn setImage:[UIImage imageNamed:@"douyou1"] forState:UIControlStateSelected];
        //        [_positionSecBtn addTarget:self action:@selector(positionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_positionSecBtn];
        
        _positionLab = [[UILabel alloc]init];
        _positionLab.textColor = UIColorFromRGB(000000);
        _positionLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_positionLab];
        
        _companyLab = [[UILabel alloc]init];
        _companyLab.textColor = [UIColor grayColor];
        _companyLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_companyLab];
        
        _cityLab = [[UILabel alloc]init];
        _cityLab.textColor = [UIColor grayColor];
        _cityLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_cityLab];
        
        _knowledgeLab = [[UILabel alloc]init];
        _knowledgeLab.textColor = [UIColor grayColor];
        _knowledgeLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_knowledgeLab];
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor grayColor];
        _timeLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_timeLab];
        
        _salaryLab = [[UILabel alloc]init];
        _salaryLab.textColor = UIColorFromRGB(0xf44336);
        _salaryLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_salaryLab];
        
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 20;
    CGFloat y = 10;
    CGFloat x = margin;
    
    _positionSecBtn.frame = CGRectMake(margin, 27, 17.5, 17.5);
    
    if ([_jobSelected isEqualToString:@"0"])
    {
        _positionSecBtn.selected = NO;
    }
    else
    {
        _positionSecBtn.selected = YES;
    }
    
    CGSize pLabSize = [_positionLab.text sizeWithFont:_positionLab.font];
    _positionLab.frame = CGRectMake(CGRectGetMaxX(_positionSecBtn.frame) + margin, y, pLabSize.width, pLabSize.height);
    
    y += _positionLab.frame.size.height + 5;
    CGSize compSize = [_companyLab.text sizeWithFont:_companyLab.font];
    _companyLab.frame = CGRectMake(CGRectGetMaxX(_positionSecBtn.frame) + margin, y, compSize.width, compSize.height);
    
    _positionSecBtn.frame = CGRectMake(margin, CGRectGetMinY(_companyLab.frame), 17.5, 17.5);
    
    y += _companyLab.frame.size.height + 5;
    CGSize cityLabSize = [_cityLab.text sizeWithFont:_cityLab.font];
    _cityLab.frame = CGRectMake(CGRectGetMaxX(_positionSecBtn.frame) + margin,  y, cityLabSize.width, cityLabSize.height);
    
    _lineView.frame = CGRectMake(CGRectGetMaxX(_cityLab.frame) + 7, y, 1, cityLabSize.height);
    
    CGSize knowledgeSize = [_knowledgeLab.text sizeWithFont:_knowledgeLab.font];
    _knowledgeLab.frame = CGRectMake(CGRectGetMaxX(_lineView.frame) + 7, y, knowledgeSize.width, knowledgeSize.height);
    
    CGSize timeSize = [_timeLab.text sizeWithFont:_timeLab.font];
    _timeLab.frame = CGRectMake(WIDETH - margin- timeSize.width, CGRectGetMinY(_positionLab.frame), timeSize.width, timeSize.height);
    
    CGSize salarySize = [_salaryLab.text sizeWithFont:_salaryLab.font];
    _salaryLab.frame = CGRectMake(WIDETH - salarySize.width - margin, CGRectGetMinY(_cityLab.frame), salarySize.width, salarySize.height);
    
    _cellHeight = CGRectGetMaxY(_cityLab.frame) + 10;
}

//- (void)positionBtnClick:(UIButton *)sender
//{
//    if (sender.selected == NO)
//    {
//        sender.selected = YES;
//
//    }
//    else
//    {
//        sender.selected = NO;
//    }
//}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
