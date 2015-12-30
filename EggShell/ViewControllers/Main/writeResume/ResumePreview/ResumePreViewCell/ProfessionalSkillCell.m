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
{
//标题
    self.professionalSkill = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, WIDETH-30, 12)];
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
    skilledDegreeHeadLable.text = @"掌握时间:";
    skilledDegreeHeadLable.font = [UIFont systemFontOfSize:12];
    skilledDegreeHeadLable.textColor = UIColorFromRGB(0x646464);
    [self.contentView addSubview:skilledDegreeHeadLable];
    self.skilledDegree =[[UILabel alloc] initWithFrame:CGRectMake(75, WIDETH-90, 54, 12)];
    self.skilledDegree.font = [UIFont systemFontOfSize:12];
    self.skilledDegree.textColor = UIColorFromRGB(0x000000);
    self.skilledDegree.text = @"暂无";
    [self.contentView addSubview:self.skilledDegree];
    //技能名称
    UILabel * skillNameHeadlablable =[[UILabel alloc] initWithFrame:CGRectMake(15, 76, 60, 12)];
    skillNameHeadlablable.text = @"熟练程度:";
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
    self.editDeleteBlock(sender.tag);
}
-(void)conFigValue:(NSArray *)dataArray withArrIndex:(int)i
{
//    if(dataArray.count == 0)
//    {
//        return;
//    }
//    //    NSDictionary * dataDic = [dataArray firstObject];
//    NSDictionary * dataDic  = dataArray[i];
//    if(dataDic.count == 0)
//    {
//        return;
//    }
//    self.professionalSkill.text = dataDic[@"skill"];
//    self.graspTime.text = dataDic[@"longtime"];
//    self.skilledDegree.text = dataDic[@"ing"];
//    self.skillName.text = dataDic[@"name"];
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
