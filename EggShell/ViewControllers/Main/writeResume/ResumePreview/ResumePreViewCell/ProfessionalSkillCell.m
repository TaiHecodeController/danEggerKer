//
//  ProfessionalSkillCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/12/29.
//  Copyright © 2015年 wsd. All rights reserved.
//

#import "ProfessionalSkillCell.h"
#import "EditdelegateView.h"
@implementation ProfessionalSkillCell
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
//标题
    UILabel * professionalSkillHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 12)];
    professionalSkillHeadLable.text = @"技能名称:";
    professionalSkillHeadLable.font = [UIFont systemFontOfSize:12];
    professionalSkillHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:professionalSkillHeadLable];

    self.professionalSkill = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, WIDETH-90, 12)];
    self.professionalSkill.font = [UIFont systemFontOfSize:12];
    self.professionalSkill.textColor = UIColorFromRGB(0x000000);
    self.professionalSkill.text = @"暂无";
    [self.contentView addSubview:self.professionalSkill];
    //掌握时间
    UILabel * graspTimeHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 32, 60, 12)];
    graspTimeHeadLable.text = @"掌握时间:";
    graspTimeHeadLable.font = [UIFont systemFontOfSize:12];
    graspTimeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:graspTimeHeadLable];
    self.graspTime = [[UILabel alloc] initWithFrame:CGRectMake(75, 32, WIDETH-90, 12)];
    self.graspTime.font = [UIFont systemFontOfSize:12];
    self.graspTime.textColor = UIColorFromRGB(0x000000);
    self.graspTime.text = @"暂无";
    [self.contentView addSubview:self.graspTime];
    //熟练程度
    UILabel * skilledDegreeHeadLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 54, 60, 12)];
    skilledDegreeHeadLable.text = @"熟练程度:";
    skilledDegreeHeadLable.font = [UIFont systemFontOfSize:12];
    skilledDegreeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:skilledDegreeHeadLable];
    
    
    self.skilledDegrees =[[UILabel alloc] initWithFrame:CGRectMake(75, 54, WIDETH-90, 12)];
    self.skilledDegrees.text = @"暂无";
    self.skilledDegrees.font = [UIFont systemFontOfSize:12];
    self.skilledDegrees.textColor = UIColorFromRGB(0x000000);
    [self.contentView addSubview:self.skilledDegrees];
    //技能名称
    UILabel * skillNameHeadlablable =[[UILabel alloc] initWithFrame:CGRectMake(15, 76, 60, 12)];
    skillNameHeadlablable.text = @"技能名称:";
    skillNameHeadlablable.font = [UIFont systemFontOfSize:12];
    skillNameHeadlablable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:skillNameHeadlablable];
    self.skillName = [[UILabel alloc] initWithFrame:CGRectMake(75, 76, WIDETH-90, 12)];
    self.skillName.font = [UIFont systemFontOfSize:12];
    self.skillName.textColor = UIColorFromRGB(0x000000);
    self.skillName.text = @"暂无";
    [self.contentView addSubview:self.skillName];
    

    EditdelegateView * editDelete = [[EditdelegateView alloc] initWithFrame:CGRectMake(WIDETH - 140, 90, 140, 35)];
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
-(void)conFigValue:(NSDictionary *)dataDic
{
   
  self.professionalSkill.text = dataDic[@"skill"];
    self.graspTime.text = [NSString stringWithFormat:@"%@",dataDic[@"longtime"]];
    self.skilledDegrees.text = dataDic[@"ing"];
    self.skillName.text = [NSString stringWithFormat:@"%@",dataDic[@"name"]];
    //获得当前cell高度
    CGRect frame = [self frame];
    //计算出自适应的高度
    frame.size.height = 125;

    self.frame = frame;

    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
