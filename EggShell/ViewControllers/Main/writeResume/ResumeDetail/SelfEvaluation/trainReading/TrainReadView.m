//
//  TrainReadView.m
//  EggShell
//
//  Created by 李李贤军 on 15/9/11.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "TrainReadView.h"

@implementation TrainReadView

+(TrainReadView*)settrinView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"trainRead" owner:self options:nil] lastObject];
}
-(void)configValue:(WriteRusumeModel2*)model
{
//    ILabel *nameLable;
//    @property (weak, nonatomic) IBOutlet UILabel *trainingCentreLalbe;
//    @property (weak, nonatomic) IBOutlet UILabel *trailTimeLable;
//    @property (weak, nonatomic) IBOutlet UILabel *TrainingDirectionLable;
//    @property (weak, nonatomic) IBOutlet UITextView *trainingContentLable;
////    self.nameLab.text = model.name;
    
    self.trainingCentreLalbe.text = model.name;
    self.trailTimeLable.text = [model.sdate stringByAppendingFormat:@"-%@",model.edate];
    self.TrainingDirectionLable.text = model.position;
    self.trainingContentLable.text = model.content;

}
@end
