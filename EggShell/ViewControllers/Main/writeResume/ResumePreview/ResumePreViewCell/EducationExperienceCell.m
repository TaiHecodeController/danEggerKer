//
//  EducationExperienceCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "EducationExperienceCell.h"
#import "EditdelegateView.h"
@implementation EducationExperienceCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{ UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDETH, .5)];
    lineView.backgroundColor = UIColorFromRGB(0xDDDDDD);
    [self.contentView addSubview:lineView];
    //教育时间
    UILabel * educationTimeHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    educationTimeHeadLable.text = @"在校时间:";
    educationTimeHeadLable.font = [UIFont systemFontOfSize:12];
    educationTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:educationTimeHeadLable];
    self.educationTime =[[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-90, 12)];
    self.educationTime.font = [UIFont systemFontOfSize:12];
    self.educationTime.textColor = UIColorFromRGB(0x000000);
    self.educationTime.text = @"暂无";
    [self.contentView addSubview:self.educationTime];
    //所学专业
    UILabel *departmentHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    departmentHeadLable.text = @"所学专业:";
    departmentHeadLable.font = [UIFont systemFontOfSize:12];
    departmentHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:departmentHeadLable];
    self.department = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-30, 12)];
    self.department.font = [UIFont systemFontOfSize:12];
    self.department.textColor = UIColorFromRGB(0x000000);
    self.department.text = @"暂无";
    [self.contentView addSubview:self.department];
    //所在学校
    UILabel * schoolNameHeadLable =[[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    schoolNameHeadLable.text = @"学校名称:";
    schoolNameHeadLable.font = [UIFont systemFontOfSize:12];
    schoolNameHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:schoolNameHeadLable];
    self.schoolName =[[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-90, 12)];
    self.schoolName.font = [UIFont systemFontOfSize:12];
    self.schoolName.textColor = UIColorFromRGB(0x000000);
    self.schoolName.text = @"暂无";
    [self.contentView addSubview:self.schoolName];
    //担任职位
    UILabel * positionHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 76, 60, 12)];
    positionHeadLable.font = [UIFont systemFontOfSize:12];
    positionHeadLable.textColor = UIColorFromRGB(0x646464);
    positionHeadLable.text = @"担任职位";
    [self.contentView addSubview:positionHeadLable];
    self.position = [[UILabel alloc] initWithFrame:CGRectMake(75, 76, WIDETH-75, 12)];
    self.position.font = [UIFont systemFontOfSize:12];
    self.position.textColor = UIColorFromRGB(0x000000);
    self.position.text = @"暂无";
    [self.contentView addSubview:self.position];
    //专业描述
    UILabel * descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 96, WIDETH-30, 12)];
    descriptionLable.text = @"专业描述";
    descriptionLable.font = [UIFont systemFontOfSize:12];
    descriptionLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:descriptionLable];
    self.departmentIntroduce = [[UILabel alloc] initWithFrame:CGRectMake(15, 118, WIDETH-30, 60)];
    self.departmentIntroduce.font = [UIFont systemFontOfSize:12];
    self.departmentIntroduce.textColor = UIColorFromRGB(0x000000);
    self.departmentIntroduce.text = @"暂无";
    [self.contentView addSubview:self.departmentIntroduce];
    
    EditdelegateView * editDelete = [[EditdelegateView alloc] initWithFrame:CGRectMake(WIDETH - 140, 178, 140, 35)];
    [self.contentView addSubview:editDelete];
    editDelete.ediBtn.tag = 10;
    editDelete.delgateBtn.tag = 11;
    [editDelete.ediBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
    [editDelete.delgateBtn addTarget:self action:@selector(editBtbClick:) forControlEvents:UIControlEventTouchUpInside];
     self.editDeleteView = editDelete;
}
-(void)editBtbClick:(UIButton*)sender
{
    self.editDeleteBlock(sender.tag,self.tag);
}
-(void)configVulue:(NSDictionary *)dataDic
{
   
    
    NSTimeInterval sdate = [dataDic[@"sdate"] doubleValue];
    NSTimeInterval edate = [dataDic[@"edate"] doubleValue];
    NSString * startTime = [Utils changeTimeToString:sdate];
    NSString * endTime = [Utils changeTimeToString:edate];
    self.educationTime.text = [NSString stringWithFormat:@"%@ - %@",startTime,endTime];
    self.department.text = dataDic[@"specialty"];
    self.schoolName.text = dataDic[@"name"];
    self.position.text = dataDic[@"title"];
    self.departmentIntroduce.text = dataDic[@"content"];
    //获得当前cell高度
    CGRect frame = [self frame];
    //文本赋值
//    self.departmentIntroduce.text = @"北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限北京蛋壳无限";
    //设置label的最大行数
    self.departmentIntroduce.numberOfLines = 0;
    CGSize size = CGSizeMake(300, 1000);
    CGSize labelSize = [self.departmentIntroduce.text sizeWithFont:self.departmentIntroduce.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
    self.departmentIntroduce.frame = CGRectMake(15, 116, WIDETH-30, labelSize.height);
    self.editDeleteView.frame = CGRectMake(WIDETH-140, 116+labelSize.height, 140, 35);
    //计算出自适应的高度
    frame.size.height = labelSize.height+116+40;
    
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
