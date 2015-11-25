//
//  TableViewCell_2.m
//  EggShell
//
//  Created by 太和 on 15/11/24.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "TableViewCell_2.h"

#define btnWidth 53
#define btnHeight 23

@interface TableViewCell_2 ()

@property (nonatomic, strong) UIImageView *clockIcon;
@property (nonatomic, strong) UIView *line;

//三个按钮
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@property (nonatomic, strong) UIView *bottomView;

@end


@implementation TableViewCell_2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _selIcon = [[UIImageView alloc]init];
                _selIcon.image  = [UIImage imageNamed:@"xuankuang"];
//        _selIcon.backgroundColor = [UIColor redColor];
        [self addSubview:_selIcon];
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.text = @"张三丰";
        _nameLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:_nameLab];
        
        _positionLab = [[UILabel alloc]init];
        _positionLab.textColor = [UIColor blackColor];
        _positionLab.text = @"张三丰";
        _positionLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_positionLab];
        
        _clockIcon = [[UIImageView alloc]init];
                _clockIcon.image = [UIImage imageNamed:@"company_clock"];
//        _clockIcon.backgroundColor = [UIColor redColor];
        [self addSubview:_clockIcon];
        
        _expLab = [[UILabel alloc]init];
        _expLab.textColor = [UIColor blackColor];
        _expLab.text = @"一年以下";
        _expLab.font = [UIFont systemFontOfSize:14];
        [self addSubview:_expLab];
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = [UIColor blackColor];
        _timeLab.text = @"2015.11.23";
        _timeLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_timeLab];
        
        _salaryLab = [[UILabel alloc]init];
        _salaryLab.textColor = [UIColor redColor];
        _salaryLab.text = @"¥4000-16000";
        _salaryLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_salaryLab];
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = color(215, 215, 215);
        [self addSubview:_line];
        
        _btn1 = [[UIButton alloc]init];
        [_btn1 setTitle:@"已查看" forState:UIControlStateNormal];
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:13];
//        [self addSubview:_btn1];
        
        _btn2 = [[UIButton alloc]init];
        [_btn2 setTitle:@"待通知" forState:UIControlStateNormal];
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn2];
        
        _btn3 = [[UIButton alloc]init];
        [_btn3 setTitle:@"不合适" forState:UIControlStateNormal];
        _btn3.layer.borderWidth = 1;
        _btn3.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:13];
        [_btn3 addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn3];
        
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = color(240, 240, 237);
        [self addSubview:_bottomView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _selIcon.frame = CGRectMake(20, 28.5, 20, 20);
    
    CGSize nameSize = [_nameLab.text sizeWithFont:_nameLab.font];
    _nameLab.frame = CGRectMake(CGRectGetMaxX(_selIcon.frame) + 20, 10, nameSize.width, nameSize.height);
    
    CGSize positionSize = [_positionLab.text sizeWithFont:_positionLab.font];
    _positionLab.frame = CGRectMake(60, CGRectGetMaxY(_nameLab.frame) + 8, positionSize.width, positionSize.height);
    
    _clockIcon.frame = CGRectMake(160* MyWideth, 32, 20, 20);
    
    CGSize expSize = [_expLab.text sizeWithFont:_expLab.font];
    _expLab.frame = CGRectMake(CGRectGetMaxX(_clockIcon.frame), CGRectGetMinY(_clockIcon.frame), expSize.width, expSize.height);
    
    CGSize timeSize = [_timeLab.text sizeWithFont:_timeLab.font];
    _timeLab.frame = CGRectMake(WIDETH - 20 - timeSize.width, 15, timeSize.width, timeSize.height);
    
    CGSize salarySize = [_salaryLab.text sizeWithFont:_salaryLab.font];
    _salaryLab.frame = CGRectMake(WIDETH - 20 - salarySize.width, CGRectGetMaxY(_timeLab.frame) + 10, salarySize.width, salarySize.height);
    
    _line.frame = CGRectMake(10, CGRectGetMaxY(_positionLab.frame) + 10, WIDETH - 10, 1);
    
    _btn1.frame = CGRectMake(WIDETH - 10 * 3 - btnWidth * 3, CGRectGetMaxY(_line.frame) + 10, btnWidth, btnHeight);
    
    _btn2.frame = CGRectMake(CGRectGetMaxX(_btn1.frame) + 10, CGRectGetMaxY(_line.frame) + 10,btnWidth, btnHeight);
    
    _btn3.frame = CGRectMake(CGRectGetMaxX(_btn2.frame) + 10,  CGRectGetMaxY(_line.frame) + 10, btnWidth, btnHeight);
    
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_btn3.frame) + 10, WIDETH, 10);
    
    _cellHeight = CGRectGetMaxY(_bottomView.frame);
    
}


- (void)btn2Click
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"daitongzhi" object:nil userInfo:@{@"cellSelf":self}];
}

- (void)btn3Click
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buheshi" object:nil userInfo:@{@"cellSelf":self}];
}


- (void)config:(cpy_ReciveResumeListMode *)model
{
    self.nameLab.text = model.name;
    self.positionLab.text = model.job_name;
    self.expLab.text = model.exp;
    self.timeLab.text = model.datetime;
    self.salaryLab.text = model.salary;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
