//
//  TalentPoolCell.m
//  EggShell
//
//

#import "TalentPoolCell.h"


#define btnWidth 53
#define btnHeight 23

@interface TalentPoolCell ()

@property (nonatomic, strong) UIImageView *clockIcon;
@property (nonatomic, strong) UIView *line;

//三个按钮
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation TalentPoolCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        _selIcon = [[UIButton alloc]init];
        [_selIcon setBackgroundImage:[UIImage imageNamed:@"xuankuang"] forState:UIControlStateNormal];
        [_selIcon setBackgroundImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateSelected];
        [self addSubview:_selIcon];
        
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor = [UIColor blackColor];
//        _nameLab.text = @"张三丰";
        _nameLab.font = [UIFont systemFontOfSize:16 * MyWideth];
        [self addSubview:_nameLab];
        
        _positionLab = [[UILabel alloc]init];
        _positionLab.textColor = UIColorFromRGB(0x646464);
//        _positionLab.text = @"UI设计师";
        _positionLab.font = [UIFont systemFontOfSize:13 * MyWideth];
        [self addSubview:_positionLab];
        
        _clockIcon = [[UIImageView alloc]init];
        _clockIcon.image = [UIImage imageNamed:@"company_clock"];
        [self addSubview:_clockIcon];
        
        _expLab = [[UILabel alloc]init];
        _expLab.textColor =UIColorFromRGB(0x646464);
        //        _expLab.text = @"一年以下";
        _expLab.font = [UIFont systemFontOfSize:13 * MyWideth];
        [self addSubview:_expLab];
        
        _timeLab = [[UILabel alloc]init];
        _timeLab.textColor = UIColorFromRGB(0x646464);;
//        _timeLab.text = @"2015.11.23";
        _timeLab.font = [UIFont systemFontOfSize:13 * MyWideth];
        [self addSubview:_timeLab];
        
        _salaryLab = [[UILabel alloc]init];
        _salaryLab.textColor = [UIColor redColor];
//        _salaryLab.text = @"¥4000-16000";
        _salaryLab.font = [UIFont systemFontOfSize:13 * MyWideth];
        [self addSubview:_salaryLab];
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = color(215, 215, 215);
//        [self addSubview:_line];
        
        _btn1 = [[UIButton alloc]init];
        [_btn1 setTitle:@"已查看" forState:UIControlStateNormal];
        _btn1.layer.borderWidth = 1;
        _btn1.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn1.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
        //        [self addSubview:_btn1];
        
        _btn2 = [[UIButton alloc]init];
        [_btn2 setTitle:@"待通知" forState:UIControlStateNormal];
        _btn2.layer.borderWidth = 1;
        _btn2.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
        //        [self addSubview:_btn2];
        
        _btn3 = [[UIButton alloc]init];
        [_btn3 setTitle:@"不合适" forState:UIControlStateNormal];
        _btn3.layer.borderWidth = 1;
        _btn3.layer.borderColor = [color(215, 215, 215) CGColor];
        [_btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn3.titleLabel.font = [UIFont systemFontOfSize:13 * MyWideth];
        //        [self addSubview:_btn3];
        
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = color(240, 240, 237);
        [self addSubview:_bottomView];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([_icon_seleted isEqualToString:@"0"])
    {
        _selIcon.selected = NO;
    }
    else
    {
        _selIcon.selected = YES;
    }
    
    _selIcon.frame = CGRectMake(20, 32, 20, 20);
    
    CGSize nameSize = [_nameLab.text sizeWithFont:_nameLab.font];
    _nameLab.frame = CGRectMake(CGRectGetMaxX(_selIcon.frame) + 20, 10, nameSize.width, nameSize.height);
    
    CGSize positionSize = [_positionLab.text sizeWithFont:_positionLab.font];
    _positionLab.frame = CGRectMake(60, CGRectGetMaxY(_nameLab.frame) + 8, positionSize.width, positionSize.height);
    
    _clockIcon.frame = CGRectMake(165 * MyWideth, 32, 20, 20);
    
    CGSize expSize = [_expLab.text sizeWithFont:_expLab.font];
    _expLab.frame = CGRectMake(CGRectGetMaxX(_clockIcon.frame), CGRectGetMinY(_positionLab.frame), expSize.width, expSize.height);
    
    CGSize timeSize = [_timeLab.text sizeWithFont:_timeLab.font];
    _timeLab.frame = CGRectMake(WIDETH - 20 - timeSize.width, 15, timeSize.width, timeSize.height);
    
    CGSize salarySize = [_salaryLab.text sizeWithFont:_salaryLab.font];
    _salaryLab.frame = CGRectMake(WIDETH - 20 - salarySize.width, CGRectGetMaxY(_timeLab.frame) + 10, salarySize.width, salarySize.height);
    
    _line.frame = CGRectMake(10, CGRectGetMaxY(_positionLab.frame) + 10, WIDETH - 10, 1);
        
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_line.frame), WIDETH, 10);
    
    _cellHeight = CGRectGetMaxY(_bottomView.frame);
    
}

- (void)config:(TalentModel *)model
{
    self.nameLab.text = model.name;
    self.positionLab.text = model.hopeprofess;
    self.expLab.text = model.exp;
    self.timeLab.text = model.ctime;
    self.salaryLab.text = model.salary;
}



@end
