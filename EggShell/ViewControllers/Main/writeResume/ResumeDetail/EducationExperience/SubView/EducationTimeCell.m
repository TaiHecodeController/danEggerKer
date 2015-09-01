//
//  EducationTimeCell.m
//  EggShell
//
//  Created by 李李贤军 on 15/8/15.
//  Copyright (c) 2015年 wsd. All rights reserved.
//

#import "EducationTimeCell.h"
#import "AppDelegate.h"
@interface EducationTimeCell()
{
    NSString * dateStr;
    UIButton * record_btn;
    UIView * backView;
    UIButton * ok;
    
}
@property (strong,nonatomic)UIDatePicker * dataPicker;
@end

@implementation EducationTimeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startTimeClick:(UIButton *)sender {
    [self createDataPickView];
    record_btn = sender;
}

- (IBAction)endTimeClick:(UIButton *)sender {
    if(!self.startTime.selected)
    {
        [MBProgressHUD creatembHub:@"请选择开始时间"];
        return;
    }
    [self createDataPickView];
    record_btn = sender;
}
- (IBAction)todayClick:(UIButton *)sender {
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateStr = [dateFormatt stringFromDate:localDate];
    sender.selected = !sender.selected;
    [self.endTime setTitle:dateStr forState:UIControlStateSelected];
    self.endTime.selected = YES;
}

-(void)createDataPickView
{
    
    backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    [[AppDelegate instance].window addSubview:backView];
    //创建picker
    self.dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, HEIGHT, WIDETH, HEIGHT / 2 - 80)];
    self.dataPicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [[AppDelegate instance].window addSubview:self.dataPicker];
    [self.dataPicker addTarget:self action:@selector(dataChanged:) forControlEvents:UIControlEventValueChanged];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置显示为中文
    self.dataPicker.locale = locale;
    self.dataPicker.datePickerMode = UIDatePickerModeDate;
    //当前时间创建NSDate
    NSDate * localDate = [NSDate date];
    //设置时间
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    NSDate * minDate = [dateFormatt dateFromString:@"1910-1-1"];
    
    //设置属性
    self.dataPicker.maximumDate = localDate;
    self.dataPicker.minimumDate = minDate;
    
    ok = [ZCControl createButtonWithFrame:CGRectMake(WIDETH - 40, HEIGHT, 40, 30) ImageName:@"" Target:self Action:@selector(okClick) Title:@"确定"];
    self.dataPicker.userInteractionEnabled = YES;
    [ok setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[AppDelegate instance].window addSubview:ok];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.dataPicker.frame = CGRectMake(0, HEIGHT / 2 + 80, WIDETH, HEIGHT / 2 - 80);
        ok.frame = CGRectMake(WIDETH - 40, HEIGHT - 80, 40, 30);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)okClick
{
    [backView removeFromSuperview];
    
    [self.dataPicker removeFromSuperview];
    
    [ok removeFromSuperview];
    if(dateStr == nil)
    {
        NSDate * localDate = [NSDate date];
        //设置时间
        NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
        [dateFormatt setDateFormat:@"yyyy-MM-dd"];
        dateStr = [dateFormatt stringFromDate:localDate];
    }
    [record_btn setTitle:dateStr forState:UIControlStateSelected];
    record_btn.selected = YES;
}

-(void)dataChanged:(UIDatePicker *)sender
{
    NSDateFormatter * dateFormatt = [[NSDateFormatter alloc] init];
    [dateFormatt setDateFormat:@"yyyy-MM-dd"];
    dateStr = [dateFormatt stringFromDate:sender.date];
}


@end
