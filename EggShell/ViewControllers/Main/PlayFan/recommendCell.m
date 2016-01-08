//
//  recommendCell.m
//  EggShell
//
//  Created by 太和 on 16/1/8.
//  Copyright © 2016年 wsd. All rights reserved.
//

#import "recommendCell.h"

@implementation recommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        @property (nonatomic, strong) UIImageView *banner;
//        @property (nonatomic, strong) UILabel *titleLab;
//        @property (nonatomic, strong) UIImageView *icon1;
//        @property (nonatomic, strong) UIImageView *icon2;
//        @property (nonatomic, strong) UIImageView *icon3;
//        @property (nonatomic, strong) UIButton *collectionBtn;
//        @property (nonatomic, strong) UIButton *joinBtn;
//        @property (nonatomic, strong) UILabel *hostLab;
//        @property (nonatomic, strong) UILabel *addressLab;
//        @property (nonatomic, strong) UILabel *timeLab;
        
        _banner = [[UIImageView alloc]init];
        [self addSubview:_banner];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLab];
        
        _icon1 = [[UIImageView alloc]init];
        _icon1.image = [UIImage imageNamed:@"holdmain"];
        [self addSubview:_icon1];
        
        _icon2 = [[UIImageView alloc]init];
         _icon2.image = [UIImage imageNamed:@"holdAddress"];
        [self addSubview:_icon2];
        
        _icon3 = [[UIImageView alloc]init];
         _icon3.image = [UIImage imageNamed:@"holdtime"];
        [self addSubview:_icon3];
        
        _hostLab = [[UILabel alloc]init];
        _hostLab.font = [UIFont systemFontOfSize:12];
        _hostLab.textColor = UIColorFromRGB(999999);
        [self addSubview:_hostLab];
        
        _addressLab = [[UILabel alloc]init];
        _addressLab.font = [UIFont systemFontOfSize:12];
        _addressLab.textColor = UIColorFromRGB(999999);
        [self addSubview:_addressLab];
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.textColor = UIColorFromRGB(999999);
        [self addSubview:_timeLab];
        
        _collectionBtn = [[UIButton alloc]init];
        [_collectionBtn setImage:[UIImage imageNamed:@"wuxing"] forState:UIControlStateNormal];
        _collectionBtn.titleLabel.textColor = UIColorFromRGB(999999);
        _collectionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_collectionBtn];
        
        _joinBtn = [[UIButton alloc]init];
        [_joinBtn setImage:[UIImage imageNamed:@"rentou"] forState:UIControlStateNormal];
        _joinBtn.titleLabel.textColor = UIColorFromRGB(999999);
        _joinBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_joinBtn];
        
        _itemTimeView = [[ItemTimeView alloc]init];
        [self addSubview:_itemTimeView];


    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat y = 0;
    
    _banner.frame = CGRectMake(10, 5, 355, 199);
    
    _titleLab.frame = CGRectMake(10, CGRectGetMaxY(_banner.frame) + 10, WIDETH, 20);
    
    _icon1.frame = CGRectMake(10, CGRectGetMaxY(_titleLab.frame) + 10, 10, 10);
    
    _hostLab.frame = CGRectMake(CGRectGetMaxX(_icon1.frame) + 5, CGRectGetMinY(_icon1.frame), WIDETH, 10);
    
    _icon2.frame = CGRectMake(10, CGRectGetMaxY(_icon1.frame) + 10, 10, 10);
    
    _addressLab.frame = CGRectMake(CGRectGetMaxX(_icon2.frame) + 5, CGRectGetMinY(_icon2.frame), WIDETH, 10);
    
    _icon3.frame = CGRectMake(10, CGRectGetMaxY(_icon2.frame) + 10, 10, 10);
    
    _timeLab.frame = CGRectMake(CGRectGetMaxX(_icon3.frame) + 5, CGRectGetMinY(_icon3.frame), WIDETH, 10);
    
    _itemTimeView.frame = CGRectMake(WIDETH - 82, CGRectGetMinY(_icon3.frame), 72, 12);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
